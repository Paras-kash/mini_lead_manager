import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:mini_lead_manager/models/lead.dart';

class LeadsProvider with ChangeNotifier {
  Box<Lead>? _box;
  List<Lead> _lead = [];
  LeadStatus? _currentFilter;

  bool get isLoading => _box == null;
  List<Lead> get leads {
    if (_currentFilter == null) {
      return List.from(_lead)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    return _lead.where((lead) => lead.status == _currentFilter).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  LeadStatus? get currentFilter => _currentFilter;
  Future<void> init() async {
    _box = await Hive.openBox<Lead>('leadsBox');
    _lead = _box!.values.toList();
    notifyListeners();
  }

  void setFilter(LeadStatus? status) {
    _currentFilter = status;
    notifyListeners();
  }

  Future<void> addLead(Lead lead) async {
    if (_box == null) return;
    await _box!.add(lead);
    _lead.add(lead);
    notifyListeners();
  }

  Future<void> updateLead(
    Lead lead, {
    String? name,
    String? contact,
    LeadStatus? status,
    String? notes,
  }) async {
    if (name != null) lead.name = name;
    if (contact != null) lead.contact = contact;
    if (status != null) lead.status = status;
    if (notes != null) lead.notes = notes;
    await lead.save();
    notifyListeners();
  }

  Future<void> deleteLead(Lead lead) async {
    await lead.delete();
    _lead.remove(lead);
    notifyListeners();
  }
}
