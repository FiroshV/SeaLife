import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sealife/providers/app_provider.dart';
import 'package:sealife/utils/hero_images.dart';

class BottomModalSheet extends StatefulWidget {
  const BottomModalSheet({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  pageInt(BuildContext context) {
    try {
      return Provider.of<AppProvider>(context, listen: true).pageIndex;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 126, 143),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Text(
            heroImages[widget.pageIndex]['name'],
            style: const TextStyle(
                fontFamily: 'EastSeaDokdo', color: Colors.white, fontSize: 80),
          ),
          const SizedBox(height: 20),
          Text(
            "Scientific name : ${heroImages[widget.pageIndex]["info"]['scientificName']}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 20),
          Text(
            heroImages[widget.pageIndex]["info"]['brief'],
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            heroImages[widget.pageIndex]["info"]['description'],
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
