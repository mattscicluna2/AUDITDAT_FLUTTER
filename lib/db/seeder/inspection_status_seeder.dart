import 'package:auditdat/db/model/inspection_status.dart';
import 'package:auditdat/db/repo/inspection_status_repo.dart';

class InspectionStatusSeeder {
  run() {
    List<InspectionStatus> statuses = [
      const InspectionStatus(id: 1, name: 'New', colour: '#6c757d'),
      const InspectionStatus(id: 2, name: 'Published', colour: '#5e2ced'),
      const InspectionStatus(id: 3, name: 'In Progress', colour: '#ffc107'),
      const InspectionStatus(
          id: 4, name: 'Ready To Publish', colour: '#28a745'),
    ];

    statuses.forEach((element) async {
      await InspectionStatusRepo.instance.create(element);
    });
  }
}
