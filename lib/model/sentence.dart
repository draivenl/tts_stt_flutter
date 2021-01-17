import 'package:flutter/foundation.dart';

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin

class Sentence with ChangeNotifier, DiagnosticableTreeMixin {
  String _text = "";

  String get text => _text;

  void update(String value) {
    _text = value;
    notifyListeners();
  }

  /// Makes `Sentence` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', _text));
  }
}
