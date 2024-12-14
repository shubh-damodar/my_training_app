import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/dashboard/presentation/widget/carousel_container_widget.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';

class BottomListBuilderWidget extends StatefulWidget {
  const BottomListBuilderWidget({super.key});

  @override
  State<BottomListBuilderWidget> createState() => _BottomListBuilderWidgetState();
}

class _BottomListBuilderWidgetState extends State<BottomListBuilderWidget> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(GetFilterDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (BuildContext context, DashboardState state) {},
      builder: (BuildContext context, DashboardState state) {
        if (state is DashboardFilterListLoadingState) return const LoadingShimmerWidget();

        List<Training> data = [];
        if (state is FilteredFromSortState) {
          data.addAll(state.trainingList ?? []);
        }

        return Expanded(
          child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            primary: true,
            padding: edgeLRTB(l: 16, r: 16, t: 16, b: 16),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 150,
                margin: const EdgeInsets.only(bottom: 16),
                width: double.infinity,
                color: ColorPalette.whiteColor,
                child: CustomText(text: data[index].trainingName),
              );
            },
          ),
        );
      },
    );
  }
}
