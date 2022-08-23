import 'dart:convert';

import 'package:auditdat/common/utilities.dart';
import 'package:auditdat/constants/app_constants.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_category_repo.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class TemplatesService {
  static final TemplatesService instance = TemplatesService._init();
  TemplatesService._init();

  Future<List<TemplateCategory>> sync(
      BuildContext context, TemplateCategory category) async {
    if (await Utilities.hasInternet()) {
      SyncLastUpdated? syncLastUpdated = await SyncLastUpdatedRepo.instance
          .get("category/${category.id}/templates");
      String url = syncLastUpdated != null
          ? '${AppConstants.getEndpointUrl()}/api/auditdat/v1/sync/categoryTemplates/${category.id}?lastUpdated=${syncLastUpdated.lastUpdated}'
          : '${AppConstants.getEndpointUrl()}/api/auditdat/v1/sync/categoryTemplates/${category.id}';

      http.Response response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await AuthService.instance.getToken()}'
        },
      );

      log("Templates Sync");
      log(response.body);
      Map<String, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse['success']) {
        // TemplateCategory.decode(jsonEncode(decodedResponse['data'])).forEach((category) async {
        //   if(category.deleted!){
        //     await TemplateCategoryRepo.instance.delete(category.id);
        //   }else{
        //     await TemplateCategoryRepo.instance.create(category);
        //   }
        //   log(category.name);
        // });

        await SyncLastUpdatedRepo.instance.create(SyncLastUpdated(
            name: 'category/${category.id}/templates',
            lastUpdated: '${DateTime.now().toString()}Z'));

        return TemplateCategoryRepo.instance.getAll();
      }
    } else {
      Utilities.showToast(
          context: context,
          message: 'An internet connection is required to perform this action.',
          icon: FontAwesomeIcons.exclamation,
          backgroundColor: ColorConstants.danger,
          toastGravity: ToastGravity.BOTTOM);
    }

    return TemplateCategoryRepo.instance.getAll();
  }
}
