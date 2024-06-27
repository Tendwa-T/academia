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
          ],
        ),
      ),
    );
  }
}
