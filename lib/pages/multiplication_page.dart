import 'dart:async';

import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:times_table/Widgets/card_number.dart';
import 'package:times_table/src/multiplication.dart';

class MultiplicationTablePage extends StatefulWidget {
  final String title;
  final maxSeconds;

  MultiplicationTablePage(this.title, {this.maxSeconds}) : super() {
    if (this.title == null || this.title.isEmpty) throw ArgumentError();
  }

  @override
  _MultiplicationTableState createState() =>
      _MultiplicationTableState(maxSeconds: 20);
}

class _MultiplicationTableState extends State<MultiplicationTablePage> {
  IMultiplication multiplication = Multiplication();

  var maxSeconds;

  String _calc() => multiplication.randomCalc();

  int _answersRight = 0;
  int _answersWrong = 0;
  int _countdownTimer = 0;
  Timer _timer;
  String _currentCalc;

  var focusNode = new FocusNode();
  var _textEditingControler = TextEditingController();
  AnimationController controller;
  final String appId = 'ca-app-pub-3940256099942544~3347511713';
  final String bannerUnitId = 'ca-app-pub-3940256099942544/6300978111';
  Ads ads;

  _MultiplicationTableState({this.maxSeconds});

  @override
  void initState() {
    super.initState();
    _currentCalc = _calc();
    _countdownTimer = maxSeconds;
    startTimer();
    ads = Ads(appId, bannerUnitId: bannerUnitId);
    ads.showBannerAd(state: this);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_countdownTimer < 1) {
            _answersWrong++;
            restartTimer();
          } else {
            setState(() {
              _countdownTimer--;
            });
          }
        },
      ),
    );
  }

  cardForNumber(BuildContext context, Color color, String key, int value) =>
      Card(
        color: color,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            value.toString(),
            key: Key('key'),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: CardNumber(Key('countdown'),
                    color: Colors.white,
                    value: _countdownTimer,
                    style: Theme.of(context).textTheme.headline1),
              ),
              Expanded(
                child: CardNumber(Key('answersWrong'),
                    color: Colors.redAccent,
                    value: _answersWrong,
                    style: Theme.of(context).textTheme.headline1),
              ),
              Expanded(
                child: CardNumber(Key('answersRight'),
                    color: Colors.green,
                    value: _answersRight,
                    style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Text(
                      _currentCalc,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.end,
                  key: Key('txtResult'),
                  focusNode: focusNode,
                  controller: _textEditingControler,
                  autofocus: true,
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [
                    new FilteringTextInputFormatter.deny(
                      new RegExp('[\\.,\\- ]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Resposta',
                  ),
                  onFieldSubmitted: (value) {
                    fireAnswer(
                      value: value,
                      multiplication: multiplication,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  fireAnswer({
    String value,
    Multiplication multiplication,
  }) {
    setState(() {
      if (value == multiplication.getCurrentResult().toString()) {
        _answersRight++;
      } else {
        _answersWrong++;
      }

      restartTimer();
    });
  }

  void restartTimer() {
    _countdownTimer = maxSeconds;
    _currentCalc = _calc();

    _textEditingControler.text = '';
    FocusScope.of(context).requestFocus(focusNode);
  }
}
