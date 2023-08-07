import 'package:flutter/material.dart';
import 'package:student_registeration_system/admin/admin_home/widgets/delete_edite_button.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/features/registration/models/student.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Student> students}) {
    _students = students
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.studentId),
              DataGridCell<String>(columnName: 'name', value: e.fullName),
              DataGridCell<String>(columnName: 'fatherName', value: e.fatherName),
              DataGridCell<String>(columnName: 'motherName', value: e.motherName),
              DataGridCell<String>(columnName: 'phoneNumber', value: e.phoneNumber),
              DataGridCell<String>(columnName: 'area', value: e.area),
              DataGridCell<String>(
                  columnName: 'acceptanceType', value: e.acceptanceType == AcceptanceType.general ? 'عام' : 'موازي'),
              DataGridCell<String>(columnName: 'nationality', value: e.nationality),
              DataGridCell<Map<String, dynamic>>(columnName: ' ', value: {'id': e.id, 'state': e.accountState}),
            ]))
        .toList();
  }

  List<DataGridRow> _students = [];

  @override
  List<DataGridRow> get rows => _students;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return dataGridCell.columnName == ' ' && dataGridCell.value['state'] == AccountState.pending
          ? DeleteEditButton(studentId: dataGridCell.value['id'])
          : Container(
              alignment: (dataGridCell.columnName == 'id' || dataGridCell.columnName == 'last name')
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: Text(dataGridCell.columnName != ' ' ? dataGridCell.value.toString() : ''),
            );
    }).toList());
  }
}

class Test {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String maidenName;

  Test(this.id, this.name, this.firstName, this.lastName, this.maidenName);
}
