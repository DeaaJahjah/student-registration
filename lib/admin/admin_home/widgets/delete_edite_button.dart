import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/config/theme/theme.dart';
import 'package:student_registeration_system/features/registration/services/student_db_services.dart';

class DeleteEditButton extends StatelessWidget {
  // final void Function()? onReject;
  // final void Function()? onAprove;
  final String studentId;
  const DeleteEditButton({
    super.key,
    required this.studentId,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            QuickAlert.show(
                context: context,
                customAsset: 'assets/images/confirm.gif',
                type: QuickAlertType.confirm,
                text: 'هل انت متأكدمن قبول الطالب؟',
                confirmBtnText: 'نعم',
                cancelBtnText: 'لا',
                confirmBtnColor: primaryColor,
                onConfirmBtnTap: () async {
                  Navigator.pop(context);
                  await StudentsDbService().updateAccountState(context, studentId, AccountState.active);
                });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
                color: primaryColor,
                boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
            child: Text(
              'قبول',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        // const SizedBox(width: 10),
        // InkWell(
        //   onTap: () {
        //     QuickAlert.show(
        //         context: context,
        //         customAsset: 'assets/images/confirm.gif',
        //         type: QuickAlertType.confirm,
        //         text: 'هل انت متأكدمن رفض الطالب؟',
        //         confirmBtnText: 'نعم',
        //         cancelBtnText: 'لا',
        //         confirmBtnColor: primaryColor,
        //         onConfirmBtnTap: () async {
        //           Navigator.pop(context);
        //           await StudentsDbService().updateAccountState(context, studentId, AccountState.active);
        //         });
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //     decoration: const BoxDecoration(
        //         color: secondaryColor,
        //         boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
        //     child: Text(
        //       'رفض',
        //       style: Theme.of(context).textTheme.bodySmall,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
