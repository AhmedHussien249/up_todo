import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({required this.text, super.key, this.onPressed});
final String text;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
       text,
        style: Theme.of(
          context,
        ).textTheme.displaySmall!.copyWith(
          color: AppColors.textColor.withAlpha(
            (0.44 * 255).toInt(),
          ),
        ),
      ),
    );
  }
}
