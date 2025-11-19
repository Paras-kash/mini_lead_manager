import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/lead.dart';
import '../providers/leads_provider.dart';

class LeadFormScreen extends StatefulWidget {
  final Lead? lead; // If null, we are adding a new lead

  const LeadFormScreen({super.key, this.lead});

  @override
  State<LeadFormScreen> createState() => _LeadFormScreenState();
}

class _LeadFormScreenState extends State<LeadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.lead?.name ?? '');
    _contactController = TextEditingController(
      text: widget.lead?.contact ?? '',
    );
    _notesController = TextEditingController(text: widget.lead?.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveLead() {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<LeadsProvider>(context, listen: false);

    if (widget.lead == null) {
      // Create new
      final newLead = Lead(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        contact: _contactController.text.trim(),
        notes: _notesController.text.trim(),
        createdAt: DateTime.now(),
      );
      provider.addLead(newLead);
    } else {
      // Update existing
      provider.updateLead(
        widget.lead!,
        name: _nameController.text.trim(),
        contact: _contactController.text.trim(),
        notes: _notesController.text.trim(),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.lead != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Lead' : 'New Lead')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildLabel('Full Name'),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecor('Ex: John Doe'),
              textCapitalization: TextCapitalization.words,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 20),

            _buildLabel('Contact Info'),
            TextFormField(
              controller: _contactController,
              decoration: _inputDecor('Ex: +1 234 567 890 or john@email.com'),
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Contact is required' : null,
            ),
            const SizedBox(height: 20),

            _buildLabel('Notes (Optional)'),
            TextFormField(
              controller: _notesController,
              decoration: _inputDecor('Any details about the lead...'),
              maxLines: 4,
            ),
            const SizedBox(height: 32),

            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: _saveLead,
                child: Text(isEditing ? 'Update Lead' : 'Save Lead'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputDecor(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.indigo, width: 1.5),
      ),
    );
  }
}
