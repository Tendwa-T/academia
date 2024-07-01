import 'dart:async';

import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/bus_booking/my_ticket_page.dart';
import 'package:academia/tools/bus_booking/trip_history_page.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

List<Map<String, dynamic>> busCards = [
  {
    "id": 0,
    "name": "Bus Booking",
    "action": "Book a seat",
    "icon": Icons.bus_alert_outlined,
    "description": "Book a seat on the school bus from wherever you are",
    "color": (Colors.red),
  },
  {
    "id": 1,
    "name": "Bus Schedule",
    "action": "View the bus schedule",
    "icon": Icons.calendar_month_outlined,
    "ontap": () {
      Get.snackbar("Bus Schedule", "Bus Schedule, coming right up");
    },
    "description": "Get to see which buses are available and plan yourself",
    "color": (Colors.blue),
  },
  {
    "id": 2,
    "name": "Trip History",
    "action": "View Trip History",
    "icon": Icons.history_outlined,
    "ontap": () {
      Get.to(() => const TripHistoryPage());
    },
    "description": "Get to see the previous trips you have booked with us",
    "color": (Colors.purple),
  },
  {
    "id": 3,
    "name": "My Ticket",
    "action": "View my Ticket",
    "icon": Ionicons.ticket,
    "ontap": () {
      Get.to(() => const CurrentTicketPage());
    },
    "description": "Get to see your most recent ticket",
    "color": (Colors.yellow),
  },
];

List<String> destinations = [
  "Valley Road Campus",
  "Town",
  "Cabanas",
  "Syokimau",
  "Athi River Campus",
];

List<Map<String, String>> timeOptions = [
  {"5am": "05:00"},
  {"11am": "11:00"},
  {"4pm": "16:00"},
  {"5pm": "17:00"},
];

class CardGridWidget extends StatelessWidget {
  const CardGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.38,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _busBookingDialog(context);
                  },
                  child: Card(
                    surfaceTintColor: busCards[0]['color'],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                busCards[0]['icon'],
                                size: 36,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            busCards[0]['name'],
                            style: const TextStyle().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            busCards[0]['description'],
                            style: const TextStyle().copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: busCards[1]['ontap'],
                  child: Card(
                    surfaceTintColor: busCards[1]['color'],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                busCards[1]['icon'],
                                size: 36,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            busCards[1]['name'],
                            style: const TextStyle().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            busCards[1]['description'],
                            style: const TextStyle().copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: busCards[3]['ontap'],
              child: Card(
                surfaceTintColor: busCards[3]['color'],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            busCards[3]['icon'],
                            size: 36,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        busCards[3]['name'],
                        style: const TextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        busCards[3]['description'],
                        style: const TextStyle().copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _busBookingDialog(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("Book A seat")),
            content: Builder(builder: (context) {
              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownMenu(
                      label: const Text("From"),
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      dropdownMenuEntries: destinations
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                      controller: fromController,
                    ),
                    const SizedBox(height: 10),
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      label: const Text("To"),
                      dropdownMenuEntries: destinations
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                      controller: toController,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          var datePicker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 2)),
                          );

                          if (datePicker != null) {
                            dateController.text = datePicker.toString();
                          }
                        },
                        decoration: const InputDecoration(
                          label: Text("Date"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      label: const Text("Time"),
                      dropdownMenuEntries: timeOptions
                          .map<DropdownMenuEntry>((Map<String, String> option) {
                        return DropdownMenuEntry(
                          value: option.values.first,
                          label: option.values.first,
                        );
                      }).toList(),
                      controller: timeController,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Cancel"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                              onPressed: () async {
                                var reqBody = jsonEncode({
                                  "student": userController
                                      .user.value!.admissionNumber,
                                  "date": dateController.text.split(' ')[0],
                                  "time": timeController.text,
                                  "depature": fromController.text,
                                  "destination": toController.text,
                                });
                                print(reqBody);
                                try {
                                  var response = await http
                                      .post(
                                    Uri.parse(
                                        'https://1dhkzhqz-8000.euw.devtunnels.ms/transport/ticket/'),
                                    headers: <String, String>{
                                      "Content-type":
                                          "application/json; charset=UTF-8",
                                    },
                                    body: reqBody,
                                  )
                                      .timeout(
                                    const Duration(seconds: 20),
                                    onTimeout: () {
                                      throw TimeoutException(
                                          "Connection Timed out. Try again Later.");
                                    },
                                  );
                                  if (response.statusCode == 400) {
                                    Get.snackbar("No Available Buses",
                                        "Unfortunately, there are no remaining seats on the bus");
                                  }
                                  if (response.statusCode == 200) {
                                    Get.snackbar(
                                        "Success", "Seat booked Successfully");
                                  }
                                  print(response.body);
                                } catch (e) {
                                  if (e is TimeoutException) {
                                    Get.snackbar("Time-Out",
                                        "Connection Timed out. Try again in a few minutes");
                                  }
                                }
                              },
                              child: const Text("Book Seat"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          );
        });
  }
}
