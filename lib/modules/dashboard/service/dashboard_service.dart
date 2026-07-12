import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/dashboard_model.dart';

class DashboardService {
  DashboardService();

  final SupabaseClient _client = Supabase.instance.client;

  Future<DashboardModel> getDashboard() async {
    try {
      /// -----------------------------
      /// Assets
      /// -----------------------------

      final totalAssets =
      await _client.from('assets').select('id');

      final availableAssets = await _client
          .from('assets')
          .select('id')
          .eq('status', 'available');

      final allocatedAssets = await _client
          .from('assets')
          .select('id')
          .eq('status', 'allocated');

      final maintenanceAssets = await _client
          .from('assets')
          .select('id')
          .eq('status', 'under_maintenance');

      /// -----------------------------
      /// Employees
      /// -----------------------------

      final employees =
      await _client.from('employees').select('id');

      /// -----------------------------
      /// Departments
      /// -----------------------------

      final departments =
      await _client.from('departments').select('id');

      /// -----------------------------
      /// Pending Maintenance
      /// -----------------------------

      final pendingMaintenance = await _client
          .from('maintenance_requests')
          .select('id')
          .eq('status', 'pending');

      /// -----------------------------
      /// Upcoming Bookings
      /// -----------------------------

      final bookings = await _client
          .from('bookings')
          .select('id')
          .eq('status', 'upcoming');

      return DashboardModel(
        totalAssets: totalAssets.length,
        availableAssets: availableAssets.length,
        allocatedAssets: allocatedAssets.length,
        maintenanceAssets: maintenanceAssets.length,
        employees: employees.length,
        departments: departments.length,
        pendingMaintenance: pendingMaintenance.length,
        upcomingBookings: bookings.length,
        unreadNotifications: 0,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// ==========================
  /// CATEGORY CHART
  /// ==========================

  Future<List<Map<String, dynamic>>> getCategoryChart() async {
    final data = await _client
        .from('asset_categories')
        .select('id,name');

    List<Map<String, dynamic>> result = [];

    for (final category in data) {
      final assets = await _client
          .from('assets')
          .select('id')
          .eq('category_id', category['id']);

      result.add({
        "name": category['name'],
        "count": assets.length,
      });
    }

    return result;
  }

  /// ==========================
  /// STATUS CHART
  /// ==========================

  Future<List<Map<String, dynamic>>> getStatusChart() async {
    const statusList = [
      "available",
      "allocated",
      "under_maintenance",
      "lost",
      "disposed",
    ];

    List<Map<String, dynamic>> result = [];

    for (final status in statusList) {
      final rows = await _client
          .from('assets')
          .select('id')
          .eq('status', status);

      result.add({
        "status": status,
        "count": rows.length,
      });
    }

    return result;
  }

  /// ==========================
  /// RECENT ACTIVITY
  /// ==========================

  Future<List<Map<String, dynamic>>> getRecentActivities() async {
    final data = await _client
        .from('allocations')
        .select("""
          allocated_on,
          status,
          assets(name),
          employees(name)
        """)
        .order('allocated_on', ascending: false)
        .limit(10);

    return List<Map<String, dynamic>>.from(data);
  }
}