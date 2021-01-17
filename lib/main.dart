import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pub_dev_library/model/sentence.dart';
import 'package:pub_dev_library/widgets/stt_widget.dart';
import 'package:pub_dev_library/widgets/tts_widget.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Sentence()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('STT, TTS, Splash and Provider'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            STTWidget(),
            context.watch<Sentence>().text != "" ? TTSWidget() : Text(""),
          ],
        ),
      ),
    );
  }
}
