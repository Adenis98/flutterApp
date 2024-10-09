import 'package:flutter/material.dart';
import 'package:orbitnetmobileapp/screens/allScreens/chiffAffCredit/chiff_aff_credit.dart';
import 'package:orbitnetmobileapp/screens/allScreens/historiquVehicule/historique_vehicule.dart';
import 'package:orbitnetmobileapp/screens/allScreens/navigation_drawer.dart';
import 'package:orbitnetmobileapp/screens/allScreens/recette/recette.dart';
import 'package:orbitnetmobileapp/screens/allScreens/activiteAtelier/activite_vehicule.dart';

class HomePage extends StatelessWidget {
  final String histVehic;
  final String ca;
  final String rec;
  final String actAt;
 const HomePage({
    Key? key,
    required this.histVehic, 
    required this.ca, 
    required this.rec, 
    required this.actAt
  }) : super(key: key);
  
  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChiffAffCreditRech(key: GlobalKey<FormState>())),
          );
          break;
        }
      case 1:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RecetteRech(key: GlobalKey<FormState>())),
          );
          break;
        }
      case 2:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HistoriqueVehicule(key: GlobalKey<FormState>())),
          );
          break;
        }
        case 3:
        {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>ActiviteVehicule()),
            (Route<dynamic> route) => false,
          );
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      drawer: const NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ca!="0"?ElevatedButton.icon(
              onPressed: () => selectedItem(context, 0),
              icon: Icon(Icons.monetization_on_sharp, color: Colors.yellow[800]),
              label: const Text('Chiffre Affaire Credit'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: BorderSide(color: Colors.yellow[800]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ):Text(""),
            const SizedBox(height: 16.0),
            (rec!="0")?ElevatedButton.icon(
              onPressed: () => selectedItem(context, 1),
              icon: Icon(Icons.point_of_sale, color: Colors.yellow[800]),
              label: const Text('Recette'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: BorderSide(color: Colors.yellow[800]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ):Text(""),
            const SizedBox(height: 16.0),
            histVehic!="0"?ElevatedButton.icon(
              onPressed: () => selectedItem(context, 2),
              icon: Icon(Icons.history, color: Colors.yellow[800]),
              label: const Text('Historique Vehicule'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: BorderSide(color: Colors.yellow[800]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ):Text(""),
            const SizedBox(height: 16.0),
            actAt!="0"?ElevatedButton.icon(
              onPressed: () => selectedItem(context, 3),
              icon: Icon(Icons.history, color: Colors.yellow[800]),
              label: const Text('Activité Atelier'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: BorderSide(color: Colors.yellow[800]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ):Text(""),
          ],
        ),
      ),
    );
  }
}
