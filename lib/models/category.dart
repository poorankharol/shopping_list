import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;

  const Category(this.name, this.color);
}

enum Categories {
  dairy,
  fruit,
  meat,
  vegetables,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}
