import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  final spinkit = SpinKitWanderingCubes(color: Colors.white, shape: BoxShape.circle);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff217DB9),
      body: spinkit,
    );
  }


}
