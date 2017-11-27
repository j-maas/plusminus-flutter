import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController controller;

  CurrencyInput({this.controller});

  @override
  Widget build(BuildContext context) {
    return new TextField(
      decoration: new InputDecoration(hintText: "Amount"),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        new WhitelistingTextInputFormatter(new RegExp(r"\d")),
        new CurrencyTextInputFormatter(),
      ],
    );
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: Implement rendering as a currency
    return newValue;
  }
}
