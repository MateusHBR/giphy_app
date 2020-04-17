import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  String search;
  int offset = 0;

  Future<Map> getGifs() async {
    http.Response response;

    if (search == null) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=g2Pv6xhRq9ivgc2qyYWwt6OLekCjeZJl&limit=20&rating=G");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=g2Pv6xhRq9ivgc2qyYWwt6OLekCjeZJl&q=$search&limit=20&offset=$offset&rating=G&lang=pt");
    }
    return json.decode(response.body);
  }
}
