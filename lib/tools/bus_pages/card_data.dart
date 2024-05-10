import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

final List<Map<String, dynamic>> cards = [
  {
    "id": 0,
    "name": "Bus Booking",
    "action": "Book a seat",
    "icon": Icons.bus_alert_outlined,
    "ontap": () {
      Get.snackbar("Bus Booking", "Yaay Get ready to book the bus!!");
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
      Get.snackbar("Trip history", "Here are you past trips");
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
      Get.snackbar("My Ticket", "Opening your ticket details...");
    },
    "description": "Get to see your most current ticket",
    "color": (Colors.yellow),
  },
];
