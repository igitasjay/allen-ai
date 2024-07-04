import 'package:flutter/material.dart';

class SuggestionBox extends StatelessWidget {
  final Color color;
  final String header;
  final String description;
  const SuggestionBox({
    super.key,
    required this.color,
    required this.header,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
