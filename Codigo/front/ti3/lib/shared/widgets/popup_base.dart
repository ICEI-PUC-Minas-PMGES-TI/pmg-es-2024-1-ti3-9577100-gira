import 'package:flutter/material.dart';

abstract class PopupBase extends StatelessWidget {
  EdgeInsets padding = const EdgeInsets.all(15);

  PopupBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [buildContent(context)],
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context);

  void close(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }
}
