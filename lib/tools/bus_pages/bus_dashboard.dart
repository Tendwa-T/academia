import 'package:academia/exports/barrel.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

final userController = Get.find<UserController>();
List<Map<String, dynamic>> tComMembers = [
  {
    "id": 0,
    "name": "Kiema Nahashon",
    "phoneNumber": "+254725695626",
    "ontap": () {
      launchPhoneDialer("+254725695626");
    },
  },
  {
    "id": 1,
    "name": "Lewis Njeri",
    "phoneNumber": "+254746494504",
    "ontap": () {
      launchPhoneDialer("+254746494504");
    },
  },
  {
    "id": 2,
    "name": "Cecile Eddie",
    "phoneNumber": "+254706041344",
    "ontap": () {
      launchPhoneDialer("+254706041344");
    },
  },
];

class BusDashboard extends StatelessWidget {
  const BusDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    const double transportTotal = 1234.00;
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'KSH',
    );

    print(tComMembers.length);

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
              height: 52,
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
            SizedBox(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: tComMembers.length,
                  itemBuilder: (context, index) {
                    final member = tComMembers[index];
                    String memberName = member['name'];
                    return SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: member['ontap'],
                              child: CircleAvatar(
                                radius: 38,
                                child: Text(
                                  memberName
                                          .split(' ')[0]
                                          .substring(0, 1)
                                          .capitalize! +
                                      memberName
                                          .split(' ')[1]
                                          .substring(0, 1)
                                          .capitalize!,
                                  style:
                                      const TextStyle().copyWith(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              memberName,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

void launchPhoneDialer(contact) async {
  var phoneNumber = 'tel:$contact'; // Replace with the actual phone number
  if (await canLaunchUrl(Uri.parse(phoneNumber))) {
    await launchUrl(Uri.parse(phoneNumber));
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
