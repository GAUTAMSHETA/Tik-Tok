import 'package:flutter/material.dart';
import 'package:tiktok_app/theme/colors.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Following",
          style: TextStyle(color: white.withOpacity(0.7), fontSize: 16),
        ),
        SizedBox(width: 8),
        Text(
          "|",
          style: TextStyle(
            color: white.withOpacity(0.3),
            fontSize: 17,
          ),
        ),
        SizedBox(width: 8),
        Text(
          "For You",
          style: TextStyle(
            color: white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
