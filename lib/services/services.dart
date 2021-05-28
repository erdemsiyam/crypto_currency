import 'dart:convert';

import 'package:crypto_currency/models/coin.dart';
import 'package:crypto_currency/utils/api_key.dart';
import 'package:http/http.dart' as http;

class Services {
  static const int coinNum = 20;
  static Future<List<Coin>> getCoins() async {
    print('1');
    String url =
        'https://min-api.cryptocompare.com/data/top/totalvolfull?limit=${coinNum.toString()}&tsym=USD&api_key=$API_KEY';
    List<Coin> coins = [];
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach((json) => coins.add(Coin.fromMap(json)));
      }
      return coins;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
