import 'package:cloud_firestore/cloud_firestore.dart';
    
Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getUsersFireBase() async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;     
  return firestore.collection('users').snapshots();
} 

Future<void> printUsersFireBase() async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;  

  //firestore.collection('users').where('id', isEqualTo: "53").snapshots().listen((QuerySnapshot snapshot) 
  firestore.collection('users').snapshots().listen((QuerySnapshot snapshot) 
  {
    for (var doc in snapshot.docs) 
    {
      print(doc.data());
    }
  });
}

Future<DocumentSnapshot?> getUserFireBase(String psId) async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;
  
  QuerySnapshot snapshot = await firestore.collection('users').where('id', isEqualTo: psId).get();
  return snapshot.docs.isNotEmpty ? snapshot.docs.first : null;
    
  //DocumentSnapshot doc = await firestore.collection("users").doc("user_$psId").get();
  //return doc.exists ? doc : null;
}

Future<void> addUserFireBase(String psId, String psName, String psEmail) async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;
  await firestore.collection("users").doc("user_$psId").set
  ({
    'id': psId,
    'name': psName,
    'email': psEmail,
  });
}

Future<void> updateUserFireBase(String psId, String psName, String psEmail) async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;
  await firestore.collection("users").doc("user_$psId").update
  ({
    'name': psName,
    'email': psEmail,
  });
}

Future<void> deleteUserFireBase(String psId) async
{
  FirebaseFirestore firestore  = FirebaseFirestore.instance;  
  await firestore.collection("users").doc("user_$psId").delete();
}