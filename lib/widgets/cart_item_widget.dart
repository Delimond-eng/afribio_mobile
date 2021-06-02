import 'package:afribio/models/cart_detail_model.dart';
import 'package:flutter/material.dart';
class CartItemWidget extends StatelessWidget {
  final Function onDelete;
  final Detail cartDetail;

  CartItemWidget({Key key, this.onDelete, this.cartDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[50],
            Colors.grey[200]
          ]
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            leading: Image.network(cartDetail.image,
              fit: BoxFit.cover,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(cartDetail.titre,
                style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                  letterSpacing: 1.2
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("prix | kg",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    letterSpacing: 1.2
                  ),
                ),
                SizedBox(height: 5,),
                Text('${cartDetail.prixUnitaire} Fc',
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                    letterSpacing: 1.2
                  ),
                )
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Quantité',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    letterSpacing: 1.0
                  ),
                ),
                SizedBox(height: 5,),
                Text("${cartDetail.quantite} Kg",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0
                  ),
                ),
              ],
            )
          ),
          Positioned(
            top: -20,
            right: -5,
            child: PopupMenuButton(
                onSelected: (value) {
                  if(value ==1){
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                            child: Icon(Icons.delete_sweep_rounded),
                          ),
                          Text('Supprimer')
                        ],
                      )
                  ),
                ]
            ),
          )
        ],
      )
    );
  }
}
