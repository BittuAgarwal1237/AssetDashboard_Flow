import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/dashboard_model.dart';

class DashboardService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<int> _count(String table, {String? column, dynamic value}) async {
    final query = _supabase.from(table).select('*').count();
    if (column != null && value != null) {
      final filtered = _supabase.from(table).select('*').eq(column, value).count();
      return (await filtered).count ?? 0;
    }
    return (await query).count ?? 0;
  }

  Future<DashboardModel> fetchDashboard() async {
    final totalAssets = await _count('assets');
    final availableAssets = await _count('assets', column: 'status', value: 'available');
    final allocatedAssets = await _count('assets', column: 'status', value: 'allocated');
    final maintenanceAssets = await _count('assets', column: 'status', value: 'under_maintenance');
    final departments = await _count('departments');
    final employees = await _count('employees');
    final pendingMaintenance = await _count('maintenance_requests', column: 'status', value: 'pending');
    final upcomingBookings = await _count('bookings', column: 'status', value: 'upcoming');
    final unreadNotifications = await _count('notifications', column: 'read', value: false);

    return DashboardModel(
      totalAssets: totalAssets,
      availableAssets: availableAssets,
      allocatedAssets: allocatedAssets,
      maintenanceAssets: maintenanceAssets,
      departments: departments,
      employees: employees,
      pendingMaintenance: pendingMaintenance,
      upcomingBookings: upcomingBookings,
      unreadNotifications: unreadNotifications,
    );
  }
}