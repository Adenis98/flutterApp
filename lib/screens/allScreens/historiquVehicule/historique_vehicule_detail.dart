import 'package:flutter/material.dart';
import 'package:orbitnetmobileapp/core/services/hist_vehicule_service.dart';
import 'package:orbitnetmobileapp/screens/allScreens/historiquVehicule/historique_vehicule_detail2.dart';

class VehicleHistoryPage extends StatefulWidget {
  final List<dynamic> data;

  VehicleHistoryPage({required this.data});

  @override
  _VehicleHistoryPageState createState() => _VehicleHistoryPageState();
}

class _VehicleHistoryPageState extends State<VehicleHistoryPage> {
  Future<void> _navigateToDetailPage(BuildContext context, dynamic item) async {
    List? ligneData = await SearchVehiculeHistoryService.listHistVehic(
        context, "", "", "", "", 1, item["Ug"], item["NumInterv"]);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistVehiculeDetail2(data: ligneData!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle History'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double columnWidth = screenWidth / 4;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: screenWidth),
                child:widget.data!=Null? DataTable(
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: columnWidth,
                        child: Text('Num Interv'),
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
                        child: Text('Date OR'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: columnWidth,
                        child: Text('Nom Client'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: columnWidth,
                        child: Text('Km'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: columnWidth,
                        child: Text('Num facture'),
                      ),
                    ),
                  ],
                  rows: widget.data.map((item) {
                    var dateOr = item["DateOR"];
                    item["DateOR"] =
                        '${dateOr.substring(6, 8)}/${dateOr.substring(4, 6)}/${dateOr.substring(0, 4)}';
                    print('Item: $item');
                    return DataRow(
                      cells: [
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(item['NumInterv']?.toString() ?? 'N/A'),
                        )),
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(
                              item['Immatriculation']?.toString() ?? 'N/A'),
                        )),
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(item['DateOR']?.toString() ?? 'N/A'),
                        )),
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(item['NomClient']?.toString() ?? 'N/A'),
                        )),
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(item['Km']?.toString() ?? 'N/A'),
                        )),
                        DataCell(SizedBox(
                          width: columnWidth,
                          child: Text(item['NumFacture']?.toString() ?? 'N/A'),
                        )),
                      ],
                      onSelectChanged: (selected) {
                        if (selected != null && selected) {
                          _navigateToDetailPage(context, item);
                        }
                      },
                    );
                  }).toList(),
                ):Text("No DATA !!"),
              ),
            ),
          );
        },
      ),
    );
  }
}
