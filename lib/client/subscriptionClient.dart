import 'package:tubes_ui/entity/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class SubsciptionClient {
  // url HP, di command aja jgn di hapus
  static final String url = '192.168.1.7';
  static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // url HP (thetering), di command aja jgn di hapus
  // static final String url = '192.168.43.8';
  // static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');
    int userId = userIdtemp!;
    return userId;
  }

  static Future<List<Subscription>> fetchAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdtemp = prefs.getInt('userId');
      int userId = userIdtemp!;

      var response =
          await get(Uri.http(url, "$endpoint/subscriptions/$userId"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Subscription.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Subscription> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/subscriptions/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Subscription.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Subscription subscription) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/subscriptions'),
          headers: {"Content-Type": "application/json"},
          body: subscription.toRawJson());
      print(response.body);
      if (response.statusCode == 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Subscription subscription) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/subscriptions'),
          headers: {"Content-Type": "application/json"},
          body: subscription.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> delete(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/subscriptions/$id'));
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
