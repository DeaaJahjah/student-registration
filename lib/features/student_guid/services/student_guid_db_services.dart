import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_registeration_system/features/student_guid/models/student_guid.dart';

class StudentGuidDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<StudentGuid>> getStudentGuid() async {
    List<StudentGuid> guids = [];
    var query = await _db.collection('studentsGuid').get();

    for (var doc in query.docs) {
      guids.add(StudentGuid.fromFirestore(doc));
    }
    return guids;
  }
}
