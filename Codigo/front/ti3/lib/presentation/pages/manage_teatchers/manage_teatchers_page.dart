import 'package:flutter/material.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';
import 'package:ti3/utils/gira_images.dart';

class ManageTeatchersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "GIRA",
            style: TextStyle(
              fontFamily: GiraFonts.poorStory,
              fontSize: 42,
              color: GiraColors.loginBoxColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: GiraColors.loginBoxColor,
              size: 32,
            ),
          )),
    );
  }
}
