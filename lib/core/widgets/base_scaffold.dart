import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_forecast/core/services/cubit/conn_cubit.dart';
import 'package:flutter_forecast/core/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseScaffold extends StatelessWidget {
  final TextEditingController title;
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
        title: TextField(
          controller: title,
          readOnly: true,
          selectionControls: EmptyTextSelectionControls(),
          decoration: InputDecoration(
            prefix: SizedBox.square(
              dimension: 20.sp,
              child: SvgPicture.asset(
                LOCATION,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
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
              EasyLoading.show();
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
            EasyLoading.dismiss();
          },
          builder: (context, state) {
            if (state.isLoading && !state.isConnected) {
              return Container();
            } else if (state.isConnected && !state.isLoading) {
              return body;
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
