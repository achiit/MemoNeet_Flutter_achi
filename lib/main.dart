import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/MVVM/views/LandingView/splash_screen/splash_screen.dart';
import 'package:memo_neet/constants/app_theme.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/utils/helpers/hive_init_helper.dart';
import 'package:memo_neet/utils/helpers/images_cache_helper.dart';
import 'package:memo_neet/utils/helpers/providers.dart';
import 'package:memo_neet/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  Constant.prefs = await SharedPreferences.getInstance();
  if (kIsWeb) {
    await Firebase.initializeApp(options: Constant.firebaseOptions);
  } else {
    await Firebase.initializeApp();
  }
  await initializeDb();
  await cacheImageList();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.lightThemeData,
        initialRoute: SplashScreen.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
