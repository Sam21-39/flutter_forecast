import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_forecast/core/widgets/base_scaffold.dart';
import 'package:flutter_forecast/feature/viewModels/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'FlutterForecast',
      colors: _colors(false),
      body: _ui(context),
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

  _blocLogic(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (!state.isLoading && state.weatherModel.error != null) {
          EasyLoading.showError('Weather fecthing failed');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          EasyLoading.show();
          return Container();
        }
        if (!state.isLoading && state.weatherModel.error == null) {
          EasyLoading.showSuccess('Weather fetched successfully');
          return Container();
        }
        return Container(
          padding: EdgeInsets.all(16.sp),
          height: MediaQuery.of(context).size.height * 0.85,
          child: Center(
            child: Text(
              'Valid data not found! Please, check again later!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 36.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  _ui(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () async {},
      child: BlocProvider(
        create: (context) => HomeCubit()..init(),
        child: ListView(
          shrinkWrap: true,
          children: [_blocLogic(context)],
        ),
      ),
    );
  }
}
