import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/collections/const_data.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:my_training_app/features/dashboard/presentation/filters/bloc/custom_filters_bloc.dart';
import 'package:my_training_app/utils/custom_padding.dart';
import 'package:my_training_app/utils/custom_text.dart';

class FilterWIdget extends StatefulWidget {
  const FilterWIdget({super.key});

  @override
  State<FilterWIdget> createState() => _FilterWIdgetState();
}

class _FilterWIdgetState extends State<FilterWIdget> {
  DashboardBloc dashboardBloc = DashboardBloc();
  CustomFiltersBloc customFiltersBloc = CustomFiltersBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: ColorPalette.whiteColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
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
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 0.2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<DashboardBloc, DashboardState>(
                  bloc: dashboardBloc,
                  listener: (BuildContext context, DashboardState state) {
                    if (state is FilteredFromSortState) {
                      customFiltersBloc.add(SelectedFiltersEvent(selectedSortValue: state.selectedSortList));
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
                            onTap: () {
                              dashboardBloc.add(FilterWithQueryEvent(query: sortingLists[index]));
                            },
                            child: SortBuilderWidget(
                              selectedText: selectedSortString,
                              text: sortingLists[index],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                BlocConsumer<CustomFiltersBloc, CustomFiltersState>(
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
                          return CheckboxListTile(
                            value: selectedSort[index]['isSelected'] as bool,
                            contentPadding: edgeAll(0),
                            checkColor: Colors.red,
                            hoverColor: Colors.white,
                            activeColor: ColorPalette.backgroundColor,
                            overlayColor: WidgetStatePropertyAll(ColorPalette.backgroundColor),
                            onChanged: (bool? value) {
                              selectedSort[index]['isSelected'] = value!;
                              customFiltersBloc.add(SelectedFiltersEvent(selectedSortValue: selectedSort));
                            },
                            title: CustomText(
                              text: selectedSort[index]['name'].toString(),
                              size: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
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
