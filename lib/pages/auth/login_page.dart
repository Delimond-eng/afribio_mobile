import 'package:afribio/pages/auth/register_page.dart';
import 'package:afribio/screens/home_screen_costumer.dart';
import 'package:afribio/services/auth_service.dart';
import 'package:afribio/services/http_service.dart';
import 'package:afribio/utilities/globals.dart';
import 'package:afribio/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textEmail = TextEditingController();
  final _textPass = TextEditingController();
  final _textVerify = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _login(),
    );
  }

  Widget _login() {
    return SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bcImage/bio1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black87,
                Colors.transparent,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
          //Above card
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            margin: EdgeInsets.only(top: 200.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                //Header
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Align(
                    child: Text(
                      'Connexion'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black54,
                          letterSpacing: 2.8),
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                InputText(
                  hintText: 'Entrez votre email...',
                  icon: Icons.person_outline,
                  inputController: _textEmail,
                  isPassWord: false,
                  keyType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 30.0,
                ),
                InputText(
                  hintText: 'Entrez le mot de passe...',
                  icon: Icons.lock_open,
                  inputController: _textPass,
                  isPassWord: true,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 40.0, 32, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.green[900],
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (_textEmail.text == '') {
                          EasyLoading.showToast(
                              "vous devez entrer votre adresse e-mail pour vous connectez!",
                              toastPosition: EasyLoadingToastPosition.bottom,
                              duration: Duration(milliseconds: 1000));
                          return;
                        } else if (_textPass.text == '') {
                          EasyLoading.showToast(
                              "vous devez entrer votre mot de passe pour vous connectez!",
                              toastPosition: EasyLoadingToastPosition.bottom,
                              duration: Duration(milliseconds: 1000));
                          return;
                        } else {
                          if (_textEmail.text == "test@2021") {
                            HttpService.url =
                                "https://internal-test.afribio.org";
                          }
                          EasyLoading.show(
                              status: "traitement en cours...",
                              maskType: EasyLoadingMaskType.black);
                          Authenticate.loginCustomer(
                                  email: _textEmail.text, pwd: _textPass.text)
                              .then((data) async {
                            print(data.reponse.status);
                            if (data.reponse.status == "verification") {
                              await prefs.setString("acheteur_id",
                                  data.reponse.dataUser.acheteurId);
                              print("acheteur id :" +
                                  data.reponse.dataUser.acheteurId);
                              EasyLoading.dismiss();
                              showAlertVerificationDialog(
                                  context: context,
                                  controller: _textVerify,
                                  title: data.reponse.message,
                                  onOk: () async {
                                    EasyLoading.show();
                                    String acheteurId =
                                        prefs.getString("acheteur_id");
                                    Authenticate.verifyUser(
                                            userId: acheteurId,
                                            code: _textVerify.text)
                                        .then((res) {
                                      if (res["reponse"]["status"] ==
                                          "success") {
                                        EasyLoading.showSuccess(
                                            "vous êtes connectés avec succès !",
                                            duration:
                                                Duration(milliseconds: 1000),
                                            maskType:
                                                EasyLoadingMaskType.black);

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreenCost()),
                                            (Route<dynamic> route) => false);
                                      } else {
                                        EasyLoading.showInfo(
                                            "Echec de la connexion à votre compte !",
                                            duration:
                                                Duration(milliseconds: 500));
                                      }
                                    });
                                  });
                            } else if (data.reponse.status == "success") {
                              EasyLoading.showSuccess(
                                  "vous êtes connectés avec succès !",
                                  duration: Duration(milliseconds: 1000),
                                  maskType: EasyLoadingMaskType.black);
                              await prefs.setString("acheteur_id",
                                  data.reponse.dataUser.acheteurId);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreenCost()),
                                  (Route<dynamic> route) => false);
                            } else {
                              EasyLoading.showInfo(
                                  "vos identifiant ne sont pas corrects !",
                                  duration: Duration(milliseconds: 500));
                            }
                          });
                        }
                      },
                      child: Text(
                        'connecter'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 70.0, 32, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vous n\'avez pas un compte ?  ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 1.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                              (Route<dynamic> route) => true);
                        },
                        child: Text(
                          'Créer un compte',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.green[800]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Positioned to take only AppBar size
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              // Add AppBar here only
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),

          Positioned(
              top: 150,
              right: 0,
              left: 0,
              child: Center(
                  child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.green[700],
                      Colors.green[900],
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0, 2))
                    ]),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              )))
        ],
      ),
    );
  }
}
