import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/presentation/pages/album_page/widgets/create_album_popup.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isMorningSelected = false;
  bool isAfternoonSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                children: [
                  const Text('Exemplo 1',
                      style: TextStyle(
                          fontFamily: GiraFonts.poorStory, fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: () => _goToAllPictures(context, 'Exemplo 1'),
                    child: Container(
                      width: 80,
                      padding:
                          const EdgeInsets.only(left: 15, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          color: GiraColors.loginBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Ver mais',
                        style: TextStyle(
                            fontFamily: GiraFonts.poorStory,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                children: [
                  const Text('Exemplo 2',
                      style: TextStyle(
                          fontFamily: GiraFonts.poorStory, fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: () => _goToAllPictures(context, 'Exemplo 2'),
                    child: Container(
                      width: 80,
                      padding:
                          const EdgeInsets.only(left: 15, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          color: GiraColors.loginBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Ver mais',
                        style: TextStyle(
                            fontFamily: GiraFonts.poorStory,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                children: [
                  const Text('Exemplo 3',
                      style: TextStyle(
                          fontFamily: GiraFonts.poorStory, fontSize: 18)),
                  Spacer(),
                  InkWell(
                    onTap: () => _goToAllPictures(context, 'Exemplo 3'),
                    child: Container(
                      width: 80,
                      padding:
                          const EdgeInsets.only(left: 15, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                          color: GiraColors.loginBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Ver mais',
                        style: TextStyle(
                            fontFamily: GiraFonts.poorStory,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 300, top: 80),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CreateAlbumDialog(),
                  );
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: GiraColors.loginBoxColor,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _goToAllPictures(BuildContext context, String title) {
    Get.toNamed(Paths.allImagesPage, arguments: {
      'title': title,
    });
  }
}
