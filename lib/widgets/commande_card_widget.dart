import 'package:afribio/models/user_commande_model.dart';
import 'package:flutter/material.dart';

class CommandeCard extends StatelessWidget {
  final Commandes commandeItem;
  final List<Details> details;
  final int total;

  CommandeCard({Key key, this.commandeItem, this.details, this.total})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 2),
      height: 180,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Commande",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      letterSpacing: 1.5,
                      color: Colors.green[900]),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 5, right: 5),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.departure_board_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Livraison dans ${commandeItem.delaiLivraison}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[400], width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Center(
                            child: Image.network(
                              details[index].image.replaceAll("http", "https"),
                              width: 50,
                              height: 50,
                              fit: BoxFit.scaleDown,
                            ),
                          )),
                          Text(
                            details[index].titre,
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Prix: ${details[index].prixUnitaire}Fc",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                                fontSize: 10),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "QTE: ${details[index].quantite} Kg",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
