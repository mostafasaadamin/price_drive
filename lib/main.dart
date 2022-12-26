import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:get/get.dart';
import 'package:price_tracker/main.config.dart';
import 'package:price_tracker/routes/router.dart';
import 'package:price_tracker/routes/router_names.dart';
import 'screens/price_tracker/controller/price_tracker_controller_cubit.dart';
import 'screens/price_tracker/price_tracker_screen.dart';
import 'theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              supportedLocales: const [
                Locale('ar', ''),
                Locale('en', 'US'),
              ],
              home: BlocProvider(
                create: (context) =>getIt<PriceTrackerControllerCubit>(),
                child: ScreenTracker(),
              ),
              initialRoute: priceTracker,
              onGenerateRoute: onGenerateRoute,
              opaqueRoute: Get.isOpaqueRouteDefault,
            );
          },
        );
      },
    );
  }
}
