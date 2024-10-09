import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orbitnetmobileapp/core/models/chiffAffCreditModel.dart';
import 'package:orbitnetmobileapp/core/models/recetteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app-sttings.dart';

class SearchService {
  static bool loading = true;
  static bool loadingRecette = true;
  static chiffAffCreditNonDet(BuildContext context,
      ChiffAffCreditModel chiffAffCreditModel, int detail) async {
    String dd = chiffAffCreditModel.dd;
    String df = chiffAffCreditModel.df;
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    Map<String, dynamic> jsonUser = jsonDecode(user!);
    String dealerNbr = jsonUser['SiteCentral']=='0'?jsonUser['CodeSte']:'';
    final jsonInput =
        'JsonData={"ChiffAffCredit":{"CodeSte":"$dealerNbr","Ug":"1","DD":"$dd","DF":"$df","Detail":"$detail"}}';

    final Uri url =
        Uri.parse(AppSettings.DealerUrl+ '/ChiffAffCreditWS?' + jsonInput);

    Map<String, dynamic> jsonResponse;
    var res = await http.get(url);
    if (res.statusCode == 200) {
      SearchService.loading = false;
      jsonResponse = json.decode(res.body);
      /*  print(
          "response ${jsonResponse['ChiffAffCreditReponse']['ChiffAffCreditResultat']['Elements']['Element']} "); */
      dynamic element = jsonResponse['ChiffAffCreditReponse']
          ['ChiffAffCreditResultat']['Elements']['Element'];

      return element;
    } else {
      customShowDialog("internal server error", context);
    }
  }

  static recette(BuildContext context, Recette recette, int detail) async {
    String dd = recette.dd;
    String df = recette.df;
    String recap = recette.recapType;

    final jsonInput =
        'JsonData={"Recettes":{"CodeSte":"","Ug":"1","DD":"$dd","DF":"$df","RecapType":"$recap","Detail":$detail}}';
    final url = Uri.parse('${AppSettings.DealerUrl}/RecettesWS?$jsonInput');
    var jsonResponse;
    var res = await http.get(url);
    if (res.statusCode == 200) {
      SearchService.loadingRecette = false;
      jsonResponse = json.decode(res.body);
      /*  print(jsonResponse['RecettesReponse']['RecettesResultat']['Elements']
          ['Element']); */
      dynamic element = jsonResponse['RecettesReponse']['RecettesResultat']
          ['Elements']['Element'];

      return element;
    } else {
      customShowDialog("internal server error", context);
    }
  }
}

customShowDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erreur "),
          content: Text(message),
          actions: [
           TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
          ],
        );
      });
}
