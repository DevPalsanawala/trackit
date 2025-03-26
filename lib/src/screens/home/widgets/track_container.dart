import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:trackit/src/constants/color.dart';

class TrackContainer extends StatelessWidget {
  const TrackContainer({
    super.key,
    required this.isDark,
    required this.theme,
    required this.title,
    required this.value,
    this.valuecolor,
  });

  final bool isDark;
  final ThemeData theme;
  final String title;
  final String value;
  final Color? valuecolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? dSecondaryColor : dPrimaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.1),
            spreadRadius: -1,
            blurRadius: 2,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge!.copyWith(
              fontSize: 17,
            ),
          ),
          AutoSizeText(
            maxLines: 1,
            value,
            style: theme.textTheme.titleLarge!.copyWith(
              color: valuecolor,
            ),
          ),
        ],
      ),
    );
  }
}
