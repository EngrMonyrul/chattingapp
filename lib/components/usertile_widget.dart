import 'package:flutter/material.dart';

class UserTileDetails extends StatelessWidget {
  final String text;
  final Function() onTap;

  const UserTileDetails({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const Icon(Icons.person_pin, size: 40),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
