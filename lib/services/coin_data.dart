import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getPrice(String coin, String kurs) async {
    var url = Uri.https(kURL, 'v1/exchangerate/$coin/$kurs', {
      'apikey': kAPIKey,
    });

    NetworkHelper networkHelper = NetworkHelper(url);

    var coinData = await networkHelper.getData();
    return coinData;
  }
}
