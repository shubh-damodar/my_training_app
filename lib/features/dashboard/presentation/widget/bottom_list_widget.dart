import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_training_app/collections/global_data.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/dashboard/presentation/widget/carousel_container_widget.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';
import 'package:my_training_app/utils/date_time.dart';

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
      listener: (BuildContext context, DashboardState state) {
        if (state is DashboardErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      builder: (BuildContext context, DashboardState state) {
        if (state is DashboardFilterListLoadingState) return const LoadingShimmerWidget();

        List<Training> data = [];
        if (state is FilteredFromSortState) {
          data.addAll(state.trainingList ?? []);
        }

        return data.isEmpty ? const NoDataFoundWidget() : ListViewBuilderWidget(data: data);
      },
    );
  }
}

class ListViewBuilderWidget extends StatelessWidget {
  final List<Training> data;

  const ListViewBuilderWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        primary: true,
        padding: edgeLRTB(t: 8),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => context.push('/summeryOfTrainingScreen', extra: data[index]),
            child: Container(
              height: 150,
              margin: const EdgeInsets.only(bottom: 8, right: 16, left: 16, top: 8),
              padding: edgeAll(16),
              width: MediaQuery.of(context).size.width,
              color: ColorPalette.whiteColor,
              child: Row(
                children: [
                  RightCardDetails(data: data[index]),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(35, (int _) {
                        return Expanded(
                          child: Container(
                            width: 1,
                            height: 2,
                            color: Colors.grey,
                            margin: edgeLRTB(b: 2),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 10),
                  RightCardDetails(data: data[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LeftCardDetails extends StatelessWidget {
  final Training data;
  const LeftCardDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text: mmmDd(data.startTime),
                fontWeight: FontWeight.w700,
              ),
              const CustomText(
                text: " - ",
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: '${dd(data.endTime)},',
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          CustomText(
            text: yyyy(data.startTime),
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 10),
          CustomText(
            text: "${formatTime(data.startTime)} - ${formatTime(data.endTime)}",
            size: 9,
            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          CustomText(
            text: data.address,
            size: 11,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class RightCardDetails extends StatelessWidget {
  final Training data;
  const RightCardDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomText(
            text: data.highlight,
            size: 10,
            fontWeight: FontWeight.w600,
            color: ColorPalette.redColor,
          ),
          CustomText(
            text: '${data.trainingName} (${data.rating})',
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      data.profileImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_add_alt_outlined,
                        size: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: data.work,
                    size: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: data.trainer,
                    size: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorPalette.redColor,
                  ),
                  padding: edgeLRTB(l: 10, r: 10, t: 5, b: 5),
                  child: CustomText(
                    text: "Enroll Now",
                    size: 12,
                    color: ColorPalette.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeLRTB(t: 20),
      child: Column(
        children: [
          const CustomText(text: "No Data Found!!!"),
          InkWell(
            onTap: () {
              globalSaveList.clear();
              context.read<DashboardBloc>().add(FilterWithLocationEvent(newList: globalSaveList));
            },
            child: const CustomText(
              text: "Clear Filters",
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
