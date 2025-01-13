import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
Stream<QuerySnapshot>  readProfiles(){
  return FirebaseFirestore.instance.collection("profile").snapshots();
}

Future createProfiles({required Map<String,dynamic>data})async{
  await FirebaseFirestore.instance.collection("profile").add(data);
}
Future updateProfiles({required String doId,required Map<String,dynamic>data})async{
  await FirebaseFirestore.instance.collection("profile").doc(doId).update(data);

}
Future deleteProfiles({required String doId})async{
  await FirebaseFirestore.instance.collection("profile").doc(doId).delete();
}

}