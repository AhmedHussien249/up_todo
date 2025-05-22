import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({required this.text, super.key, this.onPressed});
final String text;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
      Theme.of(context).elevatedButtonTheme.style,
      child: Text(text),
    );
  }
}
