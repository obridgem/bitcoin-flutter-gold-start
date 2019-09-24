import 'dart:convert';
import 'package:http/http.dart' as http;

const Map<String, String> currenciesList = {
  'AUD': 'au',
  'BRL': 'br',
  'CAD': 'ca',
  'CNY': 'cn',
  'EUR': '',
  'GBP': 'gb',
  'HKD': 'cn',
  'IDR': 'id',
  'ILS': 'il',
  'INR': 'in',
  'JPY': 'jp',
  'MXN': 'mx',
  'NOK': 'no',
  'NZD': 'nz',
  'PLN': 'po',
  'RON': 'ro',
  'RUB': 'ru',
  'SEK': 'se',
  'SGD': 'sg',
  'USD': 'us',
  'ZAR': 'za'
};

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/short';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //TODO 5: Return a Map of the results instead of a single value.
    Map<String, String> cryptoPrices = {};
    String cryptoQS = cryptoList.join(',');
    String requestURL = '$bitcoinAverageURL?crypto=$cryptoQS&fiat=$selectedCurrency';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      for (String crypto in cryptoList) {
        var lastPrice = decodedData['$crypto$selectedCurrency']['last'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      }
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return cryptoPrices;
  }
}
