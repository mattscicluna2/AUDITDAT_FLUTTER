import 'package:auditdat/db/seeder/inspection_status_seeder.dart';

class AuditdatSeeders {
  run() async {
    await InspectionStatusSeeder().run();
  }
}
