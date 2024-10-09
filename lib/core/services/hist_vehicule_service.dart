import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orbitnetmobileapp/core/models/histo_vehic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app-sttings.dart';

class SearchVehiculeHistoryService {
  static bool loading = true;
  static bool loadingRecette = true;

  static Future<List?> listHistVehic(
      BuildContext context,
      String vin,
      String immat,String dateDebut , String dateFin,int detail,String? ug, String numInterv) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    Map<String, dynamic> json = jsonDecode(user!);

    String dealerNbr = json['SiteCentral']=='0'?json['CodeSte']:'';
    String ugString = ug!=null ? "$ug":"" ;
    print(AppSettings.DealerUrl);
    final apiUrl =
        '${AppSettings.DealerUrl}/ListeHistoVehicWS?jsondata={"ListeHistoVehicule": {"CodeSte": "$dealerNbr","Ug": "$ugString","NumInterv": "$numInterv","VIN": "$vin","Immatriculation": "$immat","DateDebutOR": "$dateDebut","DateFinOR": "$dateFin","AppMobile":"1","Detail":"$detail"}}';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dynamic ligneData = jsonResponse['ListeHistoVehiculeReponse']
          ['ListeHistoVehiculeResultat']['Intervs']['Interv'];
      List<dynamic> resultList;
      if(jsonResponse['ListeHistoVehiculeReponse']
          ['ListeHistoVehiculeResultat']['RetMsg']=="0 Ligne(s) trouvée(s) "){
            return [];
      }
      if (ligneData is List) {
        ligneData.map((jsonObj){
          if(detail==1){
            return HistoVehicWithoutDetail.fromJson(jsonObj);
          }
        }).toList();
        
        resultList = ligneData;
      } else {
        resultList = [ligneData];
      }
      return resultList;
    } else {
      return null;
    }
  }
}
