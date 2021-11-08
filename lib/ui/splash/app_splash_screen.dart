import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled_flutter/ui/home/view/home_screen.dart';

import '../../data/data.dart';

class AppSplashScreen extends StatelessWidget {
  static var route = '/';

  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildSplashScreen(context));
  }

  getAnswers(BuildContext context) async {
    // var response = await getStackAnswers(
    //     page: "1", pageSize: "10", query: "stackoverflow");
    // var answersResponseFromJson =
    //     getAnswersResponseFromJson(response.toString());
    // print(answersResponseFromJson.toJson());
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, HomeScreen.route);
  }

  Widget buildSplashScreen(BuildContext context) {
    getAnswers(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildSplashColumn(),
      ),
    );
  }

  List<Widget> buildSplashColumn() {
    return [
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: Image(
          image: AssetImage("assets/images/login_image.jpg"),
        ),
      ),
      getAnimatedText(),
    ];
  }

  getAnimatedText() {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black87,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 6,
          fontFamily: GoogleFonts.mcLaren().fontFamily,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText('Hello Flutter'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
