import 'package:mongo_dart/mongo_dart.dart';

class DbConstants {
  static String dbUrl = "";

  static Db? db;
  static final DbCollection groups = db!.collection("groups");
  static final DbCollection users = db!.collection("users");

  static Future<void> connect() async {
    db = await Db.create(DbConstants.dbUrl);
    await db!.open();
  }
}
