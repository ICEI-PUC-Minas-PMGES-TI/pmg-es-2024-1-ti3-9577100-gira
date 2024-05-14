import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/presentation/pages/album_page/widgets/selected_files_viewer.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';
import 'package:file_picker/file_picker.dart';

class AllPicturesPage extends StatelessWidget {
  final title = Get.arguments != null ? Get.arguments['title'] : null;

  Future<void> _openGallery(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<String> filePaths = result.paths.map((path) => path!).toList();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectedFilesViewer(filePaths: filePaths),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GiraColors.loginBoxColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title ?? 'Título',
          style: TextStyle(
            fontFamily: GiraFonts.poorStory,
            color: GiraColors.loginBoxColor,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.all(8.0),
                  children: List.generate(15, (index) {
                    return Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 280,
                bottom: 30,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: GiraColors.loginBoxColor,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => _openGallery(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
