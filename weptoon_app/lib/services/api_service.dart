import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weptoon_app/models/webtoon_episode_model.dart';
import 'package:weptoon_app/models/webtoon_model.dart';

import '../models/webtoon_detail_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today'); //api 주소로 데이터 받기
    final response = await http.get(url); //await 과 async 세트
    if (response.statusCode == 200) {
      final List<dynamic> webtoons =
          jsonDecode(response.body); //api 데이터 리스트에 저장후 webtoonInstances에 저장
      for (var wetbtoon in webtoons) {
        webtoonInstances.add(
          WebtoonModel.fromJson(wetbtoon),
        );
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id'); //api 주소로 데이터 받기
    final response = await http.get(url); //await 과 async 세트
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes'); //api id주소로 에피소드 데이터 받기
    final response = await http.get(url); //await 과 async 세트
    if (response.statusCode == 200) {
      final episodes =
          jsonDecode(response.body); //바디에서 정보 받아서 json 변환 후 episodes에 저장
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(
            episode)); //episodesInstances에 배열로 정보 저장
      }
      return episodesInstances;
    }
    throw Error();
  }
}
