import 'package:afribio/models/user_commande_model.dart';
import 'package:afribio/services/http_service.dart';
import 'package:afribio/widgets/commande_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';

class UserCommandePage extends StatefulWidget {
  UserCommandePage({Key key}) : super(key: key);

  @override
  _UserCommandePageState createState() => _UserCommandePageState();
}

class _UserCommandePageState extends State<UserCommandePage> {
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_rounded,
              size: 20,
              color: Colors.black87,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Mon afribio",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  letterSpacing: 2,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 2, bottom: 2),
          child: FutureBuilder<UserCommands>(
            future: HttpService.getUserCommandes(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                // EasyLoading.show();
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (__, _) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[100],
                        highlightColor: Colors.green[100],
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          margin: EdgeInsets.all(2),
                          color: Colors.grey[100],
                        ));
                  },
                );
              } else if (snapshot.hasData==false) {
                return Center(
                  child: Text(
                    "Vous n'avez de commande en cours ",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 18.0,
                        letterSpacing: 1.5),
                  ),
                );
              } else {
                EasyLoading.dismiss();
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.commandes.length,
                    itemBuilder: (context, index) {
                      return CommandeCard(
                        commandeItem: snapshot.data.commandes[index],
                        details: snapshot.data.commandes[index].details,
                      );
                    });
              }
            },
          )),
    );
  }
}
