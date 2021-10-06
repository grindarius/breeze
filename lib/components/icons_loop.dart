import 'dart:async';

import 'package:flutter/material.dart';

import 'package:breeze/constants/colors.dart';
import 'package:breeze/constants/constants.dart';

class IconsLoopComponent extends StatefulWidget {
  const IconsLoopComponent({ Key? key }) : super(key: key);

  @override
  _IconsLoopComponentState createState() => _IconsLoopComponentState();
}

class _IconsLoopComponentState extends State<IconsLoopComponent> {
  late final Timer _slideshowTimer;

  final List<IconData> _icons = [
    Icons.sports_baseball,
    Icons.sports_basketball,
    Icons.sports_volleyball,
    Icons.sports_tennis,
    Icons.sports_soccer,
    Icons.sports_volleyball,
    Icons.carpenter,
    Icons.work
  ];
  int _position = 0;

  @override
  void initState() {
    _slideshowTimer = Timer.periodic(const Duration(milliseconds: spinTimeout), (_) {
      setState(() {
        int addedOne = _position += 1;
        _position = addedOne >= _icons.length ? 0 : addedOne;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _slideshowTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_icons[_position], size: 200, color: babyPowderWhite),
          const SizedBox(height: 20),
          const Text('You don\'t have any habits,'),
          const Text('click on the plus sign above to create one.')
        ]
      )
    );
  }
}
