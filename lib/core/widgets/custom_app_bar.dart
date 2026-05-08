import 'package:flutter/material.dart';
import 'package:wafer/core/utils/app_colors.dart';
import 'package:wafer/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData firstIcon;
  final IconData secondIcon;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(firstIcon, size: 28, color: Colors.black.withOpacity(0.7)),
        SizedBox(width: 8),
        Icon(secondIcon, size: 28, color: Colors.black.withOpacity(0.7)),
      ],
    );
  }
}
