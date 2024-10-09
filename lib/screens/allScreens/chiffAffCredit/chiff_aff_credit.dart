import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbitnetmobileapp/core/models/chiffAffCreditModel.dart';
import 'package:orbitnetmobileapp/screens/allScreens/navigation_drawer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/services/search.dart';
import 'detail_element.dart';

class ChiffAffCreditRech extends StatefulWidget {
  const ChiffAffCreditRech({required Key key}) : super(key: key);

  @override
  _ChiffAffCreditRechState createState() => _ChiffAffCreditRechState();
}

class _ChiffAffCreditRechState extends State<ChiffAffCreditRech>
    with AutomaticKeepAliveClientMixin<ChiffAffCreditRech> {
  @override
  bool get wantKeepAlive => true;

  int detail = 0;
  String dateDebut = DateFormat('dd/MM/yyyy')
      .format(DateTime.now())
      .toString()
      .substring(0, 10);
  String dateFin = DateFormat('dd/MM/yyyy')
      .format(DateTime.now())
      .toString()
      .substring(0, 10);

  String dateDebFin = "";
  dynamic element = "";
  List<dynamic> newList = [];
  final money = NumberFormat("#,##0.000", "fr_FR");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => consumeRecherchAPI());
  }

  consumeRecherchAPI() async {
    // Calculate the date for the search
    String dD = DateFormat('dd/MM/yyyy')
        .format(DateTime.now())
        .toString()
        .substring(0, 10);

    // Create the search model
    ChiffAffCreditModel chiffAffCredModel = ChiffAffCreditModel(dD, dD, detail);

    // Perform the search
    var element =
        await SearchService.chiffAffCreditNonDet(context, chiffAffCredModel, 0);

    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        newList = [];
        if (element is List) {
          for (int i = 0; i < element.length; i++) {
            newList.add(element[i]);
          }
        } else {
          newList.add(element);
        }
      });
    }
  }

  Widget responseElement(BuildContext context, String montant, String nomSte,
      dynamic detail, String myDate) {
    return Padding(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                dd: "${myDate.substring(6)}/${myDate.substring(4, 6)}/${myDate.substring(0, 4)}",
                totale: montant,
                key: GlobalKey<FormState>(),
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.redAccent,
                    size: 24.sp,
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                height: 130.h,
                alignment: Alignment.centerLeft,
                child: Text(
                  nomSte,
                  style: TextStyle(color: Colors.grey[600], fontSize: 15.sp),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.monetization_on_sharp,
                    color: Colors.yellow[800],
                    size: 24.sp,
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                height: 100.h,
                child: Text(
                  montant,
                  style: TextStyle(color: Colors.grey[600], fontSize: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
      appBar: AppBar(
        title: Text(
          "Chiffre Affaire Credit",
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.orange),
          textAlign: TextAlign.left,
        ),
      ),
      drawer: NavigationDrawerWidget(
        key: GlobalKey<FormState>(),
      ),
      body: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (BuildContext buildContext, Widget? widget) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: const Color.fromRGBO(252, 205, 75, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: MaterialButton(
                    onPressed: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2012),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365 * 2)),
                        initialDateRange: DateTimeRange(
                          start: DateTime.now(),
                          end: DateTime.now(),
                        ),
                      );

                      if (picked != null) {
                        SearchService.loading = true;

                        // Updating state after date is picked
                        if (mounted) {
                          setState(() {
                            dateDebFin =
                                " Début : ${picked.start.toString().substring(0, 10)}\n Fin      : ${picked.end.toString().substring(0, 10)}";
                            dateDebut = DateFormat('dd/MM/yyyy')
                                .format(picked.start)
                                .toString()
                                .substring(0, 10);
                            dateFin = DateFormat('dd/MM/yyyy')
                                .format(picked.end)
                                .toString()
                                .substring(0, 10);
                          });
                        }

                        element = "";
                        ChiffAffCreditModel chiffAffCredModel =
                            ChiffAffCreditModel(dateDebut, dateFin, detail);
                        var fetchedElement =
                            await SearchService.chiffAffCreditNonDet(
                                context, chiffAffCredModel, 0);

                        // Check if the widget is still mounted before updating state again
                        if (mounted) {
                          setState(() {
                            newList = [];
                            if (fetchedElement is List) {
                              newList.addAll(fetchedElement);
                            } else {
                              newList.add(fetchedElement);
                            }
                          });
                        }
                      }
                    },
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFfff5d9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateDebut,
                                  style:
                                      const TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 3, left: 3),
                            child: Icon(Icons.arrow_right_alt_sharp,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFfff5d9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateFin,
                                  style:
                                      const TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (element != null && SearchService.loading == false)
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 110.h * newList.length,
                      child: (newList.isEmpty == false)
                          ? ListView.builder(
                              physics:
                                  const NeverScrollableScrollPhysics(), // <-- this will disable scroll
                              shrinkWrap: true,
                              itemCount: (newList[0]['DATEDOC'] != "")
                                  ? newList.length
                                  : 0,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 110.h,
                                  child: responseElement(
                                      context,
                                      money.format(
                                        double.parse(
                                          newList[index]['MntHT']
                                              .toString()
                                              .replaceAll(",", "."),
                                        ),
                                      ),
                                      newList[index]['DATEDOC'].substring(6) +
                                          "/" +
                                          newList[index]['DATEDOC']
                                              .substring(4, 6) +
                                          "/" +
                                          newList[index]['DATEDOC']
                                              .substring(0, 4),
                                      newList[index],
                                      newList[index]['DATEDOC']),
                                );
                              },
                            )
                          : const SizedBox(
                              height: 25,
                            ), // SearchChiffAffResult(elements: element),
                    ),
                  )
                : (SearchService.loading)
                    ? Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: SpinKitRing(
                          color: Colors.indigo,
                          size: 70.sp,
                          lineWidth: 3,
                        ))
                    : const SizedBox(),
            (newList.isNotEmpty)
                ? (newList[0]['DATEDOC'] == "")
                    ? SizedBox(
                        height: 200.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 30.h, left: 110.w, right: 110.w),
                          child: Center(
                            child: Text(
                              "Liste Vide !!",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 20.w,
                              ),
                            ),
                          ),
                        ))
                    : const SizedBox(
                        height: 25,
                      )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
