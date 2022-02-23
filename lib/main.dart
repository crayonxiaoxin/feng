import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:universal_html/html.dart";

void main() {
  if (kIsWeb) {
    querySelector("#loading")?.remove();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Roboto"),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colors = [Colors.cyan, Colors.pinkAccent, Colors.deepPurpleAccent];
  final _textStyle = const TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontFamily: "LongCang",
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Swiper(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          color: _colors[index],
          child: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Positioned(
                  top: 16,
                  right: 16,
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 0),
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      TyperAnimatedText(
                          "他们所有的设备和仪器\n彷佛\n都是有生命的。\n1234567890\nABCDEFGHIJKLMNOPQRSTUVWXYZ",
                          textStyle: _textStyle,
                          textAlign: TextAlign.end,
                          speed: const Duration(milliseconds: 200),
                          curve: Curves.easeInOutQuad)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(activeColor: Colors.blue)),
      controller: SwiperController(),
      scrollDirection: Axis.vertical,
      loop: false,
    ));
  }
}
