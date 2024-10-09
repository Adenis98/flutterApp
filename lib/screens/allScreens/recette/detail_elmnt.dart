import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../allScreens/recette/more_details.dart';
import 'package:orbitnetmobileapp/core/services/search.dart';
import 'package:orbitnetmobileapp/core/models/recetteModel.dart';


class DetailElmnt extends StatefulWidget {
  final String dd;
  final String modeReg;
  final String totale ;
  final String mode ;
  const DetailElmnt({
    Key? key,
    this.dd = "", 
    this.modeReg  = "" ,
    required this.totale,
    this.mode="D",
  }) : super(key: key);

  @override
  _DetailElmntState createState() => _DetailElmntState(dd: dd, modeReg: modeReg ,totale : totale ,mode : mode);
}

@override
Widget myPadding(double height, Widget child, BuildContext context,
    dynamic liste, int index) {
  return Padding(
    padding: EdgeInsets.only(right: 30.w, left: 30.w, bottom: 30.h),
    child: Container(
      height: 110.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>( Colors.grey[50]!),
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
                    MoreDetailsRecette( 
                      key: ValueKey('unique_identifier_here'),
                      liste: liste,
                      index: index
                      ),
              ));
        },
        child: child,
      ),
    ),
  );
}

Widget element(String code, String num, String Mht, dynamic liste, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      
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
          Mht + " TND",
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 30.sp, color: Colors.grey[600]),
        ),
      ),
    ],
  );
}

Widget detailElement(List newList,BuildContext context,totale) {
  final money = new NumberFormat("#,##0.000", "fr_FR");
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
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
                  "Mode Reg",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.sp, color: Colors.white),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 40.sp),
                  child: Text(
                    "Montant",
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
                          newList[index]['CODE'].trim(),
                          newList[index]['ModeReg'],
                          money.format(
                            double.parse(newList[index]['Montant']
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
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.yellow[800],
              borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    totale+" TND",
                    
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 31.sp, color: Colors.white,fontWeight : FontWeight.bold),
                 
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

class _DetailElmntState extends State<DetailElmnt> {
  final dd;
  final modeReg;
  final totale ; 
  final mode ; 
  dynamic detail;
  List<dynamic> myList = [];

  _DetailElmntState({this.dd,this.modeReg,this.totale,this.mode});

  void initState() {
    SearchService.loadingRecette=true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => consumeDetailApi(mode));
  }

  consumeDetailApi(String recapType) async {
   
    Recette recette = Recette(dd, dd, mode, 1);

    detail =
        await SearchService.recette(context, recette,1);
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
      designSize: Size(750, 1334),
      builder: (BuildContext buildContext, Widget? widget) => Scaffold(
        backgroundColor: Color.fromRGBO(238, 240, 240, 1),
        appBar: AppBar(
          title: Text("Detail Date : " + dd),
        ),
        body:Column(
          children:[

          Expanded(
            flex:6,
            child:(detail != null&&SearchService.loadingRecette!=true) ? detailElement(myList,context,totale) :(SearchService.loadingRecette==true)? SpinKitRing(
                    color: Colors.indigo,
                    size: 150.sp,
                    lineWidth: 4,
                  )
                : SizedBox(),
          ),
          
          ]
        )      
      ),
    );
  }
}
