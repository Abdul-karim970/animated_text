import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  double logoLeftPosition = 0;
  double logoTopPosition = 0;
  double textLeftPosition = 0;
  double textTopPosition = 0;
  var size = 58.0;
  var turns = 0.0;
  late AnimationController animationController;

  @override
  void didChangeDependencies() {
    final screenSize = MediaQuery.of(context).size;
    width = screenSize.width;
    height = screenSize.height;
    logoLeftPosition = width * 0.1;
    logoTopPosition = height * 0.42;
    textLeftPosition = width * 0.42;
    textTopPosition = height * 0.4;

    super.didChangeDependencies();
  }

  bool shouldAnimate = true;

  void _incrementCounter() async {
    if (shouldAnimate) {
      setState(() {
        logoLeftPosition = width * 0.26;
      });
      await Future.delayed(const Duration(milliseconds: 120));
      setState(() {
        textLeftPosition = width * 0.45;
      });
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        turns = 1;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        logoTopPosition = height * 0.415;
        size = 75;
      });
      shouldAnimate = false;
    } else {
      setState(() {
        logoLeftPosition = width * 0.1;

        logoTopPosition = height * 0.42;

        textLeftPosition = width * 0.42;
        size = 65;
        turns = 0.0;
        shouldAnimate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            left: logoLeftPosition,
            top: logoTopPosition,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 1200),
            child: AnimatedRotation(
                duration: const Duration(milliseconds: 500),
                turns: turns,
                child: FlutterLogo(
                  curve: Curves.bounceOut,
                  size: size,
                )),
          ),
          AnimatedPositioned(
            left: textLeftPosition,
            top: textTopPosition,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 1200),
            child: AnimatedRotation(
              duration: const Duration(microseconds: 500),
              turns: 1,
              child: Text(
                'l',
                style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(3, 3),
                          spreadRadius: 3)
                    ],
                    color: Colors.blueGrey.shade200,
                    fontSize: 70,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(microseconds: 500),
            left: width * 0.5,
            top: height * 0.4,
            child: Text(
              'utter',
              style: TextStyle(
                  shadows: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(3, 3),
                        spreadRadius: 3)
                  ],
                  color: Colors.blue.shade300,
                  fontSize: 70,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Animate',
        backgroundColor: Colors.blueGrey.shade200,
        child: const Icon(
          Icons.animation,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
