import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/blocs/home/home.dart';

import '../../../core/core.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage({super.key, required this.bloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  // TODO: implement bloc
  HomeBloc get bloc => widget.bloc;
}
