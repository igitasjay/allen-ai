import 'package:allenai/openai_service.dart';
import 'package:allenai/palette.dart';
import 'package:allenai/widgets/suggestion_box.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIServicse = OpenAIService();
  final flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;
  final int start = 200;
  final int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: BounceInDown(
          child: const Text(
            'Allen AI',
            style: TextStyle(
              fontFamily: 'Cera Pro',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ZoomIn(
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  height: 123,
                  width: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.assistantCircleColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                ),
              ),
            ),
            FadeInRight(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 35).copyWith(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Palette.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topLeft: Radius.zero,
                  ),
                ),
                child: FadeInLeft(
                  delay: Duration(milliseconds: delay),
                  child: const Text(
                    'hola! i am Allen. what can i do for you today?',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Cera Pro',
                      color: Palette.mainFontColor,
                    ),
                  ),
                ),
              ),
            ),
            FadeInLeft(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Here are a few features',
                  style: TextStyle(
                    fontSize: 20,
                    color: Palette.mainFontColor,
                    fontFamily: 'Cera Pro',
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SlideInLeft(
                  delay: Duration(milliseconds: start),
                  child: const SuggestionBox(
                    color: Palette.firstSuggestionBoxColor,
                    header: 'ChatGPT',
                    description:
                        'A smarter way to stay organised and informed with ChatGPT',
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + delay),
                  child: const SuggestionBox(
                    color: Palette.secondSuggestionBoxColor,
                    header: 'Dall-E',
                    description:
                        'Get inspired and stay creative with your personal assistant powered by Dall-E',
                  ),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: start + delay * 2),
                  child: const SuggestionBox(
                    color: Palette.thirdSuggestionBoxColor,
                    header: 'Smart Voice Assistant',
                    description:
                        'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + delay * 3),
        child: FloatingActionButton(
          backgroundColor: Palette.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              // final speech = openAIService.isArtPrompt(lastWords);
              // await systemSpeak(speech as String);

              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          tooltip: 'Start Recording',
          child: const Icon(
            Icons.mic,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
