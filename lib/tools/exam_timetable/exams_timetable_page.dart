import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/exam_timetable/exams_timetable_controller.dart';
import 'package:academia/tools/exam_timetable/widgets/exam_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'widgets/count_down_widget.dart';

class ExamTimeTablePage extends StatefulWidget {
  const ExamTimeTablePage({super.key});

  @override
  State<ExamTimeTablePage> createState() => _ExamTimeTablePageState();
}

class _ExamTimeTablePageState extends State<ExamTimeTablePage> {
  final userController = Get.find<UserController>();
  final settingsController = Get.find<SettingsController>();
  final controller = Get.put(ExamsTimeTableController());
  final _searchController = TextEditingController();
  bool _isSearching = false;
  bool _searchComplete = false;
  List<Exam> searchedExams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: Text(
              "Hi ${userController.user.value!.name!.split(' ')[0].title()}",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Academia Help",
                    content: const Text(
                      "Never miss an exam again with the intuitive exam timetable\nDouble tap an exam card to remove it",
                    ),
                  );
                },
                icon: const Icon(Ionicons.help),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => controller.previousQuote(),
                  onDoubleTap: () => controller.nextQuote(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      const Spacer(),
                      Obx(
                        () => Text(
                          controller.index > -1
                              ? controller.quotes[controller.index.value]["q"]
                              : "Fool me once shame on you; fool me twice, shame on me.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontFamily: GoogleFonts.figtree().fontFamily,
                              ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.index > -1
                              ? controller.quotes[controller.index.value]["a"]
                              : "Chinese Proverb",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => controller.hasExams.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ExamCountDownWidget(
                        examCount: controller.exams.length,
                        exam: controller.exams[0],
                        endtime: getExamDate(controller.exams[0]),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(
                () => controller.hasExams.value
                    ? ListView.builder(
                        itemCount: controller.exams.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onDoubleTap: () async {
                            await controller
                                .removeExamFromStorage(controller.exams[index]);
                          },
                          child: ExamCard(exam: controller.exams[index]),
                        ),
                      )
                    : controller.isLoading.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your wish is my command🧞",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontFamily:
                                          GoogleFonts.figtree().fontFamily,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              LoadingAnimationWidget.beat(
                                color: Theme.of(context).colorScheme.primary,
                                size: 60,
                              )
                            ],
                          )
                        : Center(
                            child: Text(
                              "Youre out of wishes, try searching for your exams 🕵️",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontFamily:
                                        GoogleFonts.figtree().fontFamily,
                                  ),
                            ),
                          ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "BIL 111K, ENG 112, ...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_searchController.text.trim().isEmpty) {
                                showCustomSnackbar(
                                  "Error",
                                  "Please provide units to search",
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  colorText:
                                      Theme.of(context).colorScheme.onSurface,
                                );
                                return;
                              }
                              if (mounted) {
                                setState(() {
                                  _isSearching = true;
                                  _searchComplete = false;
                                });
                                searchedExams = await controller.fetchExams(
                                  _searchController.text.split(","),
                                );

                                if (searchedExams.isNotEmpty) {
                                  setState(() {
                                    _searchComplete = true;
                                  });
                                }

                                // await examtimetableController.fetchExams();
                                if (!mounted) {
                                  return;
                                }
                                setState(() {
                                  _isSearching = false;
                                });
                              }
                            },
                            icon: const Icon(Ionicons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _isSearching
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              child: Text(
                                "Your wish is my command. Performing forbidden magic 🧞\n Double Tap a course to add it",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontFamily:
                                          GoogleFonts.figtree().fontFamily,
                                    ),
                              ),
                            )
                          : _searchComplete
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: ListView.builder(
                                      itemCount: searchedExams.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onDoubleTap: () async {
                                              // Add exam
                                              await controller.addExamToStorage(
                                                  searchedExams[index]);
                                              searchedExams
                                                  .remove(searchedExams[index]);
                                              setState(() {});
                                            },
                                            child: ExamCard(
                                              exam: searchedExams[index],
                                            ),
                                          )),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                  child: Text(
                                    "Please input your units seperated with commas and let the genie work his forbidden magic!",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontFamily:
                                              GoogleFonts.figtree().fontFamily,
                                        ),
                                  ),
                                ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(
          Ionicons.search,
        ),
      ),
    );
  }

  DateTime getExamDate(Exam exam) {
    final formatter = DateFormat('EEEE dd/MM/yy');
    return formatter.parse(exam.day.title());
  }
}
