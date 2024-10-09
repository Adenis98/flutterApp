import 'package:flutter/material.dart';

class ActiviteVehicule {
  final String ug;
  final String dateDoc;
  final String numInterv;
  final String immatriculation;
  final String nomClient;
  final String htMo;
  final String htPr;
  final String ht;
  final String ttcMo;
  final String ttcPr;
  final String ttc;
  final String entree;
  final String garantie;
  final String sortie;
  final String facturees;
  final String annulees;

  ActiviteVehicule({
    required this.ug,
    required this.dateDoc,
    required this.numInterv,
    required this.immatriculation,
    required this.nomClient,
    required this.htMo,
    required this.htPr,
    required this.ht,
    required this.ttcMo,
    required this.ttcPr,
    required this.ttc,
    required this.entree,
    required this.garantie,
    required this.sortie,
    required this.facturees,
    required this.annulees,
  });

  // Factory constructor to create a new AnotherHistoVehic instance from JSON
  factory ActiviteVehicule.fromJson(Map<String, dynamic> json) {
    return ActiviteVehicule(
      ug: json['Ug']?.toString().trim() ?? 'N/A',
      dateDoc: json['DATEDOC']?.toString().trim() ?? 'N/A',
      numInterv: json['NumInterv']?.toString().trim() ?? 'N/A',
      immatriculation: json['Immatriculation']?.toString().trim() ?? 'N/A',
      nomClient: json['NOMCLIENT']?.toString().trim() ?? 'N/A',
      htMo: json['HT_MO']?.toString().trim() ?? 'N/A',
      htPr: json['HT_PR']?.toString().trim() ?? 'N/A',
      ht: json['HT']?.toString().trim() ?? 'N/A',
      ttcMo: json['TTC_MO']?.toString().trim() ?? 'N/A',
      ttcPr: json['TTC_PR']?.toString().trim() ?? 'N/A',
      ttc: json['TTC']?.toString().trim() ?? 'N/A',
      entree: json['Entree']?.toString().trim() ?? 'N/A',
      garantie: json['GARANTIE']?.toString().trim() ?? 'N/A',
      sortie: json['Sortie']?.toString().trim() ?? 'N/A',
      facturees: json['Facturees']?.toString().trim() ?? 'N/A',
      annulees: json['Annulees']?.toString().trim() ?? 'N/A',
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Ug': ug,
      'DATEDOC': dateDoc,
      'NumInterv': numInterv,
      'Immatriculation': immatriculation,
      'NOMCLIENT': nomClient,
      'HT_MO': htMo,
      'HT_PR': htPr,
      'HT': ht,
      'TTC_MO': ttcMo,
      'TTC_PR': ttcPr,
      'TTC': ttc,
      'Entree': entree,
      'GARANTIE': garantie,
      'Sortie': sortie,
      'Facturees': facturees,
      'Annulees': annulees,
    };
  }
}
