import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task1/business_logic/cubit/characters_cubit.dart';
import 'package:http_bloc_task1/data/models/characters.dart';
import 'package:http_bloc_task1/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

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
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: searchController.text.isEmpty
                  ? allCharacters.length
                  : searchedByLettersCharacters.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return CharacterItem(
                  character: searchController.text.isEmpty
                      ? allCharacters[index]
                      : searchedByLettersCharacters[index],
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
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearching();
          },
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget buildAppBar() {
    return const Text(
      "Rick and Morty Characters",
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Connection failed',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? const BackButton(
                color: Colors.black,
              )
            : const SizedBox(),
        title: isSearching ? buildSearchField() : buildAppBar(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected = connectivity.contains(ConnectivityResult.none);
          if (!connected) {
            return buildWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
