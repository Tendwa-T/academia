import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/bus_booking/my_ticket_page.dart';
import 'package:academia/tools/bus_booking/trip_history_page.dart';
import 'package:get/get.dart';

class BusBookingController extends GetxController {
  RxBool isModalVisible = false.obs;
  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

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
      admissionNumber: userController.user.value!.regno,
      fromDetails: "Athi River",
      toDetails: "Nairobi",
      date: DateTime.parse('2024-06-14'),
      ticketID: "Tk0891001",
      departureTime: const TimeOfDay(hour: 5, minute: 00),
      totalPayable: 200,
    ),
    Ticket(
      admissionNumber: userController.user.value!.regno,
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
