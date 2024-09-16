import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task1/business_logic/cubit/characters_cubit.dart';
import 'package:http_bloc_task1/data/models/characters.dart';
import 'package:http_bloc_task1/presentation/widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedByLettersCharacters;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).loadCharacters();
  }

  Widget buildWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildGridView();
        } else {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildGridView() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.indigo,
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: allCharacters.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return CharacterItem(
                  character: allCharacters[index],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        hintText: "Search by name",
      ),
      onChanged: (value) {
        searchedCharacters(value);
      },
    );
  }

  void searchedCharacters(String characters) {
    searchedByLettersCharacters = allCharacters
        .where(
          (character) => character.name.toLowerCase().startsWith(characters),
        )
        .toList();
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rick and Morty Characters",
        ),
      ),
      body: buildWidget(),
    );
  }
}
