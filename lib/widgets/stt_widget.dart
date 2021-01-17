import 'package:flutter/material.dart';
import 'package:pub_dev_library/model/sentence.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:math';

import 'package:provider/provider.dart';

import 'dart:async';

class STTWidget extends StatefulWidget {
  @override
  _STTWidgetState createState() => _STTWidgetState();
}

enum TtsState { playing, stopped, paused, continued }

class _STTWidgetState extends State<STTWidget> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener, debugLogging: true);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Column(children: [
        Center(
          child: Text(
            'Speech recognition',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              child: Text(
                'Initialize',
                style: TextStyle(fontSize: 22.0),
              ),
              onPressed: _hasSpeech ? null : initSpeechState,
            ),
          ],
        ),
        _hasSpeech ? _content() : Text(""),
        Column(
          children: <Widget>[
            Center(
              child: lastError != ""
                  ? Text(
                      'Error Status: $lastError',
                      style: TextStyle(fontSize: 22.0),
                    )
                  : Text(""),
            ),
          ],
        ),
        Container(
          // padding: EdgeInsets.symmetric(vertical: 20),
          // color: Theme.of(context).backgroundColor,
          child: Center(
            child: speech.isListening
                ? Text(
                    "I'm listening...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(""),
          ),
        )
      ]),
    );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    context.read<Sentence>().update(result.recognizedWords);
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  // void _switchLang(selectedVal) {
  //   setState(() {
  //     _currentLocaleId = selectedVal;
  //   });
  //   print(selectedVal);
  // }
  Widget _content() {
    return Container(
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.record_voice_over),
            onPressed:
                !_hasSpeech || speech.isListening ? null : startListening,
          ),
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: speech.isListening ? stopListening : null,
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: speech.isListening ? cancelListening : null,
          )
        ],
      ),
      Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .26,
                spreadRadius: level * 1.5,
                color: Colors.black.withOpacity(.05))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: IconButton(
          icon: Icon(Icons.mic),
          onPressed: !_hasSpeech || speech.isListening ? null : startListening,
        ),
      ),
    ]));
  }
}
