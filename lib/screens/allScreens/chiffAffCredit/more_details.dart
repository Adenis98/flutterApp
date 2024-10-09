import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MoreDetails extends StatefulWidget {
  final dynamic liste;
  final int index;
  const MoreDetails({required Key key, this.liste, required this.index}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MoreDetailsState createState() => _MoreDetailsState();

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
            borderRadius: const BorderRadius.all(Radius.circular(10))),
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
        SizedBox(width: 50.w),
        Expanded(
            flex: 4,
            child: Text(
              value,
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
      1100.h,
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
            child: element('Numero', liste[index]['NUMERO'],
                Icons.fingerprint_rounded, TextAlign.left),
          ),
          Expanded(
            child: element(
                'Montant HT',
                "${money.format(
                      double.parse(liste[index]['MntHT']
                          .toString()
                          .replaceAll(",", ".")),
                    )} TND",
                Icons.calculate_rounded,
                TextAlign.right),
          ),
          Expanded(
              child: element(
                  'Montant TTC',
                  "${money.format(
                        double.parse(liste[index]['MntTTC']
                            .toString()
                            .replaceAll(",", ".")),
                      )} TND",
                  Icons.point_of_sale,
                  TextAlign.right)),
          Expanded(
            child: element(
                'Regles',
                "${money.format(
                      double.parse(liste[index]['REGLES']
                          .toString()
                          .replaceAll(",", ".")),
                    )} TND",
                CupertinoIcons.check_mark_circled,
                TextAlign.right),
          ),
          Expanded(
              child: element(
                  'Reste',
                  "${money.format(
                        double.parse(liste[index]['RESTE']
                            .toString()
                            .replaceAll(",", ".")),
                      )} TND",
                  Icons.close,
                  TextAlign.right)),
          Expanded(
            child: element('Statut', liste[index]['STATUT'], Icons.info_rounded,
                TextAlign.left),
          ),
          Expanded(
            child: element('Nombre Jour Restant', liste[index]['NBRJ'],
                Icons.calendar_today_rounded, TextAlign.left),
          ),
        ],
      ),
    );
  }
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(750, 1334),
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
