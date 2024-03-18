import 'package:flutter/material.dart';
import 'package:ti3/shared/initials_widget.dart';


class RoundedImageWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  final String? name;
  final AssetImage? assetImage;

  RoundedImageWidget({
    this.color, 
    this.size, 
    this.assetImage, 
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: InitialsWidget(name: name ?? 'Seu Nome',),
      ),
    );
  }
}
