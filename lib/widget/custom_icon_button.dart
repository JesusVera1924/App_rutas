import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;
  final FocusNode? focus;
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.focus,
    this.color = Colors.redAccent,
    this.isFilled = false,
  }) : super(key: key);
//Color(0xFFEE376E)
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(color.withOpacity(0.5)),
          overlayColor: MaterialStateProperty.all(color.withOpacity(0.9)),
        ),
        onPressed: () => onPressed(),
        focusNode: focus,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ));
  }
}
