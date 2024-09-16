import 'package:dio/dio.dart';
import 'package:http_bloc_task1/constants/strings.dart';

class CharactersProvider {
  late Dio dio;

  CharactersProvider() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  Future<List<dynamic>> requestData() async {
    try {
      Response response = await dio.get('character');
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
