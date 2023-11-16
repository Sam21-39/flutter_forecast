import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_forecast/core/services/cubit/conn_cubit.dart';
import 'package:flutter_forecast/core/utils/loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final Widget body;
  const BaseScaffold({
    super.key,
    required this.title,
    required this.colors,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors[0],
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            color: colors[1],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: colors[0],
      body: BlocProvider(
        create: (context) => ConnCubit()..init(),
        child: BlocConsumer<ConnCubit, ConnState>(
          listener: (context, state) {
            if (state.isLoading && !state.isConnected) {
              Loader.show();
            } else if (state.isConnected && !state.isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            bool opacity = state.isLoading;
            if (state.isLoading && !state.isConnected) {
              return Container();
            } else if (state.isConnected && !state.isLoading) {
              return AnimatedOpacity(
                opacity: opacity ? 0 : 1,
                duration: const Duration(milliseconds: 1200),
                child: body,
              );
            }
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 36.sp),
              ),
            );
          },
        ),
      ),
    );
  }
}
