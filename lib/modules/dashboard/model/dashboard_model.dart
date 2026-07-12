class DashboardModel {
  final int totalAssets;
  final int assignedAssets;
  final int availableAssets;
  final int repairAssets;
  final int scrapAssets;
  final int lostAssets;

  const DashboardModel({
    required this.totalAssets,
    required this.assignedAssets,
    required this.availableAssets,
    required this.repairAssets,
    required this.scrapAssets,
    required this.lostAssets,
  });

  factory DashboardModel.empty() {
    return const DashboardModel(
      totalAssets: 0,
      assignedAssets: 0,
      availableAssets: 0,
      repairAssets: 0,
      scrapAssets: 0,
      lostAssets: 0,
    );
  }

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalAssets: json['total_assets'] ?? 0,
      assignedAssets: json['assigned_assets'] ?? 0,
      availableAssets: json['available_assets'] ?? 0,
      repairAssets: json['repair_assets'] ?? 0,
      scrapAssets: json['scrap_assets'] ?? 0,
      lostAssets: json['lost_assets'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_assets": totalAssets,
      "assigned_assets": assignedAssets,
      "available_assets": availableAssets,
      "repair_assets": repairAssets,
      "scrap_assets": scrapAssets,
      "lost_assets": lostAssets,
    };
  }
}