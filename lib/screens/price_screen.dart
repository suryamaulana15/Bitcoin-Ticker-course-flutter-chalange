import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/services/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurency = 'USD';
  dynamic btc, eth, ltc;

  @override
  void initState() {
    super.initState();

    getCoinRate();
  }

  Widget androidPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String curency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(curency),
        value: curency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurency = value;
          getCoinRate();
        });
      },
    );
  }

  Widget iOSPicker() {
    List<Text> pickersItems = [];
    for (String curency in currenciesList) {
      pickersItems.add(Text(curency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurency = (currenciesList[selectedIndex]);
        getCoinRate();
      },
      children: pickersItems,
    );
  }

  Future<dynamic> getCoinRate() async {
    List<Object> dataArray = [];
    for (String coin in cryptoList) {
      print(coin);
      print(selectedCurency);
      var test = await coinData.getPrice(coin, selectedCurency);
      dataArray.add(test);
    }

    print(dataArray);

    // var test2 = await coinData.getPrice('ETH', selectedCurency);
    // var test3 = await coinData.getPrice('LTC', selectedCurency);

    // setState(() {
    //   print(test);
    //   btc = test['rate'];
    //   eth = test2;
    //   ltc = test3;
    // });

    // print(eth);
    // print(ltc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btc USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
