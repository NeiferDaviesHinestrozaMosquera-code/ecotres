import 'package:flutter/cupertino.dart';

class NarbarKey{
  NarbarKey._();

  static final GlobalKey _key = GlobalKey();

  static GlobalKey getKey() => _key;
}