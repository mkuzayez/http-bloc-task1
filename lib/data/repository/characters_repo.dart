import 'package:http_bloc_task1/data/models/characters.dart';
import 'package:http_bloc_task1/data/web_services/characters.dart';

class CharactersRepo {
  final CharactersProvider charactersProvider;

  CharactersRepo(this.charactersProvider);

  Future<List<Character>> retrieveCharacters() async {
    final charactersData = await charactersProvider.requestData();
    List<Character> characters = charactersData
        .map(
          (character) => Character.fromJson(character),
        )
        .toList();
    return characters;
  }
}
