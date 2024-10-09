import 'package:flutter/material.dart';

class HistoVehicWithoutDetail {
  final String vin;
  final String codeSte;
  final String dealerName;
  final String ug;
  final String numInterv;
  final String immatriculation;
  final String dateOR;
  final String km;
  final String numLigne;
  final String typeArt;
  final String article;
  final String libelle;
  final String typeFact;
  final String numFacture;
  final String dateFacture;
  final String nomClient;
  final String telClient;
  final String telClient2;

  HistoVehicWithoutDetail({
    required this.vin,
    required this.codeSte,
    required this.dealerName,
    required this.ug,
    required this.numInterv,
    required this.immatriculation,
    required this.dateOR,
    required this.km,
    required this.numLigne,
    required this.typeArt,
    required this.article,
    required this.libelle,
    required this.typeFact,
    required this.numFacture,
    required this.dateFacture,
    required this.nomClient,
    required this.telClient,
    required this.telClient2,
  });

  // Factory constructor to create a new HistoVehicWithDetail instance from JSON
  factory HistoVehicWithoutDetail.fromJson(Map<String, dynamic> json) {
    return HistoVehicWithoutDetail(
      vin: json['VIN']?.toString().trim() ?? 'N/A',
      codeSte: json['CodeSte']?.toString().trim() ?? 'N/A',
      dealerName: json['Dealer_Name']?.toString().trim() ?? 'N/A',
      ug: json['Ug']?.toString().trim() ?? 'N/A',
      numInterv: json['NumInterv']?.toString().trim() ?? 'N/A',
      immatriculation: json['Immatriculation']?.toString().trim() ?? 'N/A',
      dateOR: json['DateOR']?.toString().trim() ?? 'N/A',
      km: json['Km']?.toString().trim() ?? 'N/A',
      numLigne: json['NumLigne']?.toString().trim() ?? 'N/A',
      typeArt: json['TypeArt']?.toString().trim() ?? 'N/A',
      article: json['Article']?.toString().trim() ?? 'N/A',
      libelle: json['Libelle']?.toString().trim() ?? 'N/A',
      typeFact: json['TypeFact']?.toString().trim() ?? 'N/A',
      numFacture: json['NumFacture']?.toString().trim() ?? 'N/A',
      dateFacture: json['DateFacture']?.toString().trim() ?? 'N/A',
      nomClient: json['NomClient']?.toString().trim() ?? 'N/A',
      telClient: json['TelClient']?.toString().trim() ?? 'N/A',
      telClient2: json['TelClient2']?.toString().trim() ?? 'N/A',
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'VIN': vin,
      'CodeSte': codeSte,
      'Dealer_Name': dealerName,
      'Ug': ug,
      'NumInterv': numInterv,
      'Immatriculation': immatriculation,
      'DateOR': dateOR,
      'Km': km,
      'NumLigne': numLigne,
      'TypeArt': typeArt,
      'Article': article,
      'Libelle': libelle,
      'TypeFact': typeFact,
      'NumFacture': numFacture,
      'DateFacture': dateFacture,
      'NomClient': nomClient,
      'TelClient': telClient,
      'TelClient2': telClient2,
    };
  }
}
