import 'package:academia/exports/barrel.dart';

class Ticket {
  final String? admissionNumber;
  final String fromDetails;
  final String toDetails;
  final DateTime date;
  final String? busNumberPlate;
  final String ticketID;
  final TimeOfDay departureTime;
  final double totalPayable;

  Ticket({
    required this.admissionNumber,
    this.busNumberPlate,
    required this.fromDetails,
    required this.toDetails,
    required this.date,
    required this.ticketID,
    required this.departureTime,
    required this.totalPayable,
  });
}
