import 'package:bloc/bloc.dart';
import 'package:http_bloc_task1/data/models/characters.dart';
import 'package:http_bloc_task1/data/repository/characters_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charactersRepo;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepo) : super(CharactersInitial());

  List<Character> loadCharacters() {
    charactersRepo.retrieveCharacters().then((characters) {
      emit(
        CharactersLoaded(
          characters,
        ),
      );
      this.characters = characters;
    });
    return characters;
  }
}
