import 'package:academia/exports/barrel.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CurrentTicketPage extends StatelessWidget {
  const CurrentTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    var ticketDetails = BusBookingController().allTickets[0];

    bool isDarkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? true
            : false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Details"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 24,
              ),
              Center(
                child: ticketDetails.ticketID.isNotEmpty
                    ? Column(
                        children: [
                          ticketMethod(isDarkMode, context, ticketDetails),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text.rich(TextSpan(
                                text: "Note: ",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                children: const [
                                  TextSpan(
                                    text:
                                        "Show your Ticket as proof of payment",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ])),
                          )
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text("You do not have any valid ticket yet"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TicketWidget ticketMethod(
      bool isDarkMode, BuildContext context, Ticket ticketDetails) {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: 'KSH',
    );
    final formattedAmount = formatCurrency.format(ticketDetails.totalPayable);

    return TicketWidget(
      color: isDarkMode ? Colors.white : Colors.black12,
      isCornerRounded: true,
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.55,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 14.0, left: 12, right: 12, top: 12),
        child: Column(
          children: [
            // (Row) To - From and Date
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8 - 17,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${ticketDetails.fromDetails} - ${ticketDetails.toDetails}",
                          style: const TextStyle().copyWith(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(ticketDetails.date),
                          style: const TextStyle().copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Divider(
              color: Colors.grey[400],
              indent: MediaQuery.sizeOf(context).width * 0.02,
              endIndent: MediaQuery.sizeOf(context).width * 0.02,
            ),

            // (Row) Depature time and Ticket ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ticket ID",
                          style: const TextStyle().copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ticketDetails.ticketID,
                          style: const TextStyle().copyWith(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Departure Time",
                            style: const TextStyle().copyWith(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ticketDetails.departureTime.format(context),
                            style: const TextStyle().copyWith(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: const TextStyle().copyWith(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: formattedAmount.substring(3),
                        style: const TextStyle().copyWith(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: " ${formattedAmount.substring(0, 3)}",
                            style: const TextStyle().copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),

            const Spacer(),
            Divider(
              color: Colors.grey[400],
              indent: MediaQuery.sizeOf(context).width * 0.02,
              endIndent: MediaQuery.sizeOf(context).width * 0.02,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: PrettyQrView.data(
                data: ticketDetails.ticketID,
              ),
            ),
          ],
        ),
      ),
    );
  }
}