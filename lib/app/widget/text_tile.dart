import 'package:flutter/material.dart';

Widget textTile(String label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(12),
    height: 65,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0xccd268cc),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget textTileWithPassword(String label, TextEditingController controller,
    bool isHidden, Function func) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(12),
    height: 65,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0xccd268cc),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              obscureText: isHidden,
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => func(),
              icon: Icon(
                !isHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
