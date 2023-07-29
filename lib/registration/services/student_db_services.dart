import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/features/home/screens/home_screen.dart';
import 'package:student_registeration_system/registration/models/collage.dart';
import 'package:student_registeration_system/registration/models/student.dart';

import '../providers/registration_provider.dart';

class StudentsDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<List<Student>> getStudents() async {
    List<Student> students = [];
    var query = await _db.collection('students').get();

    for (var doc in query.docs) {
      students.add(Student.fromFirestore(doc));
    }
    return students;
  }

  creatUser({required Student student, required context}) async {
    try {
      await _db.collection('students').doc(firebaseUser!.uid).set(student.toJson());

      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<Student?> getStudentById(String? id) async {
    var doc = await _db.collection('students').doc(id ?? firebaseUser!.uid).get();
    if (doc.exists) {
      return Student.fromFirestore(doc);
    }

    return null;
  }

  Future<bool> checkRegisterIsActive(BuildContext context) async {
    var doc = await _db.collection('collage').doc(context.read<RegistrationProvider>().student.collageId).get();
    if (doc.exists) {
      final collage = Collage.fromFirestore(doc);

      return collage.activeRegistrationForNewYear;
    }

    return false;
  }
}
