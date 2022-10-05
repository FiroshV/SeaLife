import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sealife/providers/app_provider.dart';
import 'package:sealife/utils/hero_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late AnimationController animateController;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final pages = heroImages
        .map((key, value) {
          return MapEntry(
            key,
            Stack(children: [
              Container(
                color: const Color.fromARGB(255, 2, 0, 39),
                width: deviceWidth,
                height: deviceHeight,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      value['image'],
                      fit: BoxFit.cover,
                    ),
                    Text(
                      value['name'],
                      style: const TextStyle(
                          fontFamily: 'EastSeaDokdo',
                          color: Colors.white,
                          fontSize: 80),
                    ),
                  ],
                ),
              ),
            ]),
          );
        })
        .values
        .toList();

    return Stack(children: [
      PageView.builder(
        controller:
            Provider.of<AppProvider>(context, listen: false).pageViewController,
        onPageChanged: (index) {
          Provider.of<AppProvider>(context, listen: false).setPageIndex(index);

          animateController.reset();
          animateController.forward();
        },
        itemBuilder: (_, index) {
          return pages[index % pages.length];
        },
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 100,
        child: Center(
          child: SmoothPageIndicator(
            controller: Provider.of<AppProvider>(context, listen: false)
                .pageViewController,
            count: pages.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.white,
              activeDotColor: Colors.white,
              expansionFactor: 4,
              spacing: 5.0,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: BounceInDown(
          manualTrigger: true,
          controller: (controller) => animateController = controller,
          from: 50,
          child: RotatedBox(
            quarterTurns: 3,
            child: GestureDetector(
              onTap: () {},
              child:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }
}
