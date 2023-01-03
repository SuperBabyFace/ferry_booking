import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/userSession.dart';
import '../database/ferrytickets_helper.dart';
import '../models/ferryPlaces.dart';
import '../models/ferryticket.dart';
import '../theme/theme.dart';
import '../widgets/bottomNavigationbar.dart';

class order_page extends StatefulWidget {
  const order_page({Key? key, this.ferryTicket}) : super(key: key);
  final FerryTicket? ferryTicket;

  @override
  _OrderPageState createState() => _OrderPageState();
}

enum JourneyEnum { OneWay, Return }

class _OrderPageState extends State<order_page> {
  final FerryTicketDatabase _ferryTicketDatabase = FerryTicketDatabase();
  final TextEditingController _getDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedDeparture = 0;
  int _selectedDestination = 0;

  @override
  void initState() {
    super.initState();
    if (widget.ferryTicket != null) {
      _getDate.text = widget.ferryTicket!.depart_date;
      _selectedDeparture =
          ferryDeparture.indexOf(widget.ferryTicket!.depart_route);
      _selectedDestination =
          ferryDestination.indexOf(widget.ferryTicket!.dest_route);
    }
  }

  Future<void> _onSave() async {
    int id;
    final depature = ferryDeparture[_selectedDeparture];
    final destination = ferryDestination[_selectedDestination];
    final journeys = _journey.name;

    widget.ferryTicket == null
        ? await _ferryTicketDatabase.insertFerryTicket(
            FerryTicket(
                depart_date: _getDate.text,
                journey: journeys,
                depart_route: depature,
                dest_route: destination,
                user_id: userSaveSession.getUserID() as int),
          )
        : await _ferryTicketDatabase.editFerryTicket(
            FerryTicket(
                book_id: widget.ferryTicket!.book_id,
                depart_date: _getDate.text,
                journey: journeys,
                depart_route: depature,
                dest_route: destination,
                user_id: userSaveSession.getUserID() as int),
          );
    Navigator.pop(context);
  }

  JourneyEnum _journey = JourneyEnum.OneWay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 85, 57),
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Water Space",
            style: whiteTextStyle.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Ticket Booking",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),

                  //phone number input
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: _getDate,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: "Select Departure Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy MM dd').format(pickedDate);

                          setState(() {
                            if (_getDate.text != null) {
                              _getDate;
                            }
                            _getDate.text = formattedDate as String;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: _selectedDeparture == null
                          ? null
                          : ferryDeparture[_selectedDeparture],
                      items: ferryDeparture
                          .map((String value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDeparture =
                              ferryDeparture.indexOf(value.toString());
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Color.fromARGB(255, 1, 85, 57),
                      ),
                      decoration: InputDecoration(
                          labelText: "Destination",
                          prefixIcon: Icon(
                            Icons.pin_drop_outlined,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: _selectedDestination == null
                          ? null
                          : ferryDestination[_selectedDestination],
                      items: ferryDestination
                          .map((String value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDestination =
                              ferryDestination.indexOf(value.toString());
                          print(_selectedDestination);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Color.fromARGB(255, 1, 85, 57),
                      ),
                      decoration: InputDecoration(
                          labelText: "Departure",
                          prefixIcon: Icon(
                            Icons.pin_drop_outlined,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Journey",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        RadioListTile<JourneyEnum>(
                          //   controller: ,
                          activeColor: Color.fromARGB(255, 1, 85, 57),
                          value: JourneyEnum.OneWay,
                          groupValue: _journey,
                          title: Text("One Way"),
                          onChanged: (value) {
                            setState(() {
                              _journey = value as JourneyEnum;
                              print(_journey);
                            });
                          },
                        ),
                        RadioListTile<JourneyEnum>(
                          //   controller: ,
                          activeColor: Color.fromARGB(255, 1, 85, 57),
                          value: JourneyEnum.Return,
                          groupValue: _journey,
                          title: Text("Return"),
                          onChanged: (val) {
                            setState(() {
                              _journey = val as JourneyEnum;
                            });
                          },
                        ),
                        // ElevatedButton(
                        //   onPressed: _onSave,
                        //   child: const Text("Confirm Order"),
                        // ),
                        ElevatedButton(
                          child: Text('Confirm Order'),
                          onPressed: _onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 1, 85, 57),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
