import 'package:flutter/material.dart';

class MyColors {
  static const bg = Color(0xff181717);

  static const textPrimary = Color.fromARGB(255, 222, 222, 224);
  static const textSecondary = Color(0xff616161);

  static const cardBg = Color(0xff212020);
}

const tHistoryExerciseTitle = TextStyle(
  color: MyColors.textPrimary,
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

const tHistorySecondaryText = TextStyle(color: MyColors.textSecondary, fontSize: 14);

const tHistorySessionCardTitle = TextStyle(
  color: MyColors.textPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  overflow: TextOverflow.ellipsis,
  
);