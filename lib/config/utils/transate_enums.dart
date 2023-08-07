import 'package:student_registeration_system/config/enums/enums.dart';

String getAccountState(AccountState accountState) {
  switch (accountState) {
    case AccountState.active:
      return 'تفعيل';
    case AccountState.pending:
      return 'تعليق';
    case AccountState.frozen:
      return 'تحميد';
  }
}

String getStudyState(StudyState studyState) {
  switch (studyState) {
    case StudyState.newStudent:
      return 'مستجد';
    case StudyState.zeroFail:
      return 'راسب ولا مرة';

    case StudyState.failOnce:
      return 'راسب مرة';

    case StudyState.failTwice:
      return 'راسب مرتين';
  }
}
