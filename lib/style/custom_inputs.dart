import 'package:flutter/material.dart';
import 'package:flutter_application_4/config/palette.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Palette.textColor),
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
      ),
      contentPadding: const EdgeInsets.all(10),
      hintText: hint,
      prefixIcon: Icon(icon, color: Palette.iconColor),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(fontSize: 14, color: Palette.textColor),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Palette.textColor),
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
      ),
    );
  }

  static InputDecoration boxInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationGrey({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.black),
      labelStyle: const TextStyle(color: Colors.black54),
    );
  }

  static InputDecoration boxInputDecorationSimple({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationFunctionClear(
      {required String hintText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
        hintText: hintText,
        isDense: true,
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 229, 229),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: const Icon(Icons.clear),
        ));
  }

  static InputDecoration boxInputDecorationIconAdd(
      {required String labelText,
      String? mensaje = 'Mensaje',
      required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: Tooltip(
              message: mensaje,
              child: const Icon(
                Icons.add_outlined,
              )),
        ));
  }

  static InputDecoration boxInputDecorationDatePicker(
      {required String labelText, required Function fc, double size = 18}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: Icon(Icons.calendar_today, size: size),
        ));
  }

  static InputDecoration boxInputDecorationDatePicker2(
      {required String labelText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        suffixIcon: InkWell(
            onTap: () => fc(), child: const Icon(Icons.calendar_today)));
  }

  static InputDecoration boxInputDecoration2({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecoration3({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      hintMaxLines: 2,
      prefixIcon: Icon(icon, color: Colors.grey, size: 18),
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }

  static InputDecoration boxInputDecorationDialogSearch({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.all(12.0),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }
}
