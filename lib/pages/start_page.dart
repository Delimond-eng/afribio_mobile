import 'package:afribio/pages/auth/login_page.dart';
import 'package:afribio/screens/home_screen_costumer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void checkPermission() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        EasyLoading.showInfo(
            "Veuillez activer votre position gps pour le bon fonctionnement de l'application !",
            duration: Duration(seconds: 5));
        return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        EasyLoading.showInfo(
            "Veuillez activer votre position gps pour le bon fonctionnement de l'application !",
            duration: Duration(seconds: 5));
        return null;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      String localData = prefs.getString("acheteur_id");

      if (localData == null || localData == "") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreenCost()),
            (Route<dynamic> route) => false);
      }
    }
    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Container(
        margin: EdgeInsets.all(15),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/slider2.png",
                fit: BoxFit.scaleDown,
                width: 200,
                height: 200,
              ),
            ),
            Text(
              "Bienvenu sur afribio".toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  fontSize: 25.0,
                  color: Colors.green[400],
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(0, 2))
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "Faites vos achats sur afribio et profitez de nos tarifs reduits! la qualité supérieure est sur afribio! experimentez la rapidité dans la livraison de vos produit, au maximum 45' ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
            ),
            RaisedButton(
              onPressed: checkPermission,
              color: Colors.green[700],
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Continuez'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1.5),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.green[600],
                        width: 100,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
