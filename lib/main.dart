import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sealife/pages/drawer_overlay_page.dart';
import 'package:sealife/pages/landing_page.dart';
import 'package:sealife/providers/app_provider.dart';
import 'package:sealife/utils/bottam_modal_sheet.dart';
import 'package:sealife/utils/vertical_swipe_up_detector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'SeaLife',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        VerticalSwipeUpDetector(
          threshold: 0,
          onSwipeUp: (distance) {
            if (distance > 0) {
              showBarModalBottomSheet(
                context: context,
                backgroundColor: const Color.fromARGB(255, 2, 0, 39),
                builder: (context) => BottomModalSheet(
                    pageIndex: Provider.of<AppProvider>(context, listen: true)
                        .pageIndex),
              );
            }
          },
          child: const LandingPage(),
        ),
        drawerOpen
            ? Container()
            : Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      drawerOpen = true;
                    });
                    final onPopped =
                        Navigator.of(context).push(DrawerOverlayPage());
                    onPopped.then((value) {
                      setState(() {
                        drawerOpen = false;
                      });
                    });
                  },
                  child: const Hero(
                    tag: 'drawer',
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.equalizer_rounded, size: 40),
                      ),
                    ),
                  ),
                ),
              ),
      ]),
    );
  }
}
