import 'package:flutter/material.dart';
import 'package:ti3/shared/widgets/initials_widget.dart';

class RoundedImageWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  final String? name;
  final double? textSize;
  final AssetImage? assetImage;

  RoundedImageWidget({
    this.color,
    this.size,
    this.assetImage,
    this.name,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: InitialsWidget(
          name: name ?? 'Seu Nome', textSize: textSize,
        ),
      ),
    );
  }
}
