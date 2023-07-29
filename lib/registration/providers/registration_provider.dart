import 'package:flutter/foundation.dart';
import 'package:student_registeration_system/registration/models/student.dart';
import 'package:student_registeration_system/registration/services/student_db_services.dart';

class RegistrationProvider extends ChangeNotifier {
  Student student = Student();

  Future<void> getStudent() async {
    student = (await StudentsDbService().getStudentById(null))!;
    notifyListeners();
  }
}
