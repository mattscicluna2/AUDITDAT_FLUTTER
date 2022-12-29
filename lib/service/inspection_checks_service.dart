import 'package:auditdat/db/model/inspection_check.dart';
import 'package:auditdat/db/model/template_check.dart';
import 'package:auditdat/db/repo/inspection_check_repo.dart';

class InspectionChecksService {
  static final InspectionChecksService instance =
      InspectionChecksService._init();
  InspectionChecksService._init();

  Future<InspectionCheck> getCreate(
      int inspectionId, TemplateCheck templateCheck) async {
    InspectionCheck? inspectionCheck =
        await InspectionCheckRepo.instance.get(inspectionId, templateCheck.id);

    inspectionCheck ??= await InspectionCheckRepo.instance.create(
        InspectionCheck(
            inspectionId: inspectionId,
            templateCheckId: templateCheck.id,
            notApplicable: !templateCheck.required,
            createdAt: DateTime.now().millisecondsSinceEpoch));

    return inspectionCheck;
  }

  deleteAll(int inspectionId) async {
    return await InspectionCheckRepo.instance
        .deleteInspectionChecks(inspectionId);
  }
}
