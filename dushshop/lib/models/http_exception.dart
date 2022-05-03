import 'package:flutter/material.dart';

class HttpException {
  final String message;
  HttpException(this.message);

  String toString() {
    return message;
  }
}
