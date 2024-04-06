import 'package:flutter/material.dart';

class AppWidgets {
  static centerLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static noResult(BuildContext context, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
