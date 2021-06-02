import 'dart:convert';

import 'package:afribio/models/cart_detail_model.dart';
import 'package:afribio/services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartManager{
  static void addToCart({produitId, qte, posId, pu, delay}) async {
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
        }
      });
    } catch (e) {
      print("error from : $e");
    }
  }

  static Future<List<Detail>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonCartArr = prefs.getString("cartJsonArr");
    Iterable i = jsonDecode(jsonCartArr);
    List<Detail> detailList = List<Detail>.from(i.map((model) => Detail.fromJson(model)));
    return detailList;
  }
}
