class Ticket {
  final String destDetails;
  final String date;
  final String busNumberPlate;
  final List<String> seatNumber;
  final String ticketID;
  final String departureTime;
  final String totalPayable;

  Ticket({
    required this.destDetails,
    required this.date,
    required this.busNumberPlate,
    required this.seatNumber,
    required this.ticketID,
    required this.departureTime,
    required this.totalPayable,
  });
}
