import 'package:flutter/material.dart';
import 'dart:io' as i;


class ViewImage extends StatelessWidget {
  final String filepath;

  ViewImage({this.filepath});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.file(
        i.File(filepath)
      ),
    );
  }
}