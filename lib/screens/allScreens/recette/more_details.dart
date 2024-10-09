import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MoreDetailsRecette extends StatefulWidget {
  final dynamic liste;
  final int index;
  const MoreDetailsRecette({required Key key, this.liste, required this.index}) : super(key: key);

  @override
  _MoreDetailsRecetteState createState() => _MoreDetailsRecetteState();

  Widget myPadding(
    double height,
    Widget child,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      child: Container(
        height: height,
        width: 4000,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 5),
          child: child,
        ),
      ),
    );
  }

  Widget element(
      String title, String value, IconData icon, TextAlign alignment) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            icon,
            size: 50.sp,
            color: Colors.yellow[800],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
        ),
        Expanded(
            flex: 5,
            child: Text(
              (value.isNotEmpty) ? value : "Vide !!",
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
              textAlign: alignment,
            )),
      ],
    );
  }

  Widget detailElement() {
    final money = NumberFormat("#,##0.000", "fr_FR");
    return myPadding(
      3000,
      Column(
        children: [
          Expanded(
            child: element('Code', liste[index]['CODE'],
                Icons.format_list_numbered, TextAlign.left),
          ),
          Expanded(
            child: element(
                'Nom', liste[index]['NOM'], Icons.business, TextAlign.left),
          ),
          Expanded(
            child: element('Nature', liste[index]['Nature'],
                Icons.perm_device_info_rounded, TextAlign.left),
          ),
          Expanded(
            child: element(
                'ModeReg', liste[index]['ModeReg'], Icons.info, TextAlign.left),
          ),
          Expanded(
            child: element('Reference', liste[index]['Reference'],
                Icons.fingerprint_rounded, TextAlign.left),
          ),
          Expanded(
            flex: 2,
            child: element('Libelle', liste[index]['Libelle'],
                Icons.sms_failed_rounded, TextAlign.left),
          ),
          Expanded(
            child: element(
                'Montant',
                "${money.format(
                      double.parse(liste[index]['Montant']
                          .toString()
                          .replaceAll(",", ".")),
                    )} TND",
                Icons.calculate_rounded,
                TextAlign.
                right),
          ),
          Expanded(
            child: element(
                'Recouv',
                "${money.format(
                      double.parse(liste[index]['Recouv']
                          .toString()
                          .replaceAll(",", ".")),
                    )} TND",
                CupertinoIcons.minus_circle,
                TextAlign.right),
          ),
          Expanded(
              child: element(
                  'Avance',
                  "${money.format(
                        double.parse(liste[index]['Avance']
                            .toString()
                            .replaceAll(",", ".")),
                      )} TND",
                  CupertinoIcons.check_mark_circled,
                  TextAlign.right)),
          Expanded(
              child: element(
                  'Recette',
                  "${money.format(
                        double.parse(liste[index]['Recette']
                            .toString()
                            .replaceAll(",", ".")),
                      )} TND",
                  Icons.point_of_sale,
                  TextAlign.right)),
        ],
      ),
    );
  }
}

class _MoreDetailsRecetteState extends State<MoreDetailsRecette> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (BuildContext buildContext, Widget? widg) => Scaffold(
        backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
        appBar: AppBar(
          title: const Text(" "),
        ),
        body: widget.detailElement(),
      ),
    );
  }
}
