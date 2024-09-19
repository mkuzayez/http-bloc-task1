import 'package:flutter/material.dart';
import 'package:http_bloc_task1/business_logic/cubit/characters_cubit.dart';
import 'package:http_bloc_task1/constants/strings.dart';
import 'package:http_bloc_task1/data/models/characters.dart';
import 'package:http_bloc_task1/data/repository/characters_repo.dart';
import 'package:http_bloc_task1/data/web_services/characters.dart';
import 'package:http_bloc_task1/presentation/screens/characters.dart';
import 'package:http_bloc_task1/presentation/screens/characters_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepo = CharactersRepo(CharactersProvider());
    charactersCubit = CharactersCubit(charactersRepo);
  }

  Route? generateRoute(RouteSettings routes) {
    switch (routes.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CharactersCubit(charactersRepo),
            child: const CharactersScreen(),
          ),
        );
      case charactersDetail:
        final character = routes.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => CharactersDetailScreen(
            character: character,
          ),
        );
      default:
        const SizedBox();
    }
    return null;
  }
}
