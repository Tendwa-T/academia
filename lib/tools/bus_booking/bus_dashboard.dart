import 'package:academia/exports/barrel.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

final userController = Get.find<UserController>();

class BusDashboard extends StatelessWidget {
  const BusDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const double transportTotal = 200.00;
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'KSH',
    );
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
    final formattedAmount = formatCurrency.format(transportTotal);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Information",
                content: Column(
                  children: [
                    Image.asset("assets/images/bot_love.png", height: 100),
                    const Text(
                      "Get to view the bus schedule, book a bus, and view the various trips you have been on as well as the total amount you have spent on transport",
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Hi ${userController.user.value!.name!.split(' ')[0].title()}",
                  style: const TextStyle()
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CurrencyWidget(formattedAmount: formattedAmount),
            const SizedBox(
              height: 41,
            ),
            const Text(
              "Here are some things you can do",
            ),
            const SizedBox(
              height: 28,
            ),
            const CardGridWidget(),
            const SizedBox(
              height: 28,
            ),
            const Text("Transport Comittee Contacts"),
            const SizedBox(
              height: 18,
            ),
            const ContactsWidget(),
            Obx(
              () => BusBookingController().isModalVisible.value
                  ? AlertDialog(
                      title: const Text('Book a Bus'),
                      content: Column(
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
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.44,
                                              label: const Text("From"),
                                              dropdownMenuEntries: destinations
                                                  .map<
                                                          DropdownMenuEntry<
                                                              String>>(
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
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.44,
                                              label: Text("To"),
                                              dropdownMenuEntries: destinations
                                                  .map<
                                                          DropdownMenuEntry<
                                                              String>>(
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
                                                var datePicker =
                                                    await showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(days: 2)),
                                                );

                                                if (datePicker != null) {
                                                  dateController.text =
                                                      DateFormat.yMMMMEEEEd()
                                                          .format(datePicker);
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Date"),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: timeController,
                                              readOnly: true,
                                              onTap: () async {
                                                var timePicker =
                                                    await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if (timePicker != null) {
                                                  timeController.text =
                                                      timePicker
                                                          .format(context);
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                label: Text("Time"),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {},
                                          child: const Text("Book Seat"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
