import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[200],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.brown[700],
          size: 50,
        ),
      ),
    );
  }
}
