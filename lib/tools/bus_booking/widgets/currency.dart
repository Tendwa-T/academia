import 'package:academia/exports/barrel.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    super.key,
    required this.formattedAmount,
  });

  final String formattedAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: formattedAmount.substring(3),
              style: const TextStyle()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 40),
              children: [
                TextSpan(
                  text: " ${formattedAmount.substring(0, 3)}",
                  style: const TextStyle()
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
