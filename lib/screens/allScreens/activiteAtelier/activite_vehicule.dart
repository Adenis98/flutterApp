import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbitnetmobileapp/core/services/activite_vehicule_service.dart';
import 'package:orbitnetmobileapp/screens/allScreens/navigation_drawer.dart';
import 'activite_vehicule_detail.dart';
class ActiviteVehicule extends StatefulWidget {
  const ActiviteVehicule({Key? key}) : super(key: key);

  @override
  State<ActiviteVehicule> createState() => _ActiviteVehiculeState();
}

class _ActiviteVehiculeState extends State<ActiviteVehicule> {
  String dateDebut = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String dateFin = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final TextEditingController vinController = TextEditingController();
  final TextEditingController immatController = TextEditingController();
  final TextEditingController codeClientController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    dateDebutController.text = dateDebut;
    dateFinController.text = dateFin;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateFormat('dd/MM/yyyy').parse(controller.text);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> searchVehicleHistory() async {
    try {
      onRowTap(
        vinController.text ,
        immatController.text,
        dateDebutController.text,
        dateFinController.text );
      
    } catch (e) {
      // Handle any errors that occur during the process
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load data'),
        ),
      );
    }
  }

  Future<void> onRowTap(vin,immat,dateDeb,dateFin) async {
    List? ligneData = 
      await SearchActiviteVehiculeService.
        listActiviteVehicule(context, vin,immat,dateDeb,dateFin,0,null,"");

    // Navigate to the new page and pass the data
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActiviteVehiculePage(data: ligneData!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
      appBar: AppBar(
        title: const Text(
          "Activité atelier",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.orange),
        ),
      ),
      drawer: NavigationDrawerWidget(
        key: GlobalKey<FormState>(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: vinController,
              decoration: const InputDecoration(
                labelText: 'VIN',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: immatController,
              decoration: const InputDecoration(
                labelText: 'Immatriculation',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: codeClientController,
              decoration: const InputDecoration(
                labelText: 'Code Client',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateDebutController,
                    decoration: const InputDecoration(
                      labelText: 'Date mvt',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await _selectDate(context, dateDebutController);
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: searchVehicleHistory,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Colors.orange, // text color
                ),
                child: const Text('Search'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
