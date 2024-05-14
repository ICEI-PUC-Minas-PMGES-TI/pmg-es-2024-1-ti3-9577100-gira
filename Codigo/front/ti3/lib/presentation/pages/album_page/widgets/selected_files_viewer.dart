import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class SelectedFilesViewer extends StatelessWidget {
  final List<String> filePaths;

  SelectedFilesViewer({required this.filePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Imagens',
          style: TextStyle(
            fontFamily: GiraFonts.poorStory,
            color: GiraColors.loginBoxColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: GiraColors.loginBoxColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: PageView.builder(
                itemCount: filePaths.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.file(
                      File(filePaths[index]),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Divider(
              height: 1, 
              thickness: 1,
              color: Colors.grey[400], 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    filePaths.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.file(
                          File(filePaths[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: GiraColors.loginBoxColor,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
