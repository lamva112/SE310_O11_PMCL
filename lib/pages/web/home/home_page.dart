import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/blocs/home/home.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';

import '../../../core/core.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage({super.key, required this.bloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  late final PageController _coffeController;
  late final PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeController.page!;
      // print(_currentPosition);
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _coffeController = PageController(viewportFraction: 0.4, initialPage: 4);
    _headingController = PageController(viewportFraction: 1, initialPage: 4);
    _currentPosition = _coffeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeController.addListener(_navigationListener);
  }

    @override
  void dispose() {
    // TODO: implement dispose
    _coffeController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPampas,

    );
  }

  

  @override
  // TODO: implement bloc
  HomeBloc get bloc => widget.bloc;
}
