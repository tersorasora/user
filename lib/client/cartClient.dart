// import 'dart:ffi';
import 'package:tubes_ui/entity/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CartClient {
  // url HP, di command aja jgn di hapus
  static final String url = '192.168.1.7';
  static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // url HP (thetering), di command aja jgn di hapus
  // static final String url = '192.168.43.8';
  // static final String endpoint = '/api_pbp_tubes_sewa_mobil/public/api';

  // static final String url = '10.0.2.2:8000';
  // static final String endpoint = '/api';

  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdtemp = prefs.getInt('userId');
    int userId = userIdtemp!;
    return userId;
  }

  static Future<List<Cart>> fetchAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userIdtemp = prefs.getInt('userId');
      int userId = userIdtemp!;

      var response = await get(Uri.http(url, "$endpoint/cart/$userId"));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Cart.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Cart> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/cart/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Cart.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(Cart cart) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/cart'),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(Cart cart) async {
    try {
      var response = await put(
          Uri.http(url, '$endpoint/cart/update/${cart.id}'),
          headers: {"Content-Type": "application/json"},
          body: cart.toRawJson());

      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateIsReviewed(id) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/cart/updateStatus/$id'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"isReviewed": 1}));

      print('kontol masuk ${response.body}');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/cart/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
