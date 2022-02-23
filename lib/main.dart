import 'package:card_swiper/card_swiper.dart';
import 'package:feng/pages/page1.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Swiper(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Page1(color: _colors[index]);
      },
      pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(activeColor: Colors.blue)),
      controller: SwiperController(),
      scrollDirection: Axis.vertical,
      loop: false,
    ));
  }
}
