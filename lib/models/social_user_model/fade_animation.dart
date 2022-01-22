import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FadeAnimation extends StatefulWidget {
 final String text;

 const FadeAnimation(this.text, {Key? key}) : super(key: key);

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    var colorizeTextStyle = GoogleFonts.portLligatSans(
      textStyle: Theme.of(context).textTheme.headline4,
      fontSize: 25,
      //color: Colors.purple,
      fontWeight: FontWeight.w700,
    );

    return SizedBox(
      width: double.infinity,
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            widget.text,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          // ColorizeAnimatedText(
          //   'Bill Gates',
          //   textStyle: colorizeTextStyle,
          //   colors: colorizeColors,
          // ),
          ColorizeAnimatedText(
            widget.text,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }
}
