import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistVehiculeDetail2 extends StatelessWidget {
  final List<dynamic> data;

  HistVehiculeDetail2({required this.data});

  @override
  Widget build(BuildContext context) {
    double columnWidth = MediaQuery.of(context).size.width / 4;
    final money = NumberFormat("#,##0.000", "fr_FR");
    // Define the fields that should be excluded from common details
    final excludedFields = {
      "NumLigne",
      "TypeArt",
      "Article",
      "Libelle",
      "Ug",
      "CodeSte",
      "Qte",
      "PU",
      "TVA",
      "TOT_LIG"
    };

    // Extract common details from the first item in the data list excluding the redundant fields
    final commonDetails = data.isNotEmpty
        ? data.first.entries
            .where((entry) => !excludedFields.contains(entry.key))
            .toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle History Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Common Details Card with Labeled Fields excluding redundant fields
            if (commonDetails.isNotEmpty)
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: commonDetails.map<Widget>((entry) {
                      return entry.value != null &&
                              entry.value.toString().isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${entry.key}: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value.toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    }).toList(),
                  ),
                ),
              ),
            // DataTable
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 6,
                      child: const Text('N'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 5,
                      child: const Text('T'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text('Article'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text('Libelle'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 3,
                      child: Text('Qte'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 2,
                      child: Text('PU'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text('HT'),
                    ),
                  )
                ],
                rows: data.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: columnWidth / 6,
                          child: Text(item['NumLigne']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 5,
                          child: Text(item['TypeArt']?.toString() ?? 'N/A'),
                        ),
                      ),
                      DataCell(Text(item['Article']?.toString() ?? 'N/A')),
                      DataCell(Text(item['Libelle']?.toString() ?? 'N/A')),
                      DataCell(SizedBox(
                          width: columnWidth / 4,
                          child: Text(
                              textAlign: TextAlign.right,
                              item['Qte']?.toString() ?? 'N/A'))),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 3,
                          child: Text(
                              textAlign: TextAlign.right,
                              money.format(double.parse(
                                  item['PU'].toString().replaceAll(",", ".")))),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 3,
                          child: Text(
                              textAlign: TextAlign.right,
                              money.format(double.parse(item['TOT_LIG']
                                  .toString()
                                  .replaceAll(",", ".")))),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
