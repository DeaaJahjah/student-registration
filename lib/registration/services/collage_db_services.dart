import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_registeration_system/registration/models/collage.dart';

class CollageDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Collage>> getCollages() async {
    List<Collage> collages = [];
    var query = await _db.collection('colleges').get();

    for (var doc in query.docs) {
      print(doc);
      collages.add(Collage.fromFirestore(doc));
    }
    return collages;
  }
}
