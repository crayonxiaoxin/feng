import 'package:card_swiper/card_swiper.dart';
import 'package:feng/pages/birthday_page.dart';
import 'package:feng/pages/page1.dart';
import 'package:feng/pages/page2.dart';
import 'package:feng/pages/page3.dart';
import 'package:feng/pages/page4.dart';
import 'package:feng/widgets/immersive_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      title: 'FengFeng',
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
  int _currentIndex = 0;
  final SwiperController _swiperController = SwiperController();
  final _pages = [BirthdayPage(), Page1(), Page2(), Page3(), Page4()];

  // final _pages = [Page1()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const ImmersiveAppBar(height: 0),
        body: Stack(
          children: [
            Swiper(
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _pages[index];
              },
              pagination: const SwiperPagination(
                  builder:
                      DotSwiperPaginationBuilder(activeColor: Colors.blue)),
              controller: _swiperController,
              scrollDirection: Axis.vertical,
              loop: false,
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _currentIndex < _pages.length - 1 ? 1 : 0,
                  child: InkWell(
                      onTap: () {
                        _swiperController.next();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Lottie.asset("assets/anim/down.json",
                            height: 40, width: 40),
                      )),
                ))
          ],
        ));
  }
}
