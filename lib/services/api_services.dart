import 'package:dio/dio.dart';

import 'api_url.dart';


class ApiService {
  final Dio _dio = Dio();

  Future<dynamic> get(String url) async {
    try {
      Response response =
          await _dio.get('${ApiUrl.baseUrl}$url&APIkey=${ApiUrl.apiKey}');
      print('RESPONSE: $response');
      return response;
    } catch (error) {
      print('Error fetching live matches: $error');
      throw error;
    }
  }

}
