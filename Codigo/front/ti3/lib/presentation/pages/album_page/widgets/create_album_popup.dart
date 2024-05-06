import 'package:flutter/material.dart';
import 'package:ti3/presentation/pages/album_page/widgets/selected_files_viewer.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';
import 'package:file_picker/file_picker.dart';

class CreateAlbumDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Criar Álbum',
        style: TextStyle(
          fontFamily: GiraFonts.poorStory,
          color: GiraColors.loginBoxColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Título',
              labelStyle: TextStyle(fontFamily: GiraFonts.poorStory),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image, 
                    allowMultiple: true, 
                  );

                  if (result != null) {
                    List<String> filePaths =
                        result.paths.map((path) => path!).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SelectedFilesViewer(filePaths: filePaths),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 250,
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.add, size: 48),
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: TextStyle(fontFamily: GiraFonts.poorStory),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Salvar',
            style: TextStyle(fontFamily: GiraFonts.poorStory),
          ),
        ),
      ],
    );
  }
}
