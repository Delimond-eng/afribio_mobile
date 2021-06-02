import 'dart:async';

import 'package:afribio/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

showAlertDialog(
    {BuildContext context, title, content, Function onOk, Function onCancel}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(
      "Annuler".toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: 1.0,
          color: Colors.red[300]),
    ),
    onPressed: onCancel ?? () => Navigator.pop(context),
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Valider".toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: 1.0,
          color: Colors.green[900]),
    ),
    onPressed: onOk,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.help_center_rounded),
        SizedBox(
          width: 5,
        ),
        Text("$title"),
      ],
    ),
    content: Text("$content"),
    actions: [
      continueButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class CounterBloc {
  final counterController = StreamController(); // create a StreamController or
  // final counterController = PublishSubject() or any other rxdart option;
  Stream get getCount =>
      counterController.stream; // create a getter for our Stream
  // the rxdart stream controllers returns an Observable instead of a Stream

  void updateCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt("cart_count");
    int initCount = count == null || count == 0 ? 0 : count;
    counterController.sink
        .add(initCount); // add whatever data we want into the Sink
  }

  void dispose() {
    counterController
        .close(); // close our StreamController to avoid memory leak
  }
}

showAlertVerificationDialog(
    {BuildContext context, title, controller, Function onOk}) {
  // set up the buttons
  Widget continueButton = FlatButton(
    color: Colors.green,
    child: Text(
      "Valider".toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: 1.0,
          color: Colors.white),
    ),
    onPressed: onOk,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.verified_user_rounded,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Verification utilisateur",
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    ),
    content: SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "$title",
            style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),
          ),
          SizedBox(
            height: 5,
          ),
          InputText(
            hintText: "Entrez le code de 6 chiffre...",
            icon: Icons.verified_user_outlined,
            inputController: controller,
            isPassWord: false,
            keyType: TextInputType.number,
            radius: 0,
          )
        ],
      ),
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


showAlertGetAdresseDialog(
    {BuildContext context, title, controller, Function onOk}) {
  // set up the buttons
  Widget continueButton = FlatButton(
    color: Colors.green,
    child: Text(
      "Valider la commande".toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: 1.0,
          color: Colors.white),
    ),
    onPressed: onOk,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Adresse utilisateur",
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    ),
    content: SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "$title",
            style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(
              fontSize: 12
            ),
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Adresse',
              hintText: 'veuillez entrer votre adresse...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on)
            ),
          ),
        ],
      ),
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
