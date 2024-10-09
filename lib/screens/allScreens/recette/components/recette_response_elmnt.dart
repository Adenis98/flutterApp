import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../detail_Elmnt.dart';
import 'package:flutter/material.dart';

class RecetteResponseElmnt extends StatefulWidget {
  final BuildContext context;
  final String montant;
  final String dateDoc;
  final String modeReg;
  final String code;
  final dynamic detail;
  final String myDate;
  final String mode;
  const RecetteResponseElmnt(
      {required Key key,
      required this.context,
      required this.montant,
      required this.dateDoc,
      required this.modeReg,
      required this.code,
      this.detail,
      required this.myDate,
      required this.mode})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _RecetteResponseElmntState createState() => _RecetteResponseElmntState(
      context,
      montant,
      dateDoc,
      modeReg,
      code,
      detail,
      myDate,
      mode);
}

class _RecetteResponseElmntState extends State<RecetteResponseElmnt> {
  final BuildContext context;
  final String montant;
  final String dateDoc;
  final String modeReg;
  final String code;
  final dynamic detail;
  final String myDate;
  final String mode;
  _RecetteResponseElmntState(this.context, this.montant, this.dateDoc,this.modeReg,
      this.code, this.detail, this.myDate, this.mode);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              if (kDebugMode) {
                print("this.mode : $mode");
              }
              if (mode == "D" ) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailElmnt(dd: dateDoc, totale: montant,mode:mode),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            (mode=="D")?Icons.calendar_today:Icons.mode,
                            color: Colors.redAccent,
                            size: 24.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 130.h,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (mode=="D")?dateDoc:modeReg,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 19.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.monetization_on_sharp,
                            color: Colors.yellow[800],
                            size: 24.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 100.h,
                          child: Text(
                            montant,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 19.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 23, left: 4),
        child: SizedBox(
          height: 25.h,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.format_list_numbered,
                  color: Colors.blueGrey,
                  size: 12.sp,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                alignment: Alignment.centerLeft,
                height: 25.h,
                child: Text(
                  code,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
