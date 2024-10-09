import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orbitnetmobileapp/core/models/chiffAffCreditModel.dart';
import 'package:orbitnetmobileapp/core/services/search.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? get dateFin => null;
  
  String? get dateDebut => null;
  
  int? get detail => null;

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                            var dateDebFin =
                                " Début : ${picked.start.toString().substring(0, 10)}\n Fin      : ${picked.end.toString().substring(0, 10)}";
                            var dateDebut = DateFormat('dd/MM/yyyy')
                                .format(picked.start)
                                .toString()
                                .substring(0, 10);
                            var dateFin = DateFormat('dd/MM/yyyy')
                                .format(picked.end)
                                .toString()
                                .substring(0, 10);
                          });
                        }

                        var _element = "";
                        ChiffAffCreditModel chiffAffCredModel =
                            ChiffAffCreditModel(dateDebut!, dateFin!, detail!);
                        var fetchedElement =
                            await SearchService.chiffAffCreditNonDet(
                                context, chiffAffCredModel, 0);

                        // Check if the widget is still mounted before updating state again
                        if (mounted) {
                          setState(() {
                            var newList = [];
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
                                  dateDebut!,
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
                                  dateFin!,
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
            );
  }
}