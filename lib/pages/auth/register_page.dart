import 'package:afribio/pages/auth/login_page.dart';
import 'package:afribio/screens/home_screen_costumer.dart';
import 'package:afribio/services/auth_service.dart';
import 'package:afribio/utilities/globals.dart';
import 'package:afribio/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _textEmail = TextEditingController();
  final _textNom = TextEditingController();
  final _textPhone = TextEditingController();
  final _textPass = TextEditingController();
  final _textCodeVerification = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _register(),
    );
  }

  Widget _register() {
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
                      'Création compte'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black54,
                          letterSpacing: 2.0),
                    ),
                    alignment: Alignment.topCenter,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                InputText(
                  hintText: 'Entrez votre nom complet...',
                  icon: Icons.assignment_ind_outlined,
                  inputController: _textNom,
                  isPassWord: false,
                ),
                SizedBox(
                  height: 12.0,
                ),
                InputText(
                  hintText: 'Entrez le n° de téléphone',
                  icon: Icons.call_outlined,
                  inputController: _textPhone,
                  isPassWord: false,
                  keyType: TextInputType.phone,
                ),
                SizedBox(
                  height: 12.0,
                ),
                InputText(
                  hintText: 'Adresse e-mail (optionnel)',
                  icon: Icons.mail_outline_rounded,
                  inputController: _textEmail,
                  isPassWord: false,
                  keyType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 12.0,
                ),
                InputText(
                  hintText: 'Entrez le mot de passe...',
                  inputController: _textPass,
                  isPassWord: true,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 15, 32, 12),
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
                        if (_textNom.text == "") {
                          EasyLoading.showInfo(
                              "votre nom complet est réquis ! ");
                          return;
                        }
                        if (_textPhone.text == "") {
                          EasyLoading.showInfo(
                              "votre numéro de téléphone est réquis ! ");
                          return;
                        }

                        if (_textPass.text == "") {
                          EasyLoading.showInfo(
                              "veuillez entrer le mot de passe ! ");
                          return;
                        }
                        EasyLoading.show(
                            status: "traitement en cours...",
                            maskType: EasyLoadingMaskType.black);

                        Authenticate.registerCustomer(
                                email: _textEmail.text,
                                fullname: _textNom.text,
                                phone: _textPhone.text,
                                pwd: _textPass.text)
                            .then((jsonData) async {
                          if (jsonData.reponse.status == "verification") {
                            await prefs.setString("acheteur_id",
                                jsonData.reponse.acheteurId.toString());
                            EasyLoading.dismiss();

                            showAlertVerificationDialog(
                                context: context,
                                controller: _textCodeVerification,
                                title: jsonData.reponse.message,
                                onOk: () {
                                  EasyLoading.show();
                                  Authenticate.verifyUser(
                                          userId: jsonData.reponse.acheteurId
                                              .toString(),
                                          code: _textCodeVerification.text)
                                      .then((res) async {
                                    if (res["reponse"]["status"] == "success") {
                                      EasyLoading.showSuccess(
                                          "La création du compte afribio est effectuée avec succès,  veuillez vous connectez en toute securité !",
                                          duration: Duration(seconds: 5),
                                          maskType: EasyLoadingMaskType.black);
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreenCost()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      EasyLoading.showInfo(
                                          "Echec de la création du compte!",
                                          duration: Duration(seconds: 1));
                                    }
                                  });
                                });
                          } else {
                            EasyLoading.showError(
                                "erreur lors de la création du compte !",
                                duration: Duration(microseconds: 500));
                          }
                        });
                      },
                      child: Text(
                        'créer'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: 2.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vous avez déjà un compte ?  ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 1.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Connectez-vous',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.green[700],
                              letterSpacing: 1.0),
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
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              )))
        ],
      ),
    );
  }
}
