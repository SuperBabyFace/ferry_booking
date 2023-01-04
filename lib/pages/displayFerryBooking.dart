import 'package:ferry_booking/models/ferryPlaces.dart';
import 'package:ferry_booking/pages/bookingFerryPage.dart';
import 'package:ferry_booking/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../database/ferrytickets_helper.dart';
import '../models/user.dart';
import '../models/ferryticket.dart';
import '../theme/theme.dart';
import '../widgets/viewFerry.dart';
import '../database/userSession.dart';
import '../widgets/bottomNavigationbar.dart';

class displayFerryBooking extends StatefulWidget {
  const displayFerryBooking({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<displayFerryBooking> {
  final FerryTicketDatabase _ferryTicketDatabase = FerryTicketDatabase();

  Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
    await _ferryTicketDatabase.deleteFerryTicket(
      ferryTicket.book_id!,
    );
    setState(() {});
  }

  Future<void> _onFerryTicketEdit(FerryTicket ferryTicket) async {
    await _ferryTicketDatabase.editFerryTicket(
      ferryTicket,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: Text("App Bar without Back Button"),
      automaticallyImplyLeading: false,
    );
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 85, 57),
          title: Text('Water Space',
              style: whiteTextStyle.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            FerryBuilder(
                future: _ferryTicketDatabase
                    .getFerryUserTicket(userSaveSession.getUserID() as int),
                deleteTicket: _onFerryTicketDelete,
                editTicket: (value) {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => order_page(
                            ferryTicket: value,
                            user: widget.user
                          ),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }),
          ],
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 1, 85, 57),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => order_page(user: widget.user),
                    fullscreenDialog: true,
                  ))
                  .then((_) => setState(() {}));
            },
            heroTag: 'addFerryTicket',
            child: const Icon(Icons.add_circle_rounded),
          ),
          const SizedBox(height: 12.0),
        ]),
      ),
    );
  }
}
