import 'package:flutter/material.dart';
import 'package:passline/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passline"),
      ),
      body: Items(),
    );
  }
}
