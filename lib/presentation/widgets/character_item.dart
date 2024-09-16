import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http_bloc_task1/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          alignment: Alignment.bottomCenter,
          child: Text(
            character.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
          color: Colors.blueGrey,
          child: character.image.isNotEmpty
              ? FadeInImage.memoryNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: character.image,
                )
              : Image(
                  image: MemoryImage(
                    kTransparentImage,
                  ),
                ),
        ),
      ),
    );
  }
}
