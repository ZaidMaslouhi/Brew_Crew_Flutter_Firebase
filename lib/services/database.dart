import 'package:brew_crew_firebase/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew_firebase/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection references
  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Brew Listfrom Snapshot (the unserscore '_' in function name = private)
  List<Brew> _brewsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '', // '??' if it dosen't exist give it ''
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  // Get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewsListFromSnapshot);
  }

  // User Data From the Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  // Get User Doc Stream
  Stream<UserData> get userData =>
      brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}
