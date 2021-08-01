import 'package:flutter/material.dart';

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFF9D9D9D),
    Color(0xFF6D6D6D),
    Color(0xFF4C4C4C),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);