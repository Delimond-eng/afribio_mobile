import 'dart:async';
import 'dart:io';
import 'package:afribio/pages/auth/login_page.dart';
import 'package:afribio/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<DataConnectionStatus> listener;

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) async {
      if (status == DataConnectionStatus.disconnected) {
        EasyLoading.showInfo(
            'Pour utiliser afribio, activez les données mobiles ou connectez-vous au wifi!',
            maskType: EasyLoadingMaskType.black,
            duration: Duration(seconds: 10));
        await Future.delayed(Duration(seconds: 5), () {
          exit(0);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      title: 'afribio',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StartPage(),
      builder: EasyLoading.init(),
    );
  }
}
