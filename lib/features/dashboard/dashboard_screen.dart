import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/global_data.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/presentation/widget/bottom_list_widget.dart';
import 'package:my_training_app/features/dashboard/presentation/widget/carousel_container_widget.dart';
import 'package:my_training_app/features/dashboard/presentation/filters/presentation/filter_widget.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              BackgroundColors(),
              HeadingWidget(),
              HighlightTextWidget(),
              CarouselWidget(),
              FilterIconWidget(),
            ],
          ),
          BottomListBuilderWidget(),
        ],
      ),
    );
  }
}

class BackgroundColors extends StatelessWidget {
  const BackgroundColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 260,
          width: double.infinity,
          color: ColorPalette.redColor,
        ),
        Container(
          height: 150,
          width: double.infinity,
          color: ColorPalette.whiteColor,
        ),
      ],
    );
  }
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      child: Padding(
        padding: edgeLRTB(l: 16, r: 16),
        child: Row(
          children: [
            CustomText(
              text: "Trainings",
              size: 26,
              color: ColorPalette.whiteColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 175,
            ),
            Icon(
              Icons.menu_rounded,
              color: ColorPalette.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightTextWidget extends StatelessWidget {
  const HighlightTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 125,
      child: Padding(
        padding: edgeLRTB(l: 16, r: 16),
        child: Row(
          children: [
            CustomText(
              text: "Highlights",
              size: 19,
              color: ColorPalette.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterIconWidget extends StatelessWidget {
  const FilterIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 360,
      left: 16,
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => FilterWIdget(),
          );
          if (context.mounted) context.read<DashboardBloc>().add(FilterWithLocationEvent(newList: globalSaveList));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: edgeLRTB(l: 4, t: 5, r: 4, b: 4),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.format_list_bulleted_sharp,
                size: 11,
                color: Colors.grey,
              ),
              SizedBox(width: 2.0),
              CustomText(
                text: "Filter",
                size: 9,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
