import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String nummerplade, String indrapporter) async {
    try {
      await firestore.collection("biler").add({
        'nummerplade': nummerplade,
        'indrapporter': indrapporter,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("biler").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

 Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
      await firestore.collection('biler').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "nummerplade": doc['nummerplade'], "indrapporter": doc["indrapporter"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return read();
  }


  Future<void> update(String id, String nummerplade, String indrapporter) async {
    try {
      await firestore
          .collection("biler")
          .doc(id)
          .update({'nummerplade': nummerplade, 'indrapporter': indrapporter});
    } catch (e) {
      print(e);
    }
  }
}
