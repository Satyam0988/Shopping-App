import 'dart:ui';

import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade100,
      width: 1.5,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.yellow.shade50,
      width: 2.75,
    ),
  ),
);

BoxDecoration customBoxDecoration = BoxDecoration(
  color: Colors.black,
  // gradient: LinearGradient(
  //     begin: Alignment.centerLeft,
  //     end: Alignment.centerRight,
  //     colors: [Color(0xFFFFBF00), Color(0xFFFF6A2B)]),
);

const iconContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.transparent),
  ),
);

BoxDecoration selectedContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(width: 3.5, color: Colors.green),
  ),
);

TextStyle regularBoldHeading = TextStyle(
  color: Colors.yellow[50],
  fontSize: 32.0,
  fontWeight: FontWeight.w900,
  shadows: <Shadow>[
    Shadow(color: Colors.black12.withOpacity(1.0), offset: Offset(1.0, 1.0)),
  ],
);

const String defaultImageURL =
    "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg";
