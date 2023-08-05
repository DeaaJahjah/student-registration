import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/admin_home/services/data_source.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/registration/models/student.dart';
import 'package:student_registeration_system/registration/services/student_db_services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentDashboardScreen extends StatefulWidget {
  static const routeName = '/student-dashboard';
  const StudentDashboardScreen({
    super.key,
  });

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [Text('الطلاب الجدد'), Text('الطلاب القدامى')]),
          ),
          body: TabBarView(children: [
            BuildStudents(
              state: AccountState.pending,
            ),
            BuildStudents(
              state: AccountState.active,
            ),
          ]),
        ),
      ),
    );
  }
}

class BuildStudents extends StatelessWidget {
  BuildStudents({super.key, required this.state, this.onCellTap});
  final AccountState state;
  void Function(DataGridCellTapDetails)? onCellTap;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<List<Student>>(
          future: StudentsDbService().getStudents(accountState: state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(snapshot.error.toString(),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)));
            }
            return SfDataGrid(
              allowPullToRefresh: true,
              // allowSorting: true,
              source: EmployeeDataSource(students: snapshot.data!),
              rowHeight: 80,
              allowColumnsResizing: true,
              onCellTap: onCellTap,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'الرقم الجامعي',
                        ))),
                GridColumn(
                    columnName: 'name',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: const Text('الاسم'))),
                GridColumn(
                    columnName: 'fatherName',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text('اسم الأب'))),
                GridColumn(
                    columnName: 'motherName',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text('اسم الأم'))),
                GridColumn(
                    columnName: 'phoneNumber',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text('رقم الهاتف'))),
                GridColumn(
                    columnName: 'area',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text(' الهاتف'))),
                GridColumn(
                    columnName: 'acceptanceType',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text('نوع القبول'))),
                GridColumn(
                    columnName: 'nationality',
                    // width: 150,
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text('الجنسية'))),
                // if (state == AccountState.pending)
                GridColumn(
                    columnName: '',
                    width: 200,
                    label: Container(
                        // padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerRight,
                        child: const Text(''))),
              ],
            );
          }),
    );
  }
}

// checkboxColumnSettings: const DataGridCheckboxColumnSettings(showCheckboxOnHeader: true),
// onCellTap: (details) {
//   if (details.rowColumnIndex.rowIndex != 0) {
// int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
// var row = EmployeeDataSource(employees: students).effectiveRows.elementAt(selectedRowIndex);

// showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
//         content: SizedBox(
//           height: 300,
//           width: 300,
//           child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Row(children: [
//               const Text('Employee ID'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
//               const Text(':'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//               Text(row.getCells()[0].value.toString()),
//             ]),
//             Row(children: [
//               const Text('Employee Name'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//               const Text(':'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//               Text(row.getCells()[1].value.toString()),
//             ]),
//             Row(children: [
//               const Text('Designation'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
//               const Text(':'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//               Text(row.getCells()[2].value.toString()),
//             ]),
//             Row(children: [
//               const Text('Salary'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 45)),
//               const Text(':'),
//               const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
//               Text(row.getCells()[3].value.toString()),
//             ]),
//             SizedBox(
//               width: 300,
//               child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("OK")),
//             )
//           ]),
//         )));
//   }
// },
