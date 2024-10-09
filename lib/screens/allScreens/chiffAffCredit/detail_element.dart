import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orbitnetmobileapp/core/models/chiffAffCreditModel.dart';
import 'package:orbitnetmobileapp/core/services/search.dart';
import 'package:intl/intl.dart';

import 'more_details.dart';

class DetailPage extends StatefulWidget {
  final String dd;
  final String totale;
  const DetailPage({required Key key, required this.dd, required this.totale}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailPageState createState() =>
      // ignore: no_logic_in_create_state
      _DetailPageState(dd: dd, totale: totale);
}

@override
Widget myPadding(double height, Widget child, BuildContext context,
    dynamic liste, int index) {
  return Padding(
    padding: EdgeInsets.only(right: 30.w, left: 30.w, bottom: 30.h),
    child: SizedBox(
      height: 110.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey[50]!),
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MoreDetails(liste: liste, index: index, key: GlobalKey<FormState>(),),
              ));
        },
        child: child,
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget element(String code, String num, String Mht, dynamic liste, int index) {
  return Row(
    children: [
      Container(
        width: 40.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (liste[index]['STATUT'] == "2")
              ? Colors.redAccent[400]
              : ((liste[index]['STATUT'] == "0")
                  ? Colors.green[400]
                  : Colors.yellow[800]),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          code,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.sp, color: Colors.grey[600]),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          num,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.sp, color: Colors.grey[600]),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          "$Mht TND",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 30.sp, color: Colors.grey[600]),
        ),
      ),
    ],
  );
}

Widget detailElement(List newList, BuildContext context, String totale) {
  final money = NumberFormat("#,##0.000", "fr_FR");
  Size size = MediaQuery.of(context).size;
  return Column(
    children: [
      Padding(
        padding:
            EdgeInsets.only(top: 40.h, right: 30.w, left: 30.w, bottom: 30.h),
        child: Container(
          height: 110.h,
          width: size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.yellow[800],
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Container(
                width: 30.h,
                margin: EdgeInsets.only(left: 30.sp),
                child: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Code",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Numero",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.sp, color: Colors.white),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 40.sp),
                  child: Text(
                    "MontantTTC",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: newList.length + 2,
        child: ListView.builder(
          itemCount: newList.length,
          itemBuilder: (context, index) {
            return myPadding(
                150,
                Column(
                  children: [
                    Expanded(
                      child: element(
                          newList[index]['CODE'],
                          newList[index]['NUMERO'],
                          money.format(
                            double.parse(newList[index]['MntTTC']
                                .toString()
                                .replaceAll(",", ".")),
                          ),
                          newList,
                          index),
                    ),
                  ],
                ),
                context,
                newList,
                index);
          },
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(top: 20.h, right: 30.w, left: 30.w, bottom: 30.h),
        child: Container(
          height: 110.h,
          width: size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.yellow[800],
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Montant totale :",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.sp, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 40.sp),
                  child: Text(
                    "$totale TND",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 31.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _DetailPageState extends State<DetailPage> {
  // ignore: prefer_typing_uninitialized_variables
  final dd;
  // ignore: prefer_typing_uninitialized_variables
  final totale;
  dynamic detail;
  List<dynamic> myList =[];

  _DetailPageState({this.dd, this.totale});

  @override
  void initState() {
    SearchService.loading = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => consumeDetailApi());
  }

  consumeDetailApi() async {
    ChiffAffCreditModel chiffAffCredModel =
        ChiffAffCreditModel(dd, dd, 1);

    detail =
        await SearchService.chiffAffCreditNonDet(context, chiffAffCredModel, 1);

    if (detail is List) {
      for (int i = 0; i < detail.length; i++) {
        myList.add(detail[i]);
      }
    } else {
      myList.add(detail);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (BuildContext buildContext, Widget? widget) => Scaffold(
        backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
        appBar: AppBar(
          // ignore: prefer_interpolation_to_compose_strings
          title: Text("Detail Date : " + dd),
        ),
        body: (detail != null && SearchService.loading != true)
            ? detailElement(myList, context, totale)
            : (SearchService.loading)
                ? SpinKitRing(
                    color: Colors.indigo,
                    size: 150.sp,
                    lineWidth: 4,
                  )
                : const SizedBox(),
      ),
    );
  }
}
