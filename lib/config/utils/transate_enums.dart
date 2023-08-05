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
