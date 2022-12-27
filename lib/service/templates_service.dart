import 'dart:convert';
import 'dart:developer';

import 'package:auditdat/common/utilities.dart';
import 'package:auditdat/constants/app_constants.dart';
import 'package:auditdat/db/auditdat_database.dart';
import 'package:auditdat/db/model/sync_last_updated.dart';
import 'package:auditdat/db/model/template_category.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/model/template_component.dart';
import 'package:auditdat/db/model/template_field.dart';
import 'package:auditdat/db/model/template_field_type.dart';
import 'package:auditdat/db/model/template_page.dart';
import 'package:auditdat/db/model/template_response.dart';
import 'package:auditdat/db/model/template_response_group.dart';
import 'package:auditdat/db/model/template_section.dart';
import 'package:auditdat/db/model/template_version.dart';
import 'package:auditdat/db/repo/sync_last_updated_repo.dart';
import 'package:auditdat/db/repo/template_check_repo.dart';
import 'package:auditdat/db/repo/template_component_repo.dart';
import 'package:auditdat/db/repo/template_field_repo.dart';
import 'package:auditdat/db/repo/template_field_type_repo.dart';
import 'package:auditdat/db/repo/template_page_repo.dart';
import 'package:auditdat/db/repo/template_response_group_repo.dart';
import 'package:auditdat/db/repo/template_response_repo.dart';
import 'package:auditdat/db/repo/template_section_repo.dart';
import 'package:auditdat/db/repo/template_version_repo.dart';
import 'package:auditdat/dto/TemplateDto.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

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

      log(url);

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

  Future<bool> getTemplateData(
      BuildContext context, TemplateVersion version) async {
    if (await Utilities.hasInternet()) {
      String url =
          '${AppConstants.getEndpointUrl()}/api/auditdat/v1/sync/templateVersion/${version.id}';

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
        var data = decodedResponse['data'];
        Database db = await AuditdatDatabase.instance.database;

        data['pages'].forEach((page) async {
          log(page['name']);
          TemplatePage savedPage = await TemplatePageRepo.instance.create(
              TemplatePage(
                  id: page['id'],
                  templateVersionId: page['template_version_id'],
                  name: page['name'],
                  mainPage: page['main_page'] == 1,
                  index: page['index']));

          page['components'].forEach((component) async {
            TemplateComponent savedComponent =
                await TemplateComponentRepo.instance.create(TemplateComponent(
                    id: component['id'],
                    templateVersionId: component['template_version_id'],
                    pageId: savedPage.id,
                    parentSectionId: component['parent_section_id'],
                    sectionId: component['section_id'],
                    checkId: component['check_id'],
                    fieldId: component['field_id'],
                    note: component['note'],
                    index: component['order']));

            if (savedComponent.checkId != null) {
              await TemplateCheckRepo.instance.create(TemplateCheck(
                  id: component['check']['id'],
                  name: component['check']['check'],
                  responseGroupId: component['check']['response_group_id'],
                  required: component['check']['required'] == 1 ? true : false,
                  mediaRequired: component['check']['media_required'] == 1
                      ? true
                      : false));

              //Save responses if not already there
              TemplateResponseGroup savedGroup = await TemplateResponseGroupRepo
                  .instance
                  .create(TemplateResponseGroup(
                      id: component['check']['response_group']['id']));

              component['check']['response_group']['responses']
                  .forEach((response) async {
                await TemplateResponseRepo.instance.create(TemplateResponse(
                    id: response['id'],
                    groupId: savedGroup.id,
                    response: response['response'],
                    colour: response['colour'],
                    fail: response['fail'] == 1 ? true : false,
                    score: response['score'],
                    index: response['order']));
              });
            } else if (savedComponent.fieldId != null) {
              await TemplateFieldRepo.instance.create(TemplateField(
                  id: component['field']['id'],
                  name: component['field']['name'],
                  typeId: component['field']['type_id'],
                  required: component['field']['required'] == 1 ? true : false,
                  mediaRequired: component['field']['media_required'] == 1
                      ? true
                      : false));

              await TemplateFieldTypeRepo.instance.create(TemplateFieldType(
                  id: component['field']['type']['id'],
                  name: component['field']['type']['type']));
            } else if (savedComponent.sectionId != null) {
              await TemplateSectionRepo.instance.create(TemplateSection(
                  id: component['section']['id'],
                  name: component['section']['name'],
                  repeat: component['section']['repeat'] == 1 ? true : false));
            } else if (savedComponent.parentSectionId != null) {
              await TemplateSectionRepo.instance.create(TemplateSection(
                  id: component['parentSection']['id'],
                  name: component['parentSection']['name'],
                  repeat: component['parentSection']['repeat'] == 1
                      ? true
                      : false));
            }
          });
        });

        await TemplateVersionRepo.instance
            .update(version.copy(downloaded: true));

        return true;
      }
    } else {
      // Utilities.showToast(
      //     context: context,
      //     message: 'An internet connection is required to perform this action.',
      //     icon: FontAwesomeIcons.exclamation,
      //     backgroundColor: ColorConstants.danger,
      //     toastGravity: ToastGravity.BOTTOM);
    }

    return false;
  }
}
