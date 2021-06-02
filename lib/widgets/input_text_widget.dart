import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final inputController;
  final String hintText;
  final IconData icon;
  final bool isPassWord;
  final TextInputType keyType;
  final radius;

  InputText(
      {Key key,
      this.inputController,
      this.hintText,
      this.icon,
      this.isPassWord,
      this.keyType,
      this.radius})
      : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 50.0,
      padding: EdgeInsets.only(top: 2.0, right: 16.0, left: 16.0, bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.green.withOpacity(0.1),
      ),
      child: widget.isPassWord == false
          ? TextField(
              controller: widget.inputController,
              style: TextStyle(fontSize: 14.0),
              keyboardType:
                  widget.keyType == null ? TextInputType.text : widget.keyType,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(widget.icon, color: Colors.black38),
                border: InputBorder.none,
                counterText: '',
              ),
            )
          : TextField(
              controller: widget.inputController,
              keyboardType:
                  widget.keyType == null ? TextInputType.text : widget.keyType,
              obscureText: _isObscure,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                  hintText: 'Entrez le mot de passe...',
                  hintStyle: TextStyle(color: Colors.grey),
                  icon: Icon(Icons.lock_open, color: Colors.black38),
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
            ),
    );
  }
}
