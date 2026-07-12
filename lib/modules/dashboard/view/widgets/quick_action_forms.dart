import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/dashboard_service.dart';

class AddAssetForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const AddAssetForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _AddAssetFormState createState() => _AddAssetFormState();
}

class _AddAssetFormState extends State<AddAssetForm> {
  final _nameController = TextEditingController();
  String? _selectedCategoryId;
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;
  bool _isFetchingCategories = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final categories = await widget.service.fetchAssetCategories();
    setState(() {
      _categories = categories;
      _isFetchingCategories = false;
    });
  }

  void _submit() async {
    if (_nameController.text.isEmpty || _selectedCategoryId == null) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    setState(() => _isLoading = true);
    String? error = await widget.service.addAsset(
      name: _nameController.text,
      categoryId: _selectedCategoryId!,
      status: 'available',
    );
    setState(() => _isLoading = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Asset added successfully');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _isFetchingCategories
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add New Asset', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Asset Name', border: OutlineInputBorder())),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                  value: _selectedCategoryId,
                  items: _categories.map((cat) => DropdownMenuItem<String>(
                    value: cat['id'].toString(),
                    child: Text(cat['name']),
                  )).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedCategoryId = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _isLoading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Add Asset')),
              ],
            ),
    );
  }
}

class AssignAssetForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const AssignAssetForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _AssignAssetFormState createState() => _AssignAssetFormState();
}

class _AssignAssetFormState extends State<AssignAssetForm> {
  List<Map<String, dynamic>> _assets = [];
  String? _selectedAssetId;
  String? _selectedAssetName;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final assets = await widget.service.fetchAvailableAssets();
    setState(() {
      _assets = assets;
      _isLoading = false;
    });
  }

  void _submit() async {
    if (_selectedAssetId == null) {
      Get.snackbar('Error', 'Please select an asset');
      return;
    }
    setState(() => _isSubmitting = true);
    String? error = await widget.service.assignAsset(assetId: _selectedAssetId!, assetName: _selectedAssetName!);
    setState(() => _isSubmitting = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Asset assigned successfully');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Assign Asset', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Select Asset', border: OutlineInputBorder()),
            value: _selectedAssetId,
            items: _assets.map((asset) => DropdownMenuItem<String>(
              value: asset['id'].toString(),
              child: Text(asset['name']),
            )).toList(),
            onChanged: (val) {
              setState(() {
                _selectedAssetId = val;
                _selectedAssetName = _assets.firstWhere((a) => a['id'].toString() == val)['name'];
              });
            },
          ),
          const SizedBox(height: 20),
          _isSubmitting ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Assign')),
        ],
      ),
    );
  }
}

class ReturnAssetForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const ReturnAssetForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _ReturnAssetFormState createState() => _ReturnAssetFormState();
}

class _ReturnAssetFormState extends State<ReturnAssetForm> {
  List<Map<String, dynamic>> _assets = [];
  String? _selectedAssetId;
  String? _selectedAssetName;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final assets = await widget.service.fetchAllocatedAssets();
    setState(() {
      _assets = assets;
      _isLoading = false;
    });
  }

  void _submit() async {
    if (_selectedAssetId == null) {
      Get.snackbar('Error', 'Please select an asset');
      return;
    }
    setState(() => _isSubmitting = true);
    String? error = await widget.service.returnAsset(assetId: _selectedAssetId!, assetName: _selectedAssetName!);
    setState(() => _isSubmitting = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Asset returned successfully');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Return Asset', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Select Assigned Asset', border: OutlineInputBorder()),
            value: _selectedAssetId,
            items: _assets.map((asset) => DropdownMenuItem<String>(
              value: asset['id'].toString(),
              child: Text(asset['name']),
            )).toList(),
            onChanged: (val) {
              setState(() {
                _selectedAssetId = val;
                _selectedAssetName = _assets.firstWhere((a) => a['id'].toString() == val)['name'];
              });
            },
          ),
          const SizedBox(height: 20),
          _isSubmitting ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Return')),
        ],
      ),
    );
  }
}

class RepairAssetForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const RepairAssetForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _RepairAssetFormState createState() => _RepairAssetFormState();
}

class _RepairAssetFormState extends State<RepairAssetForm> {
  List<Map<String, dynamic>> _assets = [];
  String? _selectedAssetId;
  String? _selectedAssetName;
  final _issueController = TextEditingController();
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final assetsRes = await widget.service.fetchAvailableAssets();
    final allocRes = await widget.service.fetchAllocatedAssets();
    setState(() {
      _assets = [...assetsRes, ...allocRes];
      _isLoading = false;
    });
  }

  void _submit() async {
    if (_selectedAssetId == null || _issueController.text.isEmpty) {
      Get.snackbar('Error', 'Please select an asset and describe the issue');
      return;
    }
    setState(() => _isSubmitting = true);
    String? error = await widget.service.repairAsset(
      assetId: _selectedAssetId!,
      assetName: _selectedAssetName!,
      issue: _issueController.text
    );
    setState(() => _isSubmitting = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Asset sent to repair');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Log Asset Repair', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Select Asset', border: OutlineInputBorder()),
            value: _selectedAssetId,
            items: _assets.map((asset) => DropdownMenuItem<String>(
              value: asset['id'].toString(),
              child: Text(asset['name']),
            )).toList(),
            onChanged: (val) {
              setState(() {
                _selectedAssetId = val;
                _selectedAssetName = _assets.firstWhere((a) => a['id'].toString() == val)['name'];
              });
            },
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _issueController,
            decoration: const InputDecoration(labelText: 'Issue Description', border: OutlineInputBorder()),
            maxLines: 2,
          ),
          const SizedBox(height: 20),
          _isSubmitting ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Submit')),
        ],
      ),
    );
  }
}

class AddEmployeeForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const AddEmployeeForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _AddEmployeeFormState createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _submit() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    setState(() => _isLoading = true);
    String? error = await widget.service.addEmployee(
      name: _nameController.text,
      email: _emailController.text,
    );
    setState(() => _isLoading = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Employee added successfully');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add New Employee', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
          const SizedBox(height: 20),
          _isLoading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _submit, child: const Text('Add Employee')),
        ],
      ),
    );
  }
}

class DeleteAssetForm extends StatefulWidget {
  final DashboardService service;
  final VoidCallback onSuccess;
  const DeleteAssetForm({Key? key, required this.service, required this.onSuccess}) : super(key: key);

  @override
  _DeleteAssetFormState createState() => _DeleteAssetFormState();
}

class _DeleteAssetFormState extends State<DeleteAssetForm> {
  List<Map<String, dynamic>> _assets = [];
  String? _selectedAssetId;
  String? _selectedAssetName;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final assets = await widget.service.fetchAllAssets();
    setState(() {
      _assets = assets;
      _isLoading = false;
    });
  }

  void _submit() async {
    if (_selectedAssetId == null) {
      Get.snackbar('Error', 'Please select an asset to delete');
      return;
    }
    setState(() => _isSubmitting = true);
    String? error = await widget.service.deleteAsset(assetId: _selectedAssetId!, assetName: _selectedAssetName!);
    setState(() => _isSubmitting = false);
    if (error == null) {
      Get.back();
      widget.onSuccess();
      Get.snackbar('Success', 'Asset deleted successfully');
    } else {
      Get.snackbar('Error', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _isLoading ? const Center(child: CircularProgressIndicator()) : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Delete Asset', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Select Asset', border: OutlineInputBorder()),
            value: _selectedAssetId,
            items: _assets.map((asset) => DropdownMenuItem<String>(
              value: asset['id'].toString(),
              child: Text(asset['name']),
            )).toList(),
            onChanged: (val) {
              setState(() {
                _selectedAssetId = val;
                _selectedAssetName = _assets.firstWhere((a) => a['id'].toString() == val)['name'];
              });
            },
          ),
          const SizedBox(height: 20),
          _isSubmitting ? const CircularProgressIndicator() : ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: _submit, 
            child: const Text('Delete Asset', style: TextStyle(color: Colors.white))
          ),
        ],
      ),
    );
  }
}
