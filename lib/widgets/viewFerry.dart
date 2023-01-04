import 'package:flutter/material.dart';
import '../models/ferryticket.dart';

class FerryBuilder extends StatelessWidget {
  const FerryBuilder({
    Key? key,
    required this.future,
    required this.deleteTicket,
    required this.editTicket,
  }) : super(key: key);
  final Future<List<FerryTicket>> future;
  final Function(FerryTicket) editTicket;
  final Function(FerryTicket) deleteTicket;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FerryTicket>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final ferryTicket = snapshot.data![index];
                return buildFerryTicketCard(ferryTicket, context);
              },
            ),
          );
        });
  }

  Widget buildFerryTicketCard(FerryTicket ferryTicket, BuildContext context) {
    return Card(
<<<<<<< HEAD
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            alignment: Alignment.center,
            child: Text(
              ferryTicket.book_id.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ferryTicket.dest_route,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(ferryTicket.depart_date.toString()),
                const SizedBox(height: 4.0),
                const Text("Depart from:"),
                const SizedBox(height: 4.0),
                Text(ferryTicket.depart_route),
                const SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () => editTicket(ferryTicket),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.edit, color: Colors.orange[800]),
                  ),
                ),
                const SizedBox(width: 29.0),
                GestureDetector(
                  onTap: () => deleteTicket(ferryTicket),
                  child: Container(
                    height: 40.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Colors.red[800]),
                  ),
                )
              ],
            ),
          ),
        ],
=======
      color: Color.fromARGB(255, 186, 221, 187),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
>>>>>>> 2f2bd45c116f0c223ce428783fb205d62d925fb0
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.directions_boat_rounded, color: Color.fromARGB(255, 1, 85, 57,), size: 35.0),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(height: 4.0),
                          Text(ferryTicket.depart_date.toString()),
                        ]
                      )
                    ]
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(height: 4.0),
                          const Text("Depart from:"),
                        ]
                      ),
                      Row(
                        children: [
                          Text(
                            ferryTicket.dest_route,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(height: 4.0),
                          const Text("Destination:"),
                        ]
                      ),
                      Row(
                        children: [
                          const SizedBox(height: 4.0),
                          Text(
                            ferryTicket.depart_route,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20.0),
                          GestureDetector(
                            onTap: () => onEdit(ferryTicket),
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.edit, color: Colors.orange[800]),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20.0),
                          GestureDetector(
                            onTap: () => onDelete(ferryTicket),
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.delete, color: Colors.red[800]),
                            ),
                          )
                        ],
                      ),
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
