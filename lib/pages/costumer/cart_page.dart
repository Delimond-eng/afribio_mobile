import 'package:afribio/models/cart_detail_model.dart';
import 'package:afribio/screens/home_screen_costumer.dart';
import 'package:afribio/services/cart_manage_service.dart';
import 'package:afribio/services/http_service.dart';
import 'package:afribio/utilities/globals.dart';
import 'package:afribio/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int cartTotal = 0;
  final adresseText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.shopping_basket_rounded,
              size: 18,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Mon panier",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                  color: Colors.black87),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 500,
            child: FutureBuilder<List<Detail>>(
                future: CartManager.getCart(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/panier.png",
                            fit: BoxFit.scaleDown,
                            height: 200,
                            width: 200,
                          ),
                          Text(
                            "Votre panier est vide !",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                                letterSpacing: 1.0),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Center();
                  } else {
                    EasyLoading.dismiss();
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            cartDetail: snapshot.data[index],
                            onDelete: () {
                              print('deleting !');
                            },
                          );
                        });
                  }
                }),
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[50]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Net à payer",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    FutureBuilder<List<Detail>>(
                        future: CartManager.getCart(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Text(
                              "0 Fc",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0),
                            );
                          } else {
                            for (int index = 0;
                                index < snapshot.data.length;
                                index++) {
                              int tot =
                                  int.parse(snapshot.data[index].prixUnitaire) *
                                      int.parse(snapshot.data[index].quantite);
                              cartTotal += tot;
                            }
                            return Text(
                              "$cartTotal Fc",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0),
                            );
                          }
                        })
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.green[500], Colors.green[700]]),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        showAlertGetAdresseDialog(
                            context: context,
                            controller: adresseText,
                            title: "Veuillez entrer votre adresse !!",
                            onOk: () async {
                              if (adresseText.text == "") {
                                EasyLoading.showInfo(
                                    "vous devez entrer votre adresse !",
                                    duration: Duration(seconds: 1));
                                return;
                              } else if (cartTotal == 0) {
                                EasyLoading.showInfo(
                                    "vous pouvez pas effectuer cette action tant que votre panier est vide!",
                                    duration: Duration(seconds: 1));
                                return;
                              } else {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                EasyLoading.show();
                                await HttpService.confirmCommand(
                                        adress: adresseText.text)
                                    .then((value) {
                                  print(value);
                                  if (value["error"] != null) {
                                    EasyLoading.showInfo(
                                        "Echec de la confirmation de la commande, veuillez rééssayer SVP!",
                                        duration: Duration(seconds: 2));
                                  }
                                  if (value["reponse"]["status"] == "success") {
                                    EasyLoading.showSuccess(
                                        "votre commande est effectuée !",
                                        duration: Duration(seconds: 2));
                                    prefs.setString("pos_vente_id", "");
                                    prefs.setString("cartJsonArr", "");
                                    prefs.setInt("cart_count", 0);

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreenCost()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    EasyLoading.showInfo(
                                        "Echec de la confirmation de la commande, veuillez rééssayer SVP!",
                                        duration: Duration(seconds: 2));
                                  }
                                });
                              }
                            });
                      },
                      child: Text(
                        "commander".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                            fontSize: 12.0),
                      )),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
