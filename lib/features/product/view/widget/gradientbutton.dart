import 'package:flutter/material.dart';

Widget _detailsButton(dynamic widget) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white70, width: 1.5),
      gradient: LinearGradient(
        colors: [
          widget.color.withOpacity(.9),
          widget.color.withOpacity(.5),
        ],
      ),
    ),
    child: const Center(
      child: Text(
        "Show Details",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  );
}