# pub_dev_library

Proyecto para reconocimiento de voz y traducción de texto a voz.

Se utilizaron 3 librerias: flutter_native_splash, flutter_tts y speech_to_text.
Adicionalmente también se utilizó Privider

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
