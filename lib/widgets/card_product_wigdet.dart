import 'dart:ui';

import 'package:afribio/models/produit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  final Produits produit;
  final Function onSelectedProduct;

  CardProduct({Key key, this.produit, this.onSelectedProduct})
      : super(key: key);

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.produit.titre,
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Prix | Kg",
                  style: TextStyle(
                    fontSize: 12.0,
                    letterSpacing: 1.5,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${widget.produit.prixUnitaire} Fc',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 14.0,
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, bottom: 35, top: 0),
                      child: Image.network(
                        widget.produit.image.replaceAll("http", "https"),
                        fit: BoxFit.scaleDown,
                      )),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 1,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  gradient: LinearGradient(
                      colors: [Colors.green[800], Colors.green[400]],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
              child: FlatButton.icon(
                onPressed: widget.onSelectedProduct,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                icon: Icon(
                  Icons.shopping_basket_rounded,
                  size: 15,
                  color: Colors.white,
                ),
                label: Text(
                  "Ajouter",
                  style: TextStyle(
                      color: Colors.white, fontSize: 10, letterSpacing: 1.2),
                ),
              ),
            ),
          ),
          Positioned(
              top: 40,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange[500], Colors.redAccent]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "à livrer",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1.2,
                          fontSize: 12.0),
                    ),
                    Text(
                      'dans ${widget.produit.delaiLivraison}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          fontSize: 10),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
