import 'package:dubai_metro_app/main.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const MyHomePage(title: 'Dubai Metro Route Planner Map')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(10),
      child: const Align(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('images/dubaimetro.png'),
        ),
      ),
    );
  }
}
