import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'exchange_rate.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String mSelectedCurrency = 'INR';
  var mBTCExchangeValue;
  var mETHExchangeValue;
  var mLTCExchangeValue;
  ExchangeRate exchangeRate = ExchangeRate();

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    updateBTC(await exchangeRate.getBTCExchangeRate(mSelectedCurrency));
    updateETH(await exchangeRate.getETHExchangeRate(mSelectedCurrency));
    updateLTC(await exchangeRate.getLTCExchangeRate(mSelectedCurrency));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Crypto Rate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.green,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $mBTCExchangeValue $mSelectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightGreen,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $mETHExchangeValue $mSelectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.green[300],
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $mLTCExchangeValue $mSelectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
            color: Colors.blue[200],
            child: Platform.isAndroid ? androidPicker() : iosPicker(),
          ),
        ],
      ),
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(
        Text(
          currency,
          style: TextStyle(color: Colors.black),
        ),
      );
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          mSelectedCurrency = currenciesList[selectedIndex];
          print(mSelectedCurrency);
        },
        children: pickerList);
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String currency in currenciesList) {
      dropDownList.add(
        DropdownMenuItem(
          child: Text(
            currency,
            style: TextStyle(color: Colors.black),
          ),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      dropdownColor: Colors.white,
      value: mSelectedCurrency,
      onChanged: (value) {
        setState(() async {
          mSelectedCurrency = value;
          updateBTC(await exchangeRate.getBTCExchangeRate(mSelectedCurrency));
          updateETH(await exchangeRate.getETHExchangeRate(mSelectedCurrency));
          updateLTC(await exchangeRate.getLTCExchangeRate(mSelectedCurrency));
          print(mSelectedCurrency);
        });
      },
      items: dropDownList,
    );
  }

  void updateBTC(dynamic currencyData) {
    setState(() {
      if (currencyData != null) {
        mBTCExchangeValue = currencyData['rate'];
        mBTCExchangeValue = mBTCExchangeValue.toStringAsFixed(2);
      }
    });
  }

  void updateETH(dynamic currencyData) {
    setState(() {
      if (currencyData != null) {
        mETHExchangeValue = currencyData['rate'];
        mETHExchangeValue = mETHExchangeValue.toStringAsFixed(2);
      }
    });
  }

  void updateLTC(dynamic currencyData) {
    setState(() {
      if (currencyData != null) {
        mLTCExchangeValue = currencyData['rate'];
        mLTCExchangeValue = mLTCExchangeValue.toStringAsFixed(2);
      }
    });
  }
}
