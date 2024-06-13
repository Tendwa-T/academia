import 'package:academia/exports/barrel.dart';
import 'package:intl/intl.dart';

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Trips"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: BusBookingController().allTickets.length,
          itemBuilder: (context, index) {
            final ticket = BusBookingController().allTickets[index];
            return Card(
              child: Row(
                children: [
                  CircleAvatar(
                    minRadius: 40,
                    child: SizedBox(
                      width: 40,
                      child: Text(
                        DateFormat.MMMMd().format(ticket.date),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
