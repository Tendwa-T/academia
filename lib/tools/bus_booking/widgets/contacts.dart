import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BusBookingController busBookingController =
        Get.put(BusBookingController());

    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Obx(
        () => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: busBookingController.tComMembers.length,
            itemBuilder: (context, index) {
              final member = busBookingController.tComMembers[index];
              String memberName = member['name'];
              String memberContact = member['phoneNumber'];
              return SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      InkWell(
                        enableFeedback: true,
                        borderRadius: BorderRadius.circular(30),
                        radius: 50,
                        onTap: () {
                          busBookingController.launchPhoneDialer(memberContact);
                        },
                        child: CircleAvatar(
                          radius: 38,
                          child: Text(
                            memberName
                                    .split(' ')[0]
                                    .substring(0, 1)
                                    .capitalize! +
                                memberName
                                    .split(' ')[1]
                                    .substring(0, 1)
                                    .capitalize!,
                            style: const TextStyle().copyWith(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        memberName,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
