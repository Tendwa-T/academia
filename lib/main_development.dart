import 'package:academia/app.dart';
import 'package:academia/exports/barrel.dart';
import 'package:academia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init one signal with verbose logging
  // initialize the controllers
  Get.put(UserController());
  Get.put(SettingsController());
  Get.put(NetworkController());
  Get.put(TodoController());
  Get.put(RewardController());
  Get.put(CoursesController());
  Get.put(EventsController());
  Get.put(OrganizationController());

  // launch the application
  runApp(
    const Academia(
      flavor: 'development',
    ),
  );
}

//class Academia extends StatefulWidget {
//  const Academia({super.key});
//
//  @override
//  State<Academia> createState() => _AcademiaState();
//}
//
//class _AcademiaState extends State<Academia> {
//  late Future<bool> _authState;
//  final UserController _userController = Get.find<UserController>();
//  final SettingsController _settingsController = Get.find<SettingsController>();
//
//  @override
//  void initState() {
//    super.initState();
//    LocalNotifierService().requestPermission();
//
//    if (_settingsController.settings.value.requireAppUnlock) {
//      _authState = _settingsController.performLocalAuthentication(
//        "Your app is locked, to continue unloack it using your authentication mechanism",
//      );
//    } else {
//      _authState = Future.value(true);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    /// Init the controllers here
//    return GetMaterialApp(
//      theme: ThemeData(
//        useMaterial3: true,
//        colorSchemeSeed: const Color(0xFF3D5A80),
//      ),
//      darkTheme: ThemeData(
//        brightness: Brightness.dark,
//        useMaterial3: true,
//        colorSchemeSeed: const Color(0xFF3D5A80),
//      ),
//      home: FutureBuilder(
//        future: _authState,
//        builder: (context, snapshot) {
//          if (snapshot.data == true) {
//            return Obx(
//              () => _userController.isLoggedIn.value
//                  ? const LayoutPage()
//                  : const IntroPage(),
//            );
//          }
//          return Scaffold(
//            body: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Lottie.asset(
//                  "assets/lotties/studying.json",
//                ),
//                const SizedBox(height: 22),
//                Text(
//                  "Please authenticate 🔐 with Academia to continue",
//                  style: Theme.of(context).textTheme.headlineSmall,
//                ),
//                FilledButton.icon(
//                  onPressed: () {
//                    _authState = _settingsController.performLocalAuthentication(
//                      "Your app is locked, to continue unloack it using your authentication mechanism",
//                    );
//                  },
//                  label: const Text("Authenticate"),
//                )
//              ],
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
