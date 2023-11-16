import 'package:flutter/material.dart';
import 'package:flutter_forecast/core/widgets/base_scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'FlutterForecast',
      colors: _colors,
      body: Container(),
    );
  }

  get _colors {
    return [Colors.black54, Colors.black38];
  }
}
