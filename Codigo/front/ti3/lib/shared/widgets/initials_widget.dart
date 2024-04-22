import 'package:flutter/material.dart';

class InitialsWidget extends StatelessWidget {
  final String name;
  final bool notTreat;
  final double? textSize;

  const InitialsWidget(
      {super.key, required this.name, this.notTreat = false, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xffc6c6c5).withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _getInitials(name),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: textSize ?? 40, color: Colors.black.withOpacity(0.8)),
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (notTreat) return name;

    name = name.trim().replaceAll(RegExp(r'[^a-zA-Z\s]+'), '').trim();
    var nameParts = name.split(' ');
    var initials = '';

    if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      initials += nameParts[0][0].toUpperCase();

      if (nameParts.length > 1) {
        initials += nameParts.last[0].toUpperCase();
      }
    }

    return initials.isEmpty ? '-' : initials;
  }
}
