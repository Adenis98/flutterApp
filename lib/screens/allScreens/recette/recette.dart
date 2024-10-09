import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../core/models/recetteModel.dart';
import '../../../core/services/search.dart';

import 'package:intl/intl.dart';

import '../navigation_drawer.dart';
import 'components/recette_response_elmnt.dart';

class RecetteRech extends StatefulWidget {
  const RecetteRech({required Key key}) : super(key: key);

  @override
  _RecetteRechState createState() => _RecetteRechState();
}

class _RecetteRechState extends State<RecetteRech>
    with AutomaticKeepAliveClientMixin<RecetteRech> {
  @override
  bool get wantKeepAlive => true;

  int detail = 0;
  String dateDebut =DateFormat('dd/MM/yyyy')
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

  String mode = "D";
  @override
  void initState() {
    super.initState();
    dateDebFin = " Début : $dateDebut\n Fin      : $dateDebut";
    WidgetsBinding.instance.addPostFrameCallback((_) => consumeRechercheApi("D",true));
  }

  consumeRechercheApi(String md,bool init) async {
    mode = md;
    Recette recette ;
    if(init){
      String dd = DateFormat('dd/MM/yyyy')
              .format(DateTime.now())
              .toString()
              .substring(0, 10);
      recette= Recette(dd, dd, md, detail);
    }else{
      recette= Recette(dateDebut, dateFin, md, detail);
    }
    element = await SearchService.recette(context, recette, 0);

    newList = [];
    if (element is List) {
      for (int i = 0; i < element.length; i++) {
        newList.add(element[i]);
      }
    } else {
      newList.add(element);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 240, 240, 1),
      appBar: AppBar(
        title: Text(
          "Recette",
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
                      blurRadius: 2,
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
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                        initialDateRange: DateTimeRange(
                          start: DateTime.now(),
                          end: DateTime.now(),
                        ),
                      );

                      if (picked != null) {
                        SearchService.loadingRecette = true;
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

                        Recette recette =
                            Recette(dateDebut, dateFin, mode, detail);
                        element = await SearchService.recette(
                            this.context, recette, 0);

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
                                  (dateDebFin == "") ? "Date Debut" : dateDebut,
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
                                  (dateDebFin == "") ? "Date Fin" : dateFin,
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 30.sp),
                            child: Text(
                              "Afficher Par : ",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.grey[600]),
                            )),
                        LiteRollingSwitch(
                          onSwipe: () {},
                          value: true,
                          textOff: " MODE",
                          textOn: " DATE",
                          iconOn: Icons.calendar_today,
                          iconOff: Icons.credit_card,
                          colorOn: Colors.yellow,
                          colorOff: Colors.blue,
                          onChanged: (bool state) {
                            SearchService.loadingRecette = true;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {});
                            });
                            (state)
                                ? WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => consumeRechercheApi("D",false))
                                : WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => consumeRechercheApi("M",false));
                          },
                          onTap: () {},
                          onDoubleTap: () {},
                        ),
                      ],
                    ),
                  )),
            ),
            (SearchService.loadingRecette == false &&
                    newList.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 110.h * newList.length,
                      child: (newList.isEmpty == false)
                          ? ListView.builder(
                              physics:
                                  const NeverScrollableScrollPhysics(), // <-- this will disable scroll
                              shrinkWrap: true,
                              itemCount:
                                  (newList[0]['Ug'] != "") ? newList.length : 0,
                              itemBuilder: (context, index) {
                                Widget myCont = SizedBox(
                                  height: 110.h,
                                  child: RecetteResponseElmnt(
                                    context: context,
                                    montant: money.format(
                                      double.parse(
                                        newList[index]['Montant']
                                            .toString()
                                            .replaceAll(",", "."),
                                      ),
                                    ),
                                    dateDoc: (mode == "D")
                                        ? newList[index]['DATEREG']
                                                .substring(6) +
                                            "/" +
                                            newList[index]['DATEREG']
                                                .substring(4, 6) +
                                            "/" +
                                            newList[index]['DATEREG']
                                                .substring(0, 4)
                                        : "",
                                    modeReg:(mode == "M")?newList[index]['MODEREG']:"",
                                    code: newList[index]['CODE'],
                                    detail: newList[index],
                                    myDate: dateDebut,
                                    mode: mode,
                                    key: GlobalKey<FormState>(),
                                  ),
                                );

                                return myCont;
                              },
                            )
                          : const SizedBox(
                              height: 25,
                            ), // SearchChiffAffResult(elements: this.element),
                    ),
                  )
                : (SearchService.loadingRecette)
                    ? Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: SpinKitRing(
                          color: Colors.indigo,
                          size: 70.sp,
                          lineWidth: 3,
                        ))
                    : const SizedBox(),
            (newList.isNotEmpty && SearchService.loadingRecette == false)
                ? (newList[0]['Ug'] == "" &&
                        newList[0]['CODE'] == "" &&
                        newList[0]['LIBELLE'] == "" &&
                        (newList[0]['DATEREG'] == "" ||
                            newList[0]['MODEREG'] == ""))
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
