import 'package:flutter/material.dart';
import 'package:ti3/data/album/dto/album_dto.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

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
            )
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
