import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final StoryController storyController = Get.find<StoryController>();
    final EventsController eventsController = Get.find<EventsController>();
    final CoursesController coursesController = Get.find<CoursesController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              title: const Text(
                "Life at glance",
              ),
            ),
          ),
          // Obx(
          //   () => const SliverVisibility(
          //     sliver: SliverToBoxAdapter(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           HomeScreenStoryWidget(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Quick statistics",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surfaceTint),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stat(title: "Day", percentage: dayPercentGone() * 0.01),
                      Stat(title: "Week", percentage: weekPercentGone() * 0.01),
                      Obx(
                        () => Stat(
                          title: "Semester",
                          percentage: calculateSemesterPercent(
                                eventsController
                                        .currentSemester.value?.startDate ??
                                    DateTime.now(),
                                eventsController
                                        .currentSemester.value?.endDate ??
                                    DateTime.now(),
                              ) *
                              0.01,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      children: [
                        Text(
                          coursesController.courses.length.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text("Number of courses")
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      children: [
                        Text(
                          coursesController.numberOfCoursesToday.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text("Courses today")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Courses",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Hi"),
                    )
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Todos",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Hi"),
                    )
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Tips",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Hi"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
