import 'nosql_service.dart';

class RootService{
  static Future<void> init() async{
    await Future.wait([
      NoSqlService.init(),
    ]);

  }
}