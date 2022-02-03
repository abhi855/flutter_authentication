import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

  final String uid;
  Database({  this.uid =''});
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('brewcrew');

  Future updateUserData(String sugar,String name,int strength) async {
    print('DATABASE');
    return await collectionReference.doc(uid).set({
      'sugar' : sugar,
      'name' : name,
      'strength' : strength
    }
    ).then((value) => print("User added")).
    catchError((error)=>print(error.toString()));
  }
  Stream<QuerySnapshot> get brew { return collectionReference.snapshots();}
}