import 'package:academia/exports/barrel.dart';

class CardGridWidget extends StatelessWidget {
  const CardGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        final cardIcon = (card['icon']);
        return Card(
          surfaceTintColor: card['color'],
          child: InkWell(
            onTap: card['ontap'],
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        cardIcon,
                        size: 36,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    card['name'],
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    card['description'],
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
