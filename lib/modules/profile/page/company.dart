import 'package:fast8_test/utils/color.dart';
import 'package:fast8_test/utils/databaseLocal.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InformasiPerusahaanForm extends StatefulWidget {
  final Map<String, String> biodataDiri;
  final Map<String, String> address;
  final Map<String, String> initialData;

  InformasiPerusahaanForm(
      {required this.biodataDiri,
      required this.address,
      required this.initialData});

  @override
  _InformasiPerusahaanFormState createState() =>
      _InformasiPerusahaanFormState();
}

class _InformasiPerusahaanFormState extends State<InformasiPerusahaanForm> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountOwnerController = TextEditingController();

  String? selectedJabatan;
  String? selectedLamaBekerja;
  String? selectedSumberPendapatan;
  String? selectedPendapatan;
  String? selectedBank;
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    _companyNameController.text = widget.initialData['company_name'] ?? '';
    _companyAddressController.text =
        widget.initialData['company_address'] ?? '';
    _bankBranchController.text = widget.initialData['bank_branch'] ?? '';
    _accountNumberController.text = widget.initialData['account_number'] ?? '';
    _accountOwnerController.text = widget.initialData['account_owner'] ?? '';
    selectedJabatan = widget.initialData['jabatan'];
    selectedLamaBekerja = widget.initialData['lama_bekerja'];
    selectedSumberPendapatan = widget.initialData['sumber_pendapatan'];
    selectedPendapatan = widget.initialData['pendapatan_per_tahun'];
    selectedBank = widget.initialData['bank'];
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyAddressController.dispose();
    _bankBranchController.dispose();
    _accountNumberController.dispose();
    _accountOwnerController.dispose();
    super.dispose();
  }

  void _saveData() async {
    Map<String, dynamic> biodata = {
      'name': widget.biodataDiri['name'],
      'dateOfBirth': widget.biodataDiri['dateOfBirth'],
      'gender': widget.biodataDiri['gender'],
      'email': widget.biodataDiri['email'],
      'phone': widget.biodataDiri['phone'],
      'education': widget.biodataDiri['education'],
      'maritalStatus': widget.biodataDiri['maritalStatus'],
    };
    int biodataId = await DatabaseHelper.instance.insertBiodataDiri(biodata);

    Map<String, dynamic> address = {
      'province': widget.address['province'],
      'regency': widget.address['regency'],
      'district': widget.address['district'],
      'village': widget.address['village'],
      'addressDetail': widget.address['addressDetail'],
    };
    int addressId = await DatabaseHelper.instance.insertAddress(address);

    Map<String, dynamic> informasiPerusahaan = {
      'company_name': _companyNameController.text,
      'company_address': _companyAddressController.text,
      'bank_branch': _bankBranchController.text,
      'account_number': _accountNumberController.text,
      'account_owner': _accountOwnerController.text,
      'jabatan': selectedJabatan ?? '',
      'lama_bekerja': selectedLamaBekerja ?? '',
      'sumber_pendapatan': selectedSumberPendapatan ?? '',
      'pendapatan_per_tahun': selectedPendapatan ?? '',
      'bank': selectedBank ?? '',
    };
    int perusahaanId = await DatabaseHelper.instance
        .insertInformasiPerusahaan(informasiPerusahaan);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data berhasil disimpan dengan id $perusahaanId')),
    );
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
              const Text('Nama Perusahaan/Usaha'),
              TextField(
                controller: _companyNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Alamat Perusahaan/Usaha'),
              TextField(
                controller: _companyAddressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Jabatan'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedJabatan,
                items: [
                  'Non-staff',
                  'Staff',
                  'Supervisor',
                  'Manajer',
                  'Direktur'
                ].map((String jabatan) {
                  return DropdownMenuItem<String>(
                    value: jabatan,
                    child: Text(jabatan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedJabatan = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Lama Bekerja'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedLamaBekerja,
                items: [
                  '<6 bulan',
                  '6 bulan - 1 tahun',
                  '1-2 tahun',
                  '>2 tahun'
                ].map((String lamaBekerja) {
                  return DropdownMenuItem<String>(
                    value: lamaBekerja,
                    child: Text(lamaBekerja),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLamaBekerja = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Sumber Pendapatan'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedSumberPendapatan,
                items: [
                  'Gaji',
                  'Keuntungan Bisnis',
                  'Bunga Tabungan',
                  'Warisan',
                  'Dana dari Orang Tua atau Anak',
                  'Keuntungan Investasi'
                ].map((String sumberPendapatan) {
                  return DropdownMenuItem<String>(
                    value: sumberPendapatan,
                    child: Text(sumberPendapatan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSumberPendapatan = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Pendapatan Per Tahun'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedPendapatan,
                items: [
                  '<10 juta',
                  '10 juta - 50 juta',
                  '50 juta - 100 juta',
                  '100 juta - 500 juta',
                  '>500 juta'
                ].map((String pendapatan) {
                  return DropdownMenuItem<String>(
                    value: pendapatan,
                    child: Text(pendapatan),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPendapatan = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Pilih Bank'),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedBank,
                items: [
                  'Bank BCA',
                  'Bank Mandiri',
                  'Bank BRI',
                  'Bank BNI',
                  'Bank CIMB Niaga'
                ].map((String bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBank = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Cabang Bank'),
              TextField(
                controller: _bankBranchController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Nomor Rekening'),
              TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Nama Pemilik Rekening'),
              TextField(
                controller: _accountOwnerController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _saveData,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(6)),
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50,
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
