import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Placeholder Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
