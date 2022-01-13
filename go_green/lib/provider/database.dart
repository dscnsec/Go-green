// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');

class DataBase extends ChangeNotifier {
   static String? userUid;
   static String? name;
   static Map<String, bool> taskList={};
   static int totalScore=0;
   static String currentDate='';

//  static bool taskUploadStatus=false;
  /*static getUid() async {
    FirebaseAuth.instance.authStateChanges().listen((user) { userUid= user?.uid; });
  }*/

  readTotalScore(){
    return totalScore;
  }

   Future<void> addListNewUser() async{
    print(userUid);
    DocumentReference documentReference = _mainCollection.doc(userUid);
    //converting json to map  
    var jsonTaskList = await http.get(Uri.parse("https://firebasestorage.googleapis.com/v0/b/go-green-8868a.appspot.com/o/go-green-tasks2.json?alt=media&token=34de5b20-eb70-4b73-9f61-6cd1fbb06bbd"));
    var decTaskList= jsonDecode(jsonTaskList.body);

    Map<String, bool> convertedTaskList={};
    decTaskList.forEach((index)=> convertedTaskList[index['task-name']]= index['completed']);

   //print(decTaskList);

   await documentReference.set({'tasklist':convertedTaskList}).whenComplete(() => print("tasklist uploaded")).catchError((error) => print(error));
   await documentReference.update({'score':0});
   await documentReference.update({'name': FirebaseAuth.instance.currentUser?.displayName});
   }
  
   Future<Map<String, dynamic>> readTasksList() async{
    print("uid inside readTasksList : $userUid");
    DocumentReference userDoc = _mainCollection.doc(userUid);
    final docSnap=await userDoc.get().whenComplete(() => {print("tasklist downloaded")});
    if(docSnap.exists){
      print("Document data: ${docSnap.data()}");
    }
    else {
      print("No such document");
    }
    if(docSnap.data()==null) 
    {
      await addListNewUser();
      return readTasksList();
    }
   return docSnap.data() as Map<String, dynamic>;
  }

   Future<void> updateTask({required String taskName, bool? status, int updateScoreBy=0})async {
    updateLocalTaskAndScore(taskName: taskName, status: status, updateScoreBy: updateScoreBy);

    DocumentReference documentReference= _mainCollection.doc(userUid);

    documentReference.set({'tasklist':{taskName:status}}, SetOptions(merge: true));
    documentReference.update({'score':totalScore});
  }

   updateLocalTaskAndScore({required String taskName, bool? status, int updateScoreBy=0}){
    totalScore+=updateScoreBy;
    taskList[taskName]=status!;
    
    LocalDatabase localdb=LocalDatabase();
    localdb.initDB().whenComplete(() {
      localdb.updateUser();
      localdb.updateTask(taskName, status);
      }
    );

    notifyListeners();
  }

   UploadTask? uploadFile(String destination, File file)  {
    /*if(file==null) return;

    final fileName = basename(file.path);
    final destination = 'UserUploads/$userUid/$fileName';
    */
    try{
    final ref= FirebaseStorage.instance.ref(destination) ;

     return ref.putFile(file);
    }
    on FirebaseException {
      return null;
    }

    
  }

   }

//local sqlite database
class LocalDatabase extends ChangeNotifier{

  var db;
  
  void fromMapUser(Map<String, dynamic> res){
     DataBase.userUid = res["id"];
     DataBase.name = res["name"];
     DataBase.totalScore = res["totalScore"];
     DataBase.currentDate=res["taskFetchDate"];
  }

  Map<String, dynamic> toMapUser(){
    return {'id': "${DataBase.userUid}", 'name': "${DataBase.name}", 'totalScore': DataBase.totalScore, 'taskFetchDate': DataBase.currentDate};
  }

   Future<void> initDB()  async{
     String path = await getDatabasesPath();
      db= await openDatabase(
       join(path, 'local_user.db'),
       onCreate: (database, version) async{
         await database.execute(
          """
            CREATE TABLE users (
              id TEXT NOT NULL,
              name TEXT NOT NULL,
              totalScore INTEGER NOT NULL,
              taskFetchDate TEXT NOT NULL
            );
          """
          );
          await database.execute(
          """
            CREATE TABLE tasklist (
              taskName TEXT NOT NULL,
              status INTEGER NOT NULL CHECK (status IN (0,1))
            );
          """
         );
       },
       version: 1,
     );
     
   }
  
  //user related operations
  Future<void> insertUser() async{
    await db.insert('users', toMapUser(), conflictAlgorithm: ConflictAlgorithm.replace);
    //await db.rawInsert("""INSERT OR REPLACE INTO users (id, name, totalScore) VALUES ('${DataBase.userUid}', '${DataBase.name}', ${DataBase.totalScore}); """);
    var localUser=await db.query('users');
    debugPrint("local user inside insertUser: $localUser");
  }

  Future<void> updateUser() async{
    await db.update('users', toMapUser(), where: "id = ?", whereArgs: ["${DataBase.userUid}"]);
    var localUser=await db.query('users');
    debugPrint("local user inside updateUser: $localUser");
  }

  Future<void> retrieveUser() async{
    final List<Map<String, dynamic>> queryResult = await db.query('users');
    debugPrint("local user inside retrieveUser : $queryResult");
    for (var element in queryResult) {fromMapUser(element);}
  }

  Future<void> deleteUser() async{
    await db.delete('users');
  }
  
  //task related operations
  Future<void> insertTask(Map<String, bool> tasklist)async {
    tasklist.forEach((key, value) {db.insert('tasklist', {'taskName': key, 'status': value?1:0 }, conflictAlgorithm: ConflictAlgorithm.replace);});
    final List<Map<String, dynamic>> queryResult = await db.query('tasklist');
    debugPrint("local database tasklist inside insertTask: $queryResult");
  }

  Future<void> updateTask(String taskName, bool status) async {
    await db.update('tasklist', {'taskName': taskName, 'status': status?1:0}, where: "taskName = ?", whereArgs: [taskName]);
    final List<Map<String, dynamic>> queryResult = await db.query('tasklist');
    debugPrint("local database tasklist inside updateTask: $queryResult");
  }

  Future<void> retrieveTaskList() async{
    final List<Map<String, dynamic>> queryResult = await db.query('tasklist');
    debugPrint("local database tasklist inside retrieveTask: $queryResult");
    for (var element in queryResult) {
      DataBase.taskList[element['taskName']]=element['status']==1?true:false;
    }

  }

  Future<void> deleteTaskList() async{
    await db.delete('tasklist');
  }
}
 