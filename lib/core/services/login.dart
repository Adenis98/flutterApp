import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orbitnetmobileapp/core/services/utils.dart';

import '../app-sttings.dart';

class LoginService {
  static bool loading = true;
  static bool loadingRecette = true;

  Future<Map<String, dynamic>> login(String userLogin, String userPwd,BuildContext context) async {
    final url = Uri.parse('${AppSettings.WS_ROOT}/GetAuthUsers?jsondata={"AuthUser":{"CodeModule":"${AppSettings.CODE_MODULE}","CodeSte":"","UserLogin":"$userLogin","UserPwd":"$userPwd"}}');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if(decodedData['AuthUserReponse']['AuthUserResultat']['Permis']=="-1"){
       AppSettings.DealerUrl = decodedData['AuthUserReponse']['AuthUserResultat']['DealerUrl']+'/srvportailvn.svc' ;
      print(AppSettings.DealerUrl);
      }else{
        Util.customShowDialog(
        decodedData['AuthUserReponse']['AuthUserResultat']['RetMsg'], context);
      }  
      return decodedData;
    } else {
      throw Exception('Failed to load data');
    }
  }

}
