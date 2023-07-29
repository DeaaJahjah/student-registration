import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Test> students = [
      Test(1, 'name', 'firstName', 'lastName', 'maidenName'),
      Test(2, 'name', 'firstName', 'lastName', 'maidenName'),
      Test(2, 'name', 'firstName', 'lastName', 'maidenName'),
    ];
    List<ExpandableColumn<dynamic>> headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "First name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Last name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Maiden name", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];
    List<ExpandableRow> rows = students.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e.id),
        ExpandableCell<String>(columnTitle: "First name", value: e.firstName),
        ExpandableCell<String>(columnTitle: "Last name", value: e.lastName),
        ExpandableCell<String>(columnTitle: "Maiden name", value: e.maidenName),
        // ExpandableCell<int>(columnTitle: "Age", value: e.age),
        // ExpandableCell<String>(columnTitle: "Gender", value: e.gender),
        // ExpandableCell<String>(columnTitle: "Email", value: e.email),
      ]);
    }).toList();
    return Expanded(
      flex: 8,
      child: ExpandableTheme(
        data: ExpandableThemeData(
          context,
          rowBorder: const BorderSide(color: Colors.amber),
          expandedBorderColor: Colors.transparent,
          paginationSize: 48,
        ),
        child: ExpandableDataTable(
          rows: rows,
          headers: headers,
          visibleColumnCount: 4,
        ),
      ),
    );
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



// DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           // minWidth: 600,
//           dataTextStyle: Theme.of(context).textTheme.headlineMedium,
//           // dataRowColor: ,
//           columns: const [
//             DataColumn2(
//               label: Text('Column A'),
//               size: ColumnSize.L,
//             ),
//             DataColumn(
//               label: Text('Column B'),
//             ),
//             DataColumn(
//               label: Text('Column C'),
//             ),
//             DataColumn(
//               label: Text('Column D'),
//             ),
//             DataColumn(
//               label: Text('Column D'),
//             ),
//             DataColumn(
//               label: Text('Column D'),
//             ),
//             DataColumn(
//               label: Text('Column D'),
//             ),
//             DataColumn(
//               label: Text('Column D'),
//             ),
//             DataColumn(
//               label: Text('Column NUMBERS'),
//               numeric: true,
//             ),
//           ],
//           showCheckboxColumn: true,
//           rows: List<DataRow>.generate(
//               100,
//               (index) => DataRow(cells: [
//                     DataCell(
//                       Container(
//                           color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                           child: Text('A' * (20 - index % 10))),
//                       showEditIcon: true,
//                     ),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('B' * (10 - (index + 5) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('C' * (15 - (index + 5) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('D' * (15 - (index + 10) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('D' * (50 - (index + 10) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('D' * (15 - (index + 10) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('D' * (15 - (index + 10) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text('D' * (15 - (index + 10) % 10)))),
//                     DataCell(Container(
//                         color: index % 2 == 0 ? Colors.amber : const Color(0xff707070),
//                         child: Text(((index + 0.1) * 25.4).toString())))
//                   ]))),