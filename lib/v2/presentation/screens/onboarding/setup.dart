import 'package:flutter/material.dart';
import 'package:flutter_forecast/v2/presentation/widgets/app_scaffold.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      isAppBarNeeded: true,
      isBackButtonNeeded: false,
      isbotttomNavNeeded: false,
      title: "",
      body: SizedBox(),
    );
  }
}
