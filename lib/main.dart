import 'package:flutter/material.dart' hide Router;
import 'package:provider/provider.dart';
import './ui/views/screens/all.dart';
import 'package:firebase_core/firebase_core.dart';
import './ui/styles/all.dart';
import './router.dart';
import 'locator_setup.dart';
import 'provider_setup.dart';

import 'package:parkrun_app/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashView(NextView());
  }
}

class NextView extends StatelessWidget {
  final CustomStyles customStyles = CustomStyles();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          theme: customStyles.customThemeData(),
          initialRoute: Router.initial(),
          onGenerateRoute: Router.generateRoute,
          builder: EasyLoading.init(),
        ));
  }
}
