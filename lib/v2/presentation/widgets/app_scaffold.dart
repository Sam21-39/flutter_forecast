import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatelessWidget {
  final bool isAppBarNeeded;
  final bool isBackButtonNeeded;
  final bool isbotttomNavNeeded;
  final String? title;
  final Widget body;
  final Widget? bottomNav;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.isAppBarNeeded,
    required this.isBackButtonNeeded,
    required this.isbotttomNavNeeded,
    this.title,
    required this.body,
    this.bottomNav,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: isAppBarNeeded
          ? AppBar(
              leading: isBackButtonNeeded
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  : null,
              title: Text(
                title ?? "Minimalist Forecast",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      body: body,
      bottomNavigationBar: isbotttomNavNeeded ? bottomNav : null,
      floatingActionButton: floatingActionButton,
    );
  }
}
