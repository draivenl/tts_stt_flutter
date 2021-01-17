import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pub_dev_library/model/sentence.dart';

class Recogniezed extends StatelessWidget {
  const Recogniezed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Recogniezed] rebuild when [Sentence] changes.
      '${context.watch<Sentence>().text}',
      style: TextStyle(
        fontSize: 25.0,
        letterSpacing: -2.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
