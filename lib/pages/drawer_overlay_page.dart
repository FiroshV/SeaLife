import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sealife/pages/about_dialog_content.dart';
import 'package:sealife/providers/app_provider.dart';
import 'package:sealife/utils/hero_images.dart';

class DrawerOverlayPage extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  void _handleAboutPressed(BuildContext context) async {
    showAboutDialog(
      context: context,
      applicationName: 'SeaLife',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2022 hsorif',
      children: [const AboutDialogContent()],
      applicationIcon: Container(
        color: const Color(0xffd5ffe6),
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          "assets/icon/icon.png",
          fit: BoxFit.cover,
          width: 52,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    final imgs = heroImages
        .map((key, value) {
          return MapEntry(
            key,
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<AppProvider>(context, listen: false)
                    .changePage(key);
              },
              child: Container(
                width: deviceWidth * 0.25,
                height: deviceWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(value['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        })
        .values
        .toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imgs[0],
                imgs[1],
                imgs[2],
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imgs[3],
                imgs[4],
                imgs[5],
              ],
            ),
            Container(
              width: deviceWidth * 0.8,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20)),
            ),
            GestureDetector(
              onTap: () => _handleAboutPressed(context),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info_outline_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'About this app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
          ],
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Hero(
              tag: 'drawer',
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child: Icon(Icons.close_rounded, size: 40, color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
