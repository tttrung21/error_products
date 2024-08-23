import 'package:flutter/material.dart';

import '../Model/ColorItem.dart';

class ColorMenu extends StatelessWidget {
  const ColorMenu({super.key, required this.listColor});

  final List<ColorItem> listColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 220,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pop(listColor[index]), child: Text(listColor[index].name ?? '',textAlign: TextAlign.center,)),
          itemCount: listColor.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
        ),
      ),
    );
  }
}
