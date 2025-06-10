import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  @override
  void initState(){
    _initSpeech();
    super.initState();
  }

  void _initSpeech() async {
    _isListening = await _speechToText.initialize();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: !_isListening,
        glowRadiusFactor: 1,
        glowColor: Colors.red,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FloatingActionButton(onPressed: _listen,
            backgroundColor: Colors.red,
            child: Icon(!_isListening ? Icons.mic : Icons.mic_none,
              color : Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Text(_text.toLowerCase(), style: const TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.w400),),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _listen() async {
    if (_isListening){
      setState(() {
        _isListening = false;
      });

      final options = SpeechListenOptions(
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true,
        sampleRate: 2,
      );
      _speechToText.listen(
        listenOptions: options,
        onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
          });
        }
      );
    } else {
      await _speechToText.stop();
      setState(() {
        _isListening = true;
      });
    }
  }
}
