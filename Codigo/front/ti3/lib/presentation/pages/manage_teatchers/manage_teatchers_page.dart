import 'package:flutter/material.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

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
        body: Column(
          children: [
            Center(
                child: Container(
              width: 300,
              child: const SearchBar(), // mudar
            )),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    // deve comportar como btn
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    width: 70,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey,
                    ),
                    child: const Text(
                      'Manhã',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: GiraFonts.poorStory,
                          fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // deve comportar como btn
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    width: 70,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey,
                    ),
                    child: const Text(
                      'Tarde',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: GiraFonts.poorStory,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
