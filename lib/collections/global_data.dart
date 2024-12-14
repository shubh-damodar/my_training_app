List<Map<String, Object>> globalSaveList = [];


// final globalFiltersBlocKey = GlobalKey<BlocProviderState<GlobalFiltersBloc>>();

// 1. Define your events
// abstract class GlobalFiltersEvent {}

// class UpdateGlobalFiltersEvent extends GlobalFiltersEvent {
//   final List<Map<String, dynamic>> filters;
//   UpdateGlobalFiltersEvent(this.filters);
// }

// // 2. Define your state
// class GlobalFiltersState {
//   final List<Map<String, dynamic>> filters;
//   GlobalFiltersState({required this.filters});
// }

// // 3. Define your Bloc
// class GlobalFiltersBloc extends Bloc<GlobalFiltersEvent, GlobalFiltersState> {
//   GlobalFiltersBloc() : super(GlobalFiltersState(filters: [])) {
//     // Initial state with empty list
//     on<UpdateGlobalFiltersEvent>((event, emit) {
//       emit(GlobalFiltersState(filters: event.filters));
//     });
//   }
// }
