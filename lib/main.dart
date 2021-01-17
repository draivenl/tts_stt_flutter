import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pub_dev_library/model/sentence.dart';
import 'package:pub_dev_library/widgets/stt_widget.dart';
import 'package:pub_dev_library/widgets/tts_widget.dart';

// ignore: unused_import
import 'package:flutter_native_splash/flutter_native_splash.dart';

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

/**
 * Tomado del README.md
 * 
 ## Instalación

Todas las dependencias deben estar en el archivo pubspec.yaml

```dart
dependencies:
  flutter:
    sdk: flutter
  flutter_native_splash: ^0.2.6
  flutter_tts: ^2.1.0
  speech_to_text: ^3.1.0
  provider: ^4.3.2+4
```

y correr el comando

```dart
flutter pub get
```

## [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

Se utilizar para generar un splash o pantalla inicial cuando carga la aplicación. Los splash son muy utilizado para agregar el logo de la empresa o de la aplicación y no ingresar inmediatamente al home.

para utilizarlo de debe agregar a las dependencias en el archivo pubspecyaml flutter_native_splash: ^0.2.6

dependencia: flutter_native_splash: ^0.2.6

y por último importarlo en el main.dart

```dart
import 'package:flutter_native_splash/flutter_native_splash.dart';
```

## [speech_to_text](https://pub.dev/packages/speech_to_text/)

Toma la voz reconicida por el micrófono y la convierte a texto. Me gusta laparte de reconocimiendo de voz para permitir que los usuarios puedaningresar
comandos de voz para interactuar con la aplicación ya sea para agilizar laescritura o en caso de tener ocupadas las manos poder indicar por voz lo quese
quiere hacer.

dependencia : speech_to_text: ^3.1.0

se importan las librerias necesarias

```dart
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
```

Se instancia el objeto SpeechToText()

```dart
final SpeechToText speech = SpeechToText();
```

para inicializarlo se utiliza

```dart
speech.initialize(...)
```

para escuchar

```dart
speech.listen(...)
```

Parar

```dart
speech.stop();
```

Cancelar

```dart
speech.cancel();
```

Validar si está escuchando

```dart
speech.isListening()
```

## [flutter_tts](https://pub.dev/packages/flutter_tts/)

Al contrario del anterior, se utiliza para convertir un texto a voz. Tambienme llama la atencón para poder dar feedback al usuario de que fue lo que reconoció anteriormente, o de algun texto que lea desdeuna base de datos o de un api por ejemplo de traducción.

dependencia: flutter_tts: ^2.1.0

se importan las librerias necesarias

```dart
import 'package:flutter_tts/flutter_tts.dart';
```

Se crea el objeto

```dart
FlutterTts flutterTts =FlutterTts();
```

Con el método speak(texto) se convierte el texto que se ingrese a voz

```dart
flutterTts.speak(textRecognized);
```

Para parar o pauser se utilizan los siguientes métodos

```dart
flutterTts.stop();
flutterTts.pause();
```
 */
