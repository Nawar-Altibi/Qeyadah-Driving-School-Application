import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';

/// Client-side display order over already-loaded booking pages.
/// The backend has no sort query param, so this only reshuffles the current list.
enum StudentBookingsSortOrder { newestFirst, oldestFirst }

/// `null` [selectedStatus] means "All statuses".
class StudentBookingsListState {
  const StudentBookingsListState({
    this.apiState = const ApiState<StudentBookingsPageEntity>.initial(),
    this.selectedStatus,
    this.searchQuery = '',
    this.sortOrder = StudentBookingsSortOrder.newestFirst,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  final ApiState<StudentBookingsPageEntity> apiState;
  final StudentBookingStatus? selectedStatus;
  final String searchQuery;
  final StudentBookingsSortOrder sortOrder;
  final bool isLoadingMore;
  final bool isRefreshing;

  StudentBookingsListState copyWith({
    ApiState<StudentBookingsPageEntity>? apiState,
    String? searchQuery,
    StudentBookingsSortOrder? sortOrder,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return StudentBookingsListState(
      apiState: apiState ?? this.apiState,
      selectedStatus: selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOrder: sortOrder ?? this.sortOrder,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  /// Separate from [copyWith] because `selectedStatus` is itself nullable
  /// (`null` = "All"), so a sentinel-free copyWith cannot clear it.
  StudentBookingsListState withStatus(StudentBookingStatus? status) {
    return StudentBookingsListState(
      apiState: apiState,
      selectedStatus: status,
      searchQuery: searchQuery,
      sortOrder: sortOrder,
      isLoadingMore: isLoadingMore,
      isRefreshing: isRefreshing,
    );
  }
}
