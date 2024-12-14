import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';
import 'package:my_training_app/utils/date_time.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    dashboardBloc.add(GetAllDataEvent());
    super.initState();
  }

  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      child: BlocConsumer<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (BuildContext context, DashboardState state) {},
        builder: (BuildContext context, DashboardState state) {
          if (state is DashboardLoadingState) return const LoadingShimmerWidget();

          if (state is DashboardSuccessState && state.trainingModel.trainings.isNotEmpty) {
            return Stack(
              children: [
                CustomCursorWidget(data: state.trainingModel.trainings, buttonCarouselController: buttonCarouselController),
                CustomCursorNavigatorsWidget(buttonCarouselController: buttonCarouselController),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class LoadingShimmerWidget extends StatelessWidget {
  const LoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 160,
      child: Center(child: CircularProgressIndicator(color: ColorPalette.backgroundColor)),
    );
  }
}

class CustomCursorNavigatorsWidget extends StatelessWidget {
  const CustomCursorNavigatorsWidget({
    super.key,
    required this.buttonCarouselController,
  });

  final CarouselSliderController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => buttonCarouselController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
            splashColor: Colors.white,
            child: Container(
              height: 70,
              width: 23,
              color: ColorPalette.blackColor.withOpacity(0.3),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorPalette.whiteColor,
                size: 18,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 46,
          ),
          InkWell(
            onTap: () => buttonCarouselController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            child: Container(
              height: 70,
              width: 23,
              alignment: Alignment.center,
              color: ColorPalette.blackColor.withOpacity(0.3),
              child: Icon(
                Icons.arrow_forward_ios,
                color: ColorPalette.whiteColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCursorWidget extends StatelessWidget {
  const CustomCursorWidget({
    super.key,
    required this.data,
    required this.buttonCarouselController,
  });

  final List<Training> data;
  final CarouselSliderController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: data.length,
        carouselController: buttonCarouselController,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return InkWell(
            onTap: () {
              context.push('/summeryOfTrainingScreen', extra: data[itemIndex]);
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(9)),
              child: SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width - 70,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(data[itemIndex].backgroundImage),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  padding: edgeLRTB(l: 16, r: 16, b: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: data[itemIndex].trainingName,
                        size: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: data[itemIndex].location,
                            size: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          const CustomText(
                            text: ' - ',
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "${ddMMM(data[itemIndex].startTime)} - ${ddMMM(data[itemIndex].endTime)}",
                            size: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (data[itemIndex].offerPrice != data[itemIndex].price)
                            Text(
                              data[itemIndex].price,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                                decorationColor: Colors.red,
                                color: Colors.red,
                                fontSize: 8,
                                decorationStyle: TextDecorationStyle.solid,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          const SizedBox(width: 4),
                          CustomText(
                            text: data[itemIndex].offerPrice,
                            size: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          const CustomText(
                            text: 'View Details',
                            color: Colors.white,
                            size: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: ColorPalette.whiteColor,
                            size: 11,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
        ),
      ),
    );
  }
}
