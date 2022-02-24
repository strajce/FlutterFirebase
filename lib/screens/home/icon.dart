import 'package:flutter/material.dart';

class IconView extends StatelessWidget {
  final IconData icon;
  final String title;
  const IconView({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.brown[400],
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF8D6E63),
          ),
        ),
      ],
    );
  }
}
