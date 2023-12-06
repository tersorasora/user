// import 'dart:ffi';
import 'package:tubes_ui/entity/car.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CarClient {
  // url HP (wifi), di command aja jgn di hapus
  static final String url = '192.168.1.7';
  static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // url HP (thetering), di command aja jgn di hapus
  // static final String url = '192.168.43.8';
  // static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // static final String url = '10.0.2.2:8000';
  // static final String endpoint = '/api';

  static Future<List<Car>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, "$endpoint/car"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Car.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Car> fetch(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/car/$id'));

      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch car data: ${response.reasonPhrase}');
      }

      var responseData = json.decode(response.body);

      return Car.fromJson(responseData);
    } catch (e) {
      print('Error in find method: $e');
      return Future.error('Failed to fetch car data.');
    }
  }
}
