import 'package:flutter/cupertino.dart';

class TextLabelCustom extends StatelessWidget {
  final String texto;

  const TextLabelCustom(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        texto,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
