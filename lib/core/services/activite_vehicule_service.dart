import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orbitnetmobileapp/core/models/activite_vehicule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app-sttings.dart';

class SearchActiviteVehiculeService {
  static bool loading = true;
  static bool loadingRecette = true;

  static Future<List?> listActiviteVehicule(
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
        '${AppSettings.DealerUrl}/ActiviteAtelierWS?jsondata={"ActiviteAtelier": {"CodeSte": "$dealerNbr","Ug": "$ugString","NumInterv": "$numInterv","VIN": "$vin","Immatriculation": "$immat","DD": "$dateDebut","CodeClient":"","Detail":"$detail"}}';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dynamic ligneData = jsonResponse['ActiviteAtelierReponse']
          ['ActiviteAtelierResultat']['Elements']['Element'];
      List<dynamic> resultList;
      if(jsonResponse['ActiviteAtelierReponse']
          ['ActiviteAtelierResultat']['RetMsg']=="0 Ligne(s) trouvée(s) "){
            return [];
      }
      if (ligneData is List) {
        ligneData.map((jsonObj){
          if(detail==1){
            return ActiviteVehicule.fromJson(jsonObj);
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
