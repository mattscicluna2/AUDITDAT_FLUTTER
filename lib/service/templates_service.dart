import 'dart:convert';
import 'dart:developer';

import 'package:auditdat/common/utilities.dart';
import 'package:auditdat/constants/app_constants.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';
import 'package:auditdat/dto/TemplateDto.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TemplatesService {
  static final TemplatesService instance = TemplatesService._init();
  TemplatesService._init();

  Future<List<TemplateVersion>> sync(
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

      Map<String, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse['success']) {
        TemplateDto.decode(jsonEncode(decodedResponse['data']['templates']))
            .forEach((template) async {
          log(template.currentVersion.name);
          log(template.currentVersion.version);

          if (template.deleted) {
            await TemplateVersionRepo.instance.delete(template.id);
          } else {
            await TemplateVersionRepo.instance.create(TemplateVersion(
                id: template.currentVersion.id,
                templateId: template.id,
                categoryId: template.categoryId,
                name: template.currentVersion.name,
                version: template.currentVersion.version));
          }
          log(template.currentVersion.name);
        });

        List<int> hasAccessToIds =
            List<int>.from(decodedResponse['data']['hasAccessTo']);

        await TemplateVersionRepo.instance
            .deleteAllNotInListOfCategory(category.id, hasAccessToIds);

        await SyncLastUpdatedRepo.instance.create(SyncLastUpdated(
            name: 'category/${category.id}/templates',
            lastUpdated: '${DateTime.now().toString()}Z'));

        return TemplateVersionRepo.instance.getAllByCategory(category.id);
      }
    } else {
      // Utilities.showToast(
      //     context: context,
      //     message: 'An internet connection is required to perform this action.',
      //     icon: FontAwesomeIcons.exclamation,
      //     backgroundColor: ColorConstants.danger,
      //     toastGravity: ToastGravity.BOTTOM);
    }

    return TemplateVersionRepo.instance.getAllByCategory(category.id);
  }
}
