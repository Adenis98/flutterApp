import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbitnetmobileapp/core/services/activite_vehicule_service.dart';
import 'package:orbitnetmobileapp/screens/allScreens/activiteAtelier/activite_vehicule_detail2.dart';

class ActiviteVehiculePage extends StatefulWidget {
  final List<dynamic> data;

  ActiviteVehiculePage({required this.data});

  @override
  _ActiviteVehiculePageState createState() => _ActiviteVehiculePageState();
}

class _ActiviteVehiculePageState extends State<ActiviteVehiculePage> {
  final NumberFormat moneyFormat = NumberFormat("#,##0.000", "fr_FR");

  Future<void> _navigateToDetailPage(BuildContext context, dynamic item) async {
    print(widget.data[0]);
    try {
      List? ligneData = await SearchActiviteVehiculeService.listActiviteVehicule(
        context,
        "",
        "",
        _formatDate(item["DATEDOC"]),
        "",
        1,
        null,
        "",
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActiviteVehiculeDetail2(data: ligneData!),
        ),
      );
    } catch (e) {
      print("Error navigating to detail page: $e");
      // Handle error as needed
    }
  }

  String _formatDate(String date) {
    if (date.length != 8) return date;
    String year = date.substring(0, 4);
    String month = date.substring(4, 6);
    String day = date.substring(6, 8);
    return "$day/$month/$year";
  }

  String _formatMoney(String? value) {
    if (value == null) return 'N/A';
    try {
      // Replace ',' with '.' to ensure proper decimal handling
      double parsedValue = double.parse(value.replaceAll(',', '.'));
      return moneyFormat.format(parsedValue);
    } catch (e) {
      return 'N/A';
    }
  }

  Icon _getIconForTitle(String title) {
    switch (title) {
      case 'Ug':
        return Icon(Icons.directions_car, color: Colors.yellow[800]);
      case 'Date Doc':
        return Icon(Icons.date_range, color: Colors.yellow[800]);
      case 'Nombre':
        return Icon(Icons.format_list_numbered, color: Colors.yellow[800]);
      case 'HT MO':
      case 'HT PR':
      case 'HT':
      case 'TTC MO':
      case 'TTC PR':
      case 'TTC':
        return Icon(Icons.attach_money, color: Colors.yellow[800]);
      case 'Entree':
      return Icon(Icons.input, color: Colors.yellow[800]);
      case 'Sortie':
        return Icon(Icons.output, color: Colors.yellow[800]);
      case 'Garantie':
        return Icon(Icons.verified, color: Colors.yellow[800]);
      case 'Facturees':
      case 'Annulees':
        return Icon(Icons.receipt, color: Colors.yellow[800]);
      default:
        return Icon(Icons.label, color: Colors.yellow[800]);
    }
  }

  Widget _buildItemCard(dynamic item) {
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    TextStyle valueStyle = TextStyle(fontSize: 16);

    String _formatValue(String title, String? value) {
      if (value == null) return 'N/A';
      if (title == 'Date Doc') {
        return _formatDate(value);
      }
      if (title.startsWith('HT') || title.startsWith('TTC')) {
        return _formatMoney(value);
      }
      return value;
    }

    Widget buildRow(String title, String? value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            _getIconForTitle(title),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text(title, style: titleStyle),
            ),
            Expanded(
              flex: 3,
              child: Text(_formatValue(title, value), style: valueStyle),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => _navigateToDetailPage(context, item),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow('Ug', item['Ug']?.toString().trim()),
              buildRow('Date Doc', item['DATEDOC']?.toString()),
              buildRow('Nombre', item['Nombre']?.toString()),
              buildRow('HT MO', item['HT_MO']?.toString()),
              buildRow('HT PR', item['HT_PR']?.toString()),
              buildRow('HT', item['HT']?.toString()),
              buildRow('TTC MO', item['TTC_MO']?.toString()),
              buildRow('TTC PR', item['TTC_PR']?.toString()),
              buildRow('TTC', item['TTC']?.toString()),
              buildRow('Entree', item['Entree']?.toString()),
              buildRow('Garantie', item['GARANTIE']?.toString()),
              buildRow('Sortie', item['Sortie']?.toString()),
              buildRow('Facturees', item['Facturees']?.toString()),
              buildRow('Annulees', item['Annulees']?.toString()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activité atelier'),
      ),
      body: widget.data.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return _buildItemCard(widget.data[index]);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToDetailPage(context, widget.data[0]);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(247, 235, 235, 235),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text('Detail'),
                  ),
                ),
              ],
            )
          : Center(
              child: Text("No DATA !!"),
            ),
    );
  }
}
