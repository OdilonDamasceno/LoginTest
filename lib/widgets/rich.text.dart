import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatefulWidget {
  final String simpleText;
  final String presText;
  final Function onPressed;
  final TextStyle pressStyle;
  final TextStyle simpleStyle;
  const CustomRichText({
    Key key,
    this.simpleStyle = const TextStyle(),
    this.simpleText,
    this.presText,
    this.onPressed,
    this.pressStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);
  @override
  _CustomRichTextState createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: widget.simpleText,
        children: <TextSpan>[
          TextSpan(
            text: widget.presText,
            style: widget.pressStyle,
            recognizer: TapGestureRecognizer()..onTap = widget.onPressed,
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: widget.simpleStyle,
    );
  }
}
