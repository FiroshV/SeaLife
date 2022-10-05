import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sealife/utils/fullscreen_web_view.dart';

class AboutDialogContent extends StatelessWidget {
  const AboutDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleTap(String url) => Navigator.push(
        context, CupertinoPageRoute(builder: (_) => FullscreenWebView(url)));

    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text:
                    'SeaLife is a visual showcase of the marine life of the world.\n\nThe source code is available on ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'SeaLife GitHub',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = () => handleTap('https://github.com/FiroshV/SeaLife'),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(color: Colors.black),
              ),
              const TextSpan(text: '\n\n'),
              const TextSpan(
                text: 'Built with ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Flutter',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => handleTap('https://flutter.dev'),
              ),
              const TextSpan(
                text: '\n\n',
              ),
              const TextSpan(
                text: 'Images are sourced from ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Freepik',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => handleTap('https://www.freepik.com/'),
              ),
              const TextSpan(
                text: ' and the artist is ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'upklyak',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => handleTap(
                      'https://www.freepik.com/search?author=13115374&authorSlug=upklyak&format=author&query=fish'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
