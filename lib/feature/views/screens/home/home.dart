import 'package:flutter/material.dart';
import 'package:flutter_forecast/core/widgets/base_scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'FlutterForecast',
      colors: _colors(true),
      body: _ui(),
    );
  }

  _colors(bool isDark) {
    if (isDark) {
      return [
        Colors.black87,
        Colors.white,
      ];
    }
    return [
      Colors.white,
      Colors.black87,
    ];
  }

  _ui() {
    return Container();
  }
}
