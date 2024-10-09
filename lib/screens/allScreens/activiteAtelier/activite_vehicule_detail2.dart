import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActiviteVehiculeDetail2 extends StatelessWidget {
  final List<dynamic> data;

  ActiviteVehiculeDetail2({required this.data});

  String _formatDate(String date) {
    if (date.length != 8) return date;
    String year = date.substring(0, 4);
    String month = date.substring(4, 6);
    String day = date.substring(6, 8);
    return "$day/$month/$year";
  }

  @override
  Widget build(BuildContext context) {
    double columnWidth = MediaQuery.of(context).size.width / 3;
    final money = NumberFormat("#,##0.000", "fr_FR");

    final includedFields = {
      "Ug",
      "DATEDOC"
    };

    // Extract common details from the first item in the data list excluding the redundant fields
    final commonDetails = data.isNotEmpty
        ? data.first.entries.where((entry) => includedFields.contains(entry.key)).toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail activité'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: commonDetails.map<Widget>((entry) {
                    // Format DATEDOC here
                    if (entry.key == 'DATEDOC') {
                      entry = MapEntry(entry.key, _formatDate(entry.value));
                    }
                    return entry.value != null && entry.value.toString().isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key=="DATEDOC"?"Date doc: ":'${entry.key}: ',
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
                      width: columnWidth/1.5 ,
                      child: const Text('N° OR'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text('Immatriculation'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth,
                      child: Text('NOM CLIENT'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 2,
                      child: Text('TTC_MO'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 2,
                      child: Text('TTC_PR'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 2,
                      child: Text('TTC'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 15,
                      child: Text('E'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 15,
                      child: Text('G'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 15,
                      child: Text('S'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 15,
                      child: Text('F'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: columnWidth / 15,
                      child: Text('A'),
                    ),
                  ),
                ],
                rows: data.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: columnWidth /1.5,
                          child: Text(item['NumInterv']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth,
                          child: Text(item['Immatriculation']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth,
                          child: Text(item['NOMCLIENT']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 2,
                          child: Text(
                            money.format(double.parse(item['TTC_MO']?.toString().replaceAll(",", ".") ?? '0.0').toDouble()),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 2,
                          child: Text(
                            money.format(double.parse(item['TTC_PR']?.toString().replaceAll(",", ".") ?? '0.0').toDouble()),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 2,
                          child: Text(
                            money.format(double.parse(item['TTC']?.toString().replaceAll(",", ".") ?? '0.0').toDouble()),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 15,
                          child: Text(item['Entree']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 15,
                          child: Text(item['GARANTIE']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 15,
                          child: Text(item['Sortie']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 15,
                          child: Text(item['Facturees']?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: columnWidth / 15,
                          child: Text(item['Annulees']?.toString() ?? ''),
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
