import 'dart:async';

import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BookSeatPage extends StatelessWidget {
  const BookSeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book seat"),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownMenu(
                                  requestFocusOnTap: true,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.44,
                                  label: const Text("From"),
                                  dropdownMenuEntries: destinations
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry(
                                        value: value, label: value);
                                  }).toList(),
                                  controller: fromController,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownMenu(
                                  requestFocusOnTap: true,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.44,
                                  label: const Text("To"),
                                  dropdownMenuEntries: destinations
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry(
                                        value: value, label: value);
                                  }).toList(),
                                  controller: toController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () async {
                                    var datePicker = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 2)),
                                    );

                                    if (datePicker != null) {
                                      dateController.text =
                                          datePicker.toString();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Date"),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownMenu(
                                  requestFocusOnTap: true,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.44,
                                  label: const Text("Time"),
                                  dropdownMenuEntries: timeOptions
                                      .map<DropdownMenuEntry>(
                                          (Map<String, String> option) {
                                    return DropdownMenuEntry(
                                      value: option.values.first,
                                      label: option.values.first,
                                    );
                                  }).toList(),
                                  controller: timeController,
                                ),
                              ),
                            ],
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
                                        "student":
                                            userController.user.value!.admno!,
                                        "date":
                                            dateController.text.split(' ')[0],
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
                                          Get.snackbar("Success",
                                              "Seat booked Successfully");
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
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  errorSnack(String title, String message) {
    return Get.snackbar(title, message);
  }
}
