import 'package:afribio/constants.dart';
import 'package:flutter/material.dart';
class CardDrawer extends StatelessWidget {
  final String commandId;
  final String productId;
  final int quantity;
  final String customerId;
  CardDrawer({
    Key key,
    this.commandId,
    this.productId,
    this.quantity,
    this.customerId
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: DrawerHeader(
                decoration: BoxDecoration(
                    color: kDefaultColor
                ),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Align(
                      child: IconButton(
                        icon: Icon(Icons.close_sharp, color: Colors.white),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Icon(Icons.shopping_cart, color: Colors.white, size: 60,),
                        ),

                        Positioned(
                            top: -5,
                            right: 135,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Text('02',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ],
                )
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/img3.png'),
                          height: 80.0,
                          width: 70.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text("Arachides"),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date de livraison"),
                            SizedBox(height: 5.0,),
                            Text("Quantité : 20"),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close_sharp),
                          onPressed: (){

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/img4.png'),
                          height: 80.0,
                          width: 70.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text("Arachides"),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date de livraison"),
                            SizedBox(height: 5.0,),
                            Text("Quantité : 20"),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close_sharp),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/img6.png'),
                          height: 80.0,
                          width: 70.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text("Arachides"),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date de livraison"),
                            SizedBox(height: 5.0,),
                            Text("Quantité : 20"),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close_sharp),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage('assets/images/img8.png'),
                          height: 80.0,
                          width: 70.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text("Arachides"),
                        ),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date de livraison"),
                            SizedBox(height: 5.0,),
                            Text("Quantité : 20"),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close_sharp),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              height: 50,
              color: Colors.green.withOpacity(0.2),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      child: FlatButton(
                        color: Colors.green[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Text("Commander", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      child: FlatButton(
                        color: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: Text("Ajouter produit", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          print('id : $productId');
                          print('acheteur : $customerId');
                          print('commande : $commandId');
                          print('Qté : $quantity');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}