import 'dart:convert';
import 'dart:io';
import 'package:afribio/models/cart_detail_model.dart';
import 'package:afribio/models/produit_model.dart';
import 'package:afribio/models/user_commande_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpService {
  static String url = 'https://afribio.org';

  static Future<ProductModel> getAllProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String acheteurId = prefs.getString("acheteur_id");
    String gpsPosition = "${position.latitude} | ${position.longitude}";

    prefs.setString("gps", gpsPosition);

    final response = await http.post(
      Uri.parse('${HttpService.url}/acquereurs/produit/all'),
      headers: {HttpHeaders.authorizationHeader: 'tP@d_4gB42c'},
      body: jsonEncode(<String, dynamic>{
        'gps_position': gpsPosition,
        'acheteur_id': acheteurId,
      }),
    );
    try {
      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        print("Bad request !");
      }
    } catch (e) {}
  }

  static Future<Cart> getCartDetails(
      {produitId, quantite, posId, prix, delaiLivraison, posVenteId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Position position = await Geolocator.getCurrentPosition(
    // desiredAccuracy: LocationAccuracy.high);
    String acheteurId = prefs.getString("acheteur_id");
    String gpsPosition = prefs.getString("gps");

    http.Response response;
    if (posVenteId == "" || posVenteId == null) {
      response = await http.post(
        Uri.parse('${HttpService.url}/acquereurs/produit/commande'),
        headers: {HttpHeaders.authorizationHeader: 'tP@d_4gB42c'},
        body: jsonEncode(<String, dynamic>{
          'produit_id': '$produitId',
          'quantite': '$quantite',
          'acheteur_id': '$acheteurId',
          'gps_position': gpsPosition,
          'pos_id': '$posId',
          'prix_unitaire': '$prix',
          'delai_livraison': '$delaiLivraison',
        }),
      );
    } else {
      response = await http.post(
        Uri.parse('${HttpService.url}/acquereurs/produit/commande'),
        headers: {HttpHeaders.authorizationHeader: 'tP@d_4gB42c'},
        body: jsonEncode(<String, dynamic>{
          'produit_id': '$produitId',
          'quantite': '$quantite',
          'acheteur_id': '$acheteurId',
          'gps_position': gpsPosition,
          'pos_id': '$posId',
          'prix_unitaire': '$prix',
          'delai_livraison': '$delaiLivraison',
          'pos_vente_id': int.parse(posVenteId)
        }),
      );
    }
    final json = jsonDecode(response.body);
    if (json["error"] != null || json["error"] != "") {
      EasyLoading.showInfo("stock insuffisant!");
      return null;
    }
    return Cart.fromJson(jsonDecode(response.body));
  }

  static Future confirmCommand({adress}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String posVenteId = prefs.getString("pos_vente_id");
    String acheteurId = prefs.getString("acheteur_id");
    final response = await http.post(
        Uri.parse('${HttpService.url}/acquereurs/produit/commande/confirmer'),
        headers: {HttpHeaders.authorizationHeader: 'tP@d_4gB42c'},
        body: jsonEncode(<String, dynamic>{
          "acheteur_id": acheteurId,
          "pos_vente_id": posVenteId,
          "adresse": adress
        }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  static Future<UserCommands> getUserCommandes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String acheteurId = prefs.getString("acheteur_id");

    final response = await http.post(
        Uri.parse('${HttpService.url}/acquereurs/commandes'),
        headers: {HttpHeaders.authorizationHeader: 'tP@d_4gB42c'},
        body: jsonEncode(<String, dynamic>{"acheteur_id": acheteurId}));

    if (response.statusCode == 200) {
      return UserCommands.fromJson(jsonDecode(response.body));
    }
  }
}
