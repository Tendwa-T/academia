import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/bus_booking/book_seat_page.dart';
import 'package:academia/tools/bus_booking/my_ticket_page.dart';
import 'package:academia/tools/bus_booking/trip_history_page.dart';
import 'package:get/get.dart';

class BusBookingController extends GetxController {
  RxBool isModalVisible = false.obs;
  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  List<Map<String, dynamic>> cards = [
    {
      "id": 0,
      "name": "Bus Booking",
      "action": "Book a seat",
      "icon": Icons.bus_alert_outlined,
      "ontap": () {
        Get.to(() => const BookSeatPage());
      },
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
      "description": "Get to see your most current ticket",
      "color": (Colors.yellow),
    },
  ].obs;

  List<Map<String, dynamic>> tComMembers = [
    {
      "id": 0,
      "name": "Kiema Nahashon",
      "phoneNumber": "+254725695626",
    },
    {
      "id": 1,
      "name": "Lewis Njeri",
      "phoneNumber": "+254746494504",
    },
    {
      "id": 2,
      "name": "Cecile Eddie",
      "phoneNumber": "+254706041344",
    },
  ].obs;

  List<Ticket> allTickets = [
    Ticket(
      admissionNumber: userController.user.value!.admno,
      fromDetails: "Athi River",
      toDetails: "Nairobi",
      date: DateTime.parse('2024-06-14'),
      ticketID: "Tk0891001",
      departureTime: const TimeOfDay(hour: 5, minute: 00),
      totalPayable: 200,
    ),
    Ticket(
      admissionNumber: userController.user.value!.admno,
      fromDetails: "Nairobi",
      toDetails: "Athi Rivver",
      date: DateTime.parse('2024-06-14'),
      ticketID: "Tk0891001",
      departureTime: const TimeOfDay(hour: 5, minute: 00),
      totalPayable: 400,
    ),
  ].obs;

  launchPhoneDialer(contact) async {
    var phoneNumber = 'tel:$contact'; // Replace with the actual phone number
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
