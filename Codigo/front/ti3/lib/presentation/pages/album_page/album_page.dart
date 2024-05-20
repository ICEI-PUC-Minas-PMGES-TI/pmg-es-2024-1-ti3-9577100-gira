import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/data/album/dto/album_dto.dart';
import 'package:ti3/presentation/pages/album_page/widgets/create_album_popup.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class AlbumPage extends StatefulWidget {
  final List<AlbumDTO>? allAlbuns;

  const AlbumPage({super.key, this.allAlbuns});

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

  void _goToAllPictures(BuildContext context, String title) {
    Get.toNamed(Paths.allImagesPage, arguments: {
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: widget.allAlbuns?.length,
              itemBuilder: (context, index) {
                final album = widget.allAlbuns?[index];
                return AlbumRowItem(
                  album: album!,
                  onPressed: () => _goToAllPictures(context, album.name ?? ''),
                );
              },
            ),
          ),
          CurrentUserManager.currentUser.type != UserTypeEnum.parents ?
          Padding(
            padding: const EdgeInsets.only(left: 300, top: 20, bottom: 20),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CreateAlbumDialog(),
                );
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: GiraColors.loginBoxColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}

class AlbumRowItem extends StatelessWidget {
  final AlbumDTO album;
  final void Function() onPressed;

  const AlbumRowItem({super.key, required this.album, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(album.name ?? '', style: const TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 18)),
            const Spacer(),
            InkWell(
              onTap: onPressed,
              child: Container(
                width: 80,
                padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
                decoration: BoxDecoration(
                  color: GiraColors.loginBoxColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Ver mais',
                  style: TextStyle(fontFamily: GiraFonts.poorStory, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 110,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
