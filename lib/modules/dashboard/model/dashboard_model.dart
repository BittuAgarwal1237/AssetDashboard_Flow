class DashboardModel {
  final int totalAssets;
  final int availableAssets;
  final int allocatedAssets;
  final int maintenanceAssets;
  final int departments;
  final int employees;
  final int pendingMaintenance;
  final int upcomingBookings;
  final int unreadNotifications;

  const DashboardModel({
    required this.totalAssets,
    required this.availableAssets,
    required this.allocatedAssets,
    required this.maintenanceAssets,
    required this.departments,
    required this.employees,
    required this.pendingMaintenance,
    required this.upcomingBookings,
    required this.unreadNotifications,
  });

  factory DashboardModel.empty() {
    return const DashboardModel(
      totalAssets: 0,
      availableAssets: 0,
      allocatedAssets: 0,
      maintenanceAssets: 0,
      departments: 0,
      employees: 0,
      pendingMaintenance: 0,
      upcomingBookings: 0,
      unreadNotifications: 0,
    );
  }
}