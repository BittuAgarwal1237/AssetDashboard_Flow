class AssetStatusData {
  final String title;
  final double value;

  AssetStatusData(this.title, this.value);
}

class CategoryData {
  final String category;
  final double total;

  CategoryData(this.category, this.total);
}

class LowStockItem {
  final String name;
  final int count;

  LowStockItem(this.name, this.count);
}

class WarrantyItem {
  final String name;
  final int daysLeft;

  WarrantyItem(this.name, this.daysLeft);
}

class ActivityItem {
  final String description;
  final String timeText;
  final String type; // 'added', 'updated', 'deleted' etc. for color mapping

  ActivityItem(this.description, this.timeText, this.type);
}

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
  
  final List<AssetStatusData> assetStatusList;
  final List<CategoryData> categoryDataList;
  final List<LowStockItem> lowStockItems;
  final List<WarrantyItem> warrantyItems;
  final List<ActivityItem> recentActivities;

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
    required this.assetStatusList,
    required this.categoryDataList,
    required this.lowStockItems,
    required this.warrantyItems,
    required this.recentActivities,
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
      assetStatusList: [],
      categoryDataList: [],
      lowStockItems: [],
      warrantyItems: [],
      recentActivities: [],
    );
  }
}