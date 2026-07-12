import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/dashboard_model.dart';

class DashboardService {
  DashboardService();

<<<<<<< HEAD
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
=======
  Future<int> _count(String table, {String? column, dynamic value}) async {
    try {
      final query = _supabase.from(table).select('*').count();
      if (column != null && value != null) {
        final filtered = _supabase.from(table).select('*').eq(column, value).count();
        return (await filtered).count;
      }
      return (await query).count;
    } catch (e) {
      debugPrint('Error counting $table: $e');
      return 0;
>>>>>>> ab2dd2e (clean repo)
    }
  }

  /// ==========================
  /// CATEGORY CHART
  /// ==========================

<<<<<<< HEAD
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
=======
    // Asset Status List
    final scrapAssets = await _count('assets', column: 'status', value: 'disposed');
    final lostAssets = await _count('assets', column: 'status', value: 'lost');

    List<AssetStatusData> assetStatusList = [
      AssetStatusData('Assigned', allocatedAssets.toDouble()),
      AssetStatusData('Available', availableAssets.toDouble()),
      AssetStatusData('Maintenance', maintenanceAssets.toDouble()),
      AssetStatusData('Disposed', scrapAssets.toDouble()),
      AssetStatusData('Lost', lostAssets.toDouble()),
    ];

    // Category Data
    List<CategoryData> categoryDataList = [];
    try {
      final categoriesRes = await _supabase.from('assets').select('category:asset_categories(name)');
      Map<String, int> catCounts = {};
      for (var item in categoriesRes) {
        final catObj = item['category'];
        final cat = (catObj != null && catObj is Map && catObj.containsKey('name')) ? catObj['name'] : 'Others';
        catCounts[cat] = (catCounts[cat] ?? 0) + 1;
      }
      catCounts.forEach((key, value) {
        categoryDataList.add(CategoryData(key, value.toDouble()));
      });
      if (categoryDataList.isEmpty) {
        categoryDataList = [CategoryData("Laptop", 0), CategoryData("Desktop", 0)];
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      categoryDataList = [CategoryData("Laptop", 10), CategoryData("Desktop", 5)]; // Fallback
    }

    // Low Stock - inventory table missing from schema, skipping
    List<LowStockItem> lowStockItems = [];

    // Warranty Items - warranty_expiry_date missing from schema, skipping
    List<WarrantyItem> warrantyItems = [];

    // Recent Activities - mapped from notifications since activities is gone
    List<ActivityItem> recentActivities = [];
    try {
      final activityRes = await _supabase.from('notifications').select('*').order('created_at', ascending: false).limit(5);
      for (var item in activityRes) {
        recentActivities.add(ActivityItem(
          item['message'] ?? 'Action performed',
          'Recent',
          item['type'] ?? 'info'
        ));
      }
    } catch (e) {
      debugPrint('Error fetching activities: $e');
    }

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
      assetStatusList: assetStatusList,
      categoryDataList: categoryDataList,
      lowStockItems: lowStockItems,
      warrantyItems: warrantyItems,
      recentActivities: recentActivities,
    );
>>>>>>> ab2dd2e (clean repo)
  }

  // --- Quick Actions Methods ---

  Future<List<Map<String, dynamic>>> fetchAssetCategories() async {
    try {
      final res = await _supabase.from('asset_categories').select('id, name');
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      debugPrint('Error fetching asset categories: $e');
      return [];
    }
  }

  Future<String?> addAsset({required String name, required String categoryId, required String status}) async {
    try {
      await _supabase.from('assets').insert({
        'name': name,
        'category_id': categoryId,
        'status': status,
      });
      return null;
    } catch (e) {
      debugPrint('Error adding asset: $e');
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> fetchAvailableAssets() async {
    try {
      final res = await _supabase.from('assets').select('id, name, category:asset_categories(name)').eq('status', 'available');
      return List<Map<String, dynamic>>.from(res.map((item) {
        final catObj = item['category'];
        return {
          'id': item['id'],
          'name': item['name'],
          'category': (catObj != null && catObj is Map && catObj.containsKey('name')) ? catObj['name'] : 'Unknown',
        };
      }));
    } catch (e) {
      debugPrint('Error fetching available assets: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllocatedAssets() async {
    try {
      final res = await _supabase.from('assets').select('id, name, category:asset_categories(name)').eq('status', 'allocated');
      return List<Map<String, dynamic>>.from(res.map((item) {
        final catObj = item['category'];
        return {
          'id': item['id'],
          'name': item['name'],
          'category': (catObj != null && catObj is Map && catObj.containsKey('name')) ? catObj['name'] : 'Unknown',
        };
      }));
    } catch (e) {
      debugPrint('Error fetching allocated assets: $e');
      return [];
    }
  }
  
  Future<List<Map<String, dynamic>>> fetchAllAssets() async {
    try {
      final res = await _supabase.from('assets').select('id, name, category:asset_categories(name)');
      return List<Map<String, dynamic>>.from(res.map((item) {
        final catObj = item['category'];
        return {
          'id': item['id'],
          'name': item['name'],
          'category': (catObj != null && catObj is Map && catObj.containsKey('name')) ? catObj['name'] : 'Unknown',
        };
      }));
    } catch (e) {
      debugPrint('Error fetching all assets: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    try {
      final res = await _supabase.from('employees').select('id, name');
      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      debugPrint('Error fetching employees: $e');
      return [];
    }
  }

  Future<String?> assignAsset({required String assetId, required String assetName}) async { 
    try {
      await _supabase.from('assets').update({'status': 'allocated'}).eq('id', assetId);
      await _supabase.from('allocations').insert({
        'asset_id': assetId,
        'status': 'active',
        // Note: employee_id is omitted since it is not selected in the UI yet
      });
      return null;
    } catch (e) {
      debugPrint('Error assigning asset: $e');
      return e.toString();
    }
  }

  Future<String?> returnAsset({required String assetId, required String assetName}) async {
    try {
      await _supabase.from('assets').update({'status': 'available'}).eq('id', assetId);
      await _supabase.from('allocations')
          .update({'returned_on': DateTime.now().toIso8601String(), 'status': 'returned'})
          .eq('asset_id', assetId)
          .isFilter('returned_on', null);
      return null;
    } catch (e) {
      debugPrint('Error returning asset: $e');
      return e.toString();
    }
  }

  Future<String?> repairAsset({required String assetId, required String assetName, required String issue}) async {
    try {
      await _supabase.from('assets').update({'status': 'under_maintenance'}).eq('id', assetId);
      await _supabase.from('maintenance_requests').insert({
        'asset_id': assetId,
        'issue': issue,
        'status': 'pending',
      });
      return null;
    } catch (e) {
      debugPrint('Error logging repair for asset: $e');
      return e.toString();
    }
  }
  
  Future<String?> deleteAsset({required String assetId, required String assetName}) async {
    try {
      await _supabase.from('assets').delete().eq('id', assetId);
      return null;
    } catch (e) {
      debugPrint('Error deleting asset: $e');
      return e.toString();
    }
  }

  Future<String?> addEmployee({required String name, required String email}) async {
    try {
      await _supabase.from('employees').insert({
        'name': name,
        'email': email,
      });
      return null;
    } catch (e) {
      debugPrint('Error adding employee: $e');
      return e.toString();
    }
  }
}