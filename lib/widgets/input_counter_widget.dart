import 'package:flutter/material.dart';

class InputCounter extends StatefulWidget {
  final controller;

  InputCounter({Key key, this.controller}) : super(key: key);

  @override
  _InputCounterState createState() => _InputCounterState();
}

class _InputCounterState extends State<InputCounter> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16)),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    blurRadius: 2, color: Colors.black45, offset: Offset(0, 2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.remove, size: 25, color: Colors.black87),
                  onPressed: () {
                    try {
                      int currentValue = int.parse(widget.controller.text);
                      currentValue--;
                      widget.controller.text =
                          (currentValue >= 1 ? currentValue : 1).toString();
                    } catch (e) {}
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Entrez la quantité...",
                  suffixText: "Kg",
                  suffixStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500)),
              controller: widget.controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
            ),
          ),
        ),
        Container(
          height: 48.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  topRight: Radius.circular(16)),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    blurRadius: 2, color: Colors.black45, offset: Offset(2, 0))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.add, size: 25, color: Colors.black87),
                  onPressed: () {
                    try {
                      int currentValue = int.parse(widget.controller.text);
                      currentValue++;
                      widget.controller.text = (currentValue).toString();
                    } catch (e) {}
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
