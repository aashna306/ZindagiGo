import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  final String mongoUrl = "mongodb+srv://Care_Code:Care_Code_Our_1st_project@cluster0.icqav.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
  final String dbName = "test";
  final String collectionName = "users";

  Future<bool> checkIfEmailExists(String email) async {
    var db = await Db.create(mongoUrl);
    await db.open();
    
    var collection = db.collection(collectionName);
    var user = await collection.findOne({"email": email});

    await db.close();
    
    return user != null; // True if user exists, False otherwise
  }
}
