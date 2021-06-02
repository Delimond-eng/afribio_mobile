import 'dart:convert';

//import 'package:afribio/models/cart_detail_model.dart';
import 'package:afribio/models/produit_model.dart';
import 'package:afribio/pages/auth/login_page.dart';
import 'package:afribio/pages/costumer/cart_page.dart';
//import 'package:afribio/services/cart_manage_service.dart';
import 'package:afribio/services/http_service.dart';
import 'package:afribio/utilities/globals.dart';
import 'package:afribio/widgets/card_product_wigdet.dart';
import 'package:afribio/widgets/grid_shimmer_widget.dart';
import 'package:afribio/widgets/input_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final counterController = TextEditingController();
  final textSearch = TextEditingController();
  List<Produits> produitList = [];
  List<Produits> searchFound = [];

  int cartCount = 0;

  void initCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int localCart = prefs.getInt("cart_count");
    setState(() {
      cartCount = localCart == null || localCart == 0 ? 0 : localCart;
    });
  }

  @override
  void initState() {
    super.initState();
    initCartCount();
  }

  void addToCart({produitId, qte, posId, pu, delay}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pos_vente_id = prefs.getString("pos_vente_id") ?? "";
    EasyLoading.show(status: "ajout en cours...");
    try {
      HttpService.getCartDetails(
              produitId: produitId,
              quantite: qte,
              posId: posId,
              prix: pu,
              delaiLivraison: delay,
              posVenteId: pos_vente_id == null || pos_vente_id == ""
                  ? ""
                  : pos_vente_id)
          .then((data) {
        print(data.commande.status);
        if (data.commande.status == "success") {
          EasyLoading.dismiss();
          String arrJson = jsonEncode(data.commande.detail);
          prefs.setString("pos_vente_id", data.commande.posVenteId.toString());
          prefs.setString("cartJsonArr", arrJson);
          prefs.setInt("cart_count", data.commande.detail.length);

          setState(() {
            cartCount = data.commande.detail.length;
          });
          prefs.getString("cartJsonArr");
        }
      });
    } catch (e) {
      print("error from : $e");
    }
  }

  onSearchTextChanged(String text) async {
    produitList.clear();
    HttpService.getAllProduct().then((data){
      setState(() {
        produitList = data.produits;
      });
    });
    searchFound =
        produitList.where((i) => i.titre.toLowerCase().contains(text)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenu sur",
              style: TextStyle(
                  fontSize: 10, color: Colors.black45, letterSpacing: 1.5),
            ),
            Text(
              "afribio",
              style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.green[900]),
        actions: [
          Badge(
            badgeContent: Text(
              "$cartCount",
              style: TextStyle(color: Colors.white),
            ),
            position: BadgePosition.topEnd(top: 10, end: 3),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(),
                          maintainState: true));
                }),
          ),
          popMenu(context)
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
              height: 50.0,
              padding: EdgeInsets.only(
                  top: 2.0, right: 16.0, left: 16.0, bottom: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.grey[200],
              ),
              child: TextField(
                style: TextStyle(fontSize: 14.0),
                keyboardType: TextInputType.text,
                controller: textSearch,
                decoration: InputDecoration(
                  hintText: 'Recherche...',
                  hintStyle: TextStyle(color: Colors.grey),
                  icon: Icon(Icons.search_rounded, color: Colors.black38),
                  border: InputBorder.none,
                  counterText: '',
                ),
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child:FutureBuilder<ProductModel>(
                future: HttpService.getAllProduct(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            (MediaQuery.of(context).size.shortestSide <=
                                600)
                                ? 2
                                : 8,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.75),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return GridShimmer();
                        });
                  } else {
                    return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.produits.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            (MediaQuery.of(context).size.shortestSide <=
                                600)
                                ? 2
                                : 8,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.75),
                        itemBuilder: (context, index) {
                          return CardProduct(
                            produit: snapshot.data.produits[index],
                            onSelectedProduct: () => commandBottomSheet(context,
                                image: snapshot.data.produits[index].image,
                                titre: snapshot.data.produits[index].titre,
                                onAddToCart: () => addToCart(
                                    produitId:
                                    snapshot.data.produits[index].produitId,
                                    posId: snapshot.data.produits[index].posId,
                                    qte: counterController.text,
                                    delay: snapshot
                                        .data.produits[index].delaiLivraison,
                                    pu: snapshot
                                        .data.produits[index].prixUnitaire)),
                          );
                        });
                  }
                },
              )
            ),
          ),
        ],
      ),
    );
  }

  void commandBottomSheet(BuildContext context,
      {image, titre, Function onAddToCart}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  image,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Text(
                                titre,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "Veuillez entrer la quantité en Kg de ce produit que vous voulez commander !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          child: InputCounter(
                            controller: counterController,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green[900], Colors.green[600]],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                onAddToCart();
                                Future.delayed(Duration(seconds: 5));
                                Navigator.pop(context);
                              },
                              child: Text(
                                "ajouter au panier".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0),
                              )),
                        )
                      ],
                    )
                  ],
                )),
          );
        });
  }
}

Widget popMenu(BuildContext context) {
  return PopupMenuButton(
      onSelected: (value) {
        if (value == 1) {
          showAlertDialog(
            context: context,
            title: "Alerte !",
            content: "Etes-vous sûr de vouloir vous deconnecter ?",
            onOk: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("acheteur_id", "");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          );
        } else if (value == 2) {
          showAlertDialog(
            context: context,
            title: "Alerte !",
            content: "voulez-vous vraiment fermer cette application ?",
            onOk: () {
              exit(0);
            },
          );
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.lock_rounded),
                    ),
                    Text('Deconnecter')
                  ],
                )),
            PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(Icons.clear_rounded),
                    ),
                    Text('Fermer')
                  ],
                )),
          ]);
}
