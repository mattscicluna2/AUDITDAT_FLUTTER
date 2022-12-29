import 'package:auditdat/db/model/inspection.dart';
import 'package:auditdat/db/model/inspection_status.dart';
import 'package:auditdat/db/repo/inspection_repo.dart';
import 'package:auditdat/db/repo/inspection_status_repo.dart';
import 'package:auditdat/service/inspection_checks_service.dart';

class InspectionsService {
  static final InspectionsService instance = InspectionsService._init();
  InspectionsService._init();

  Future<Inspection> insert(int templateVersionId) async {
    return await InspectionRepo.instance.create(Inspection(
        templateVersionId: templateVersionId,
        statusId: (await InspectionStatusRepo.instance
                .getByName(InspectionStatuses.NEW))!
            .id,
        createdAt: DateTime.now().millisecondsSinceEpoch));
  }

  delete(int inspectionId) async {
    Inspection? inspection = await InspectionRepo.instance.get(inspectionId);

    if (inspection != null) {
      await InspectionChecksService.instance.deleteAll(inspection.id!);
      await InspectionRepo.instance.delete(inspection.id!);
    }
  }
}
