import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../bloc/profile_event.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BiodataDiriForm extends StatefulWidget {
  final Function(Map<String, String>) onFormDataChanged;
  final Map<String, String> initialData;

  BiodataDiriForm({required this.onFormDataChanged, required this.initialData});

  @override
  _BiodataDiriFormState createState() => _BiodataDiriFormState();
}

class _BiodataDiriFormState extends State<BiodataDiriForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? selectedGender;
  String? selectedEducation;
  String? selectedMaritalStatus;

  @override
  void initState() {
    super.initState();
    _emailController.text = "user@example.com";
    _loadInitialData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
        _notifyDataChanged();
      });
    }
  }

  void _notifyDataChanged() {
    widget.onFormDataChanged({
      'name': _nameController.text,
      'dateOfBirth': _dateController.text,
      'gender': selectedGender ?? '',
      'email': _emailController.text,
      'phone': _phoneController.text,
      'education': selectedEducation ?? '',
      'maritalStatus': selectedMaritalStatus ?? '',
    });
  }

  void _loadInitialData() {
    _nameController.text = widget.initialData['name'] ?? '';
    _dateController.text = widget.initialData['dateOfBirth'] ?? '';
    _emailController.text = widget.initialData['email'] ?? 'user@example.com';
    _phoneController.text = widget.initialData['phone'] ?? '';
    selectedGender = widget.initialData['gender'];
    selectedEducation = widget.initialData['education'];
    selectedMaritalStatus = widget.initialData['maritalStatus'];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Lengkap'),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _notifyDataChanged(),
              ),
              const SizedBox(height: 20),
              const Text('Tanggal Lahir'),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate(context);
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                readOnly: true,
              ),
              const SizedBox(height: 20),
              const Text('Jenis Kelamin'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedGender,
                items: ['Laki-laki', 'Perempuan'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                    _notifyDataChanged();
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Alamat Email'),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                enabled: false,
              ),
              const SizedBox(height: 20),
              const Text('No HP'),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _notifyDataChanged(),
              ),
              const SizedBox(height: 20),
              const Text('Pendidikan'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedEducation,
                items: ['SD', 'SMP', 'SMA', 'D1', 'D2', 'D3', 'S1', 'S2', 'S3']
                    .map((String education) {
                  return DropdownMenuItem<String>(
                    value: education,
                    child: Text(education),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEducation = value;
                    _notifyDataChanged();
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Status Pernikahan'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedMaritalStatus,
                items: ['Belum Kawin', 'Kawin', 'Janda', 'Duda']
                    .map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMaritalStatus = value;
                    _notifyDataChanged();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
