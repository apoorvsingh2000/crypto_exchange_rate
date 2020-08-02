import 'dart:convert';

import 'coin_data.dart';
import 'package:http/http.dart' as http;

const apiKey = 'C169A15D-4C12-4D8B-B67D-DB3FF25647B6';
const baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

class ExchangeRate {
  Future getData(String url) async {
    http.Response response = await http.get(url);
    String data = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getBTCExchangeRate(String currency) async {
    var url = '$baseUrl/${cryptoList[0]}/$currency?apikey=$apiKey';
    return await getData(url);
  }

  Future getETHExchangeRate(String currency) async {
    var url = '$baseUrl/${cryptoList[1]}/$currency?apikey=$apiKey';
    return await getData(url);
  }

  Future getLTCExchangeRate(String currency) async {
    var url = '$baseUrl/${cryptoList[2]}/$currency?apikey=$apiKey';
    return await getData(url);
  }
}
