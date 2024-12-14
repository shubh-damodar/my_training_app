import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/const_data.dart';
import 'package:my_training_app/collections/global_data.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/presentation/filters/bloc/custom_filters_bloc.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';

class FilterWIdget extends StatelessWidget {
  FilterWIdget({super.key});

  final DashboardBloc dashboardBloc = DashboardBloc();

  final CustomFiltersBloc customFiltersBloc = CustomFiltersBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: ColorPalette.whiteColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SortAndFiltersHeadingWidget(),
          const DividerFilters(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SortWidget(dashboardBloc: dashboardBloc, customFiltersBloc: customFiltersBloc),
                FilterWidget(dashboardBloc: dashboardBloc, customFiltersBloc: customFiltersBloc),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SortWidget extends StatelessWidget {
  const SortWidget({super.key, required this.dashboardBloc, required this.customFiltersBloc});

  final DashboardBloc dashboardBloc;
  final CustomFiltersBloc customFiltersBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listener: (BuildContext context, DashboardState state) {
        if (state is FilteredFromSortState) {
          customFiltersBloc.add(SelectedFiltersEvent(selectedSortValue: state.selectedSortList));
        }

        if (state is DashboardErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      builder: (BuildContext context, DashboardState state) {
        var selectedSortString = '';

        if (state is FilteredFromSortState) {
          selectedSortString = state.selectedSortString ?? '';
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width / 2.4,
          child: ListView.builder(
            itemCount: sortingLists.length,
            shrinkWrap: true,
            padding: edgeAll(0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => dashboardBloc.add(FilterWithQueryEvent(query: sortingLists[index])),
                child: SortBuilderWidget(
                  selectedText: selectedSortString,
                  text: sortingLists[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class FilterWidget extends StatelessWidget {
  final DashboardBloc dashboardBloc;
  final CustomFiltersBloc customFiltersBloc;
  const FilterWidget({super.key, required this.dashboardBloc, required this.customFiltersBloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomFiltersBloc, CustomFiltersState>(
      bloc: customFiltersBloc,
      listener: (BuildContext context, CustomFiltersState state) {},
      builder: (BuildContext context, CustomFiltersState state) {
        if (state is CustomFiltersLoading) {
          return const Expanded(child: Center(child: CircularProgressIndicator()));
        }
        List<Map<String, dynamic>> selectedSort = [];

        if (state is SelectedFiltersState) {
          selectedSort = state.selectedSortValue ?? selectedSort;
        }

        return Expanded(
          child: ListView.builder(
            itemCount: selectedSort.length,
            shrinkWrap: true,
            padding: edgeLRTB(l: 16, r: 16),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Checkbox(
                    value: selectedSort[index]['isSelected'] as bool,
                    checkColor: Colors.white,
                    focusColor: ColorPalette.redColor,
                    hoverColor: ColorPalette.redColor,
                    activeColor: ColorPalette.redColor,
                    overlayColor: WidgetStatePropertyAll(ColorPalette.redColor),
                    onChanged: (bool? value) {
                      selectedSort[index]['isSelected'] = value!;
                      customFiltersBloc.add(SelectedFiltersEvent(selectedSortValue: selectedSort));
                    },
                  ),
                  InkWell(
                    onTap: () {
                      selectedSort[index]['isSelected'] = !selectedSort[index]['isSelected']!;
                      customFiltersBloc.add(SelectedFiltersEvent(selectedSortValue: selectedSort));
                    },
                    child: CustomText(
                      text: selectedSort[index]['name'].toString(),
                      size: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class DividerFilters extends StatelessWidget {
  const DividerFilters({super.key});

  @override
  Widget build(BuildContext context) => Container(height: 0.2, width: MediaQuery.of(context).size.width, color: Colors.grey);
}

class SortAndFiltersHeadingWidget extends StatelessWidget {
  const SortAndFiltersHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeAll(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            text: "Sort and Filters",
            size: 19,
            fontWeight: FontWeight.w600,
          ),
          InkWell(
            child: Icon(Icons.close, color: ColorPalette.blackColor),
            onTap: () {
              globalSaveList.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class SortBuilderWidget extends StatelessWidget {
  final String text;
  final String selectedText;
  const SortBuilderWidget({super.key, required this.text, required this.selectedText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: text == selectedText ? Colors.red : ColorPalette.whiteColor,
          height: 50,
          width: 4,
        ),
        Expanded(
          child: Container(
            padding: edgeLRTB(l: 15),
            height: 50,
            color: text == selectedText ? ColorPalette.whiteColor : ColorPalette.backgroundColor,
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: text,
              fontWeight: FontWeight.w600,
              size: 13,
            ),
          ),
        ),
      ],
    );
  }
}
