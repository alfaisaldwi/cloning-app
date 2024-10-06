import 'dart:io';

import 'package:fast8_test/modules/profile/bloc/profile_bloc.dart';
import 'package:fast8_test/modules/profile/bloc/profile_event.dart';
import 'package:fast8_test/modules/profile/bloc/profile_state.dart';
import 'package:fast8_test/modules/profile/page/address.dart';
import 'package:fast8_test/modules/profile/page/biodata.dart';
import 'package:fast8_test/modules/profile/page/company.dart';
import 'package:fast8_test/utils/color.dart';
import 'package:fast8_test/utils/databaseLocal.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'dart:io';

class InformasiPribadiPage extends StatefulWidget {
  @override
  _InformasiPribadiPageState createState() => _InformasiPribadiPageState();
}

class _InformasiPribadiPageState extends State<InformasiPribadiPage> {
  int _currentStep = 0;
  String? name, dateOfBirth, gender, email, phone, education, maritalStatus;
  String? province, regency, district, village, addressDetail;
  Map<String, String> biodataDiri = {};
  Map<String, String> address = {};
  Map<String, String> informasiPerusahaan = {};
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    List<Map<String, dynamic>> biodataList =
        await DatabaseHelper.instance.queryAllBiodataDiri();
    List<Map<String, dynamic>> addressList =
        await DatabaseHelper.instance.queryAllAddress();
    List<Map<String, dynamic>> perusahaanList =
        await DatabaseHelper.instance.queryAllInformasiPerusahaan();

    setState(() {
      if (biodataList.isNotEmpty) {
        biodataDiri = {
          'name': biodataList.last['name'],
          'dateOfBirth': biodataList.last['dateOfBirth'],
          'gender': biodataList.last['gender'],
          'email': biodataList.last['email'],
          'phone': biodataList.last['phone'],
          'education': biodataList.last['education'],
          'maritalStatus': biodataList.last['maritalStatus'],
        };
      }

      if (addressList.isNotEmpty) {
        address = {
          'province': addressList.last['province'],
          'regency': addressList.last['regency'],
          'district': addressList.last['district'],
          'village': addressList.last['village'],
          // 'addressDetail': addressList.last['addressDetail'],
        };
      }

      if (perusahaanList.isNotEmpty) {
        informasiPerusahaan = {
          'company_name': perusahaanList.last['company_name'],
          'company_address': perusahaanList.last['company_address'],
          'jabatan': perusahaanList.last['jabatan'],
          'lama_bekerja': perusahaanList.last['lama_bekerja'],
          'sumber_pendapatan': perusahaanList.last['sumber_pendapatan'],
          'pendapatan_per_tahun': perusahaanList.last['pendapatan_per_tahun'],
          'bank': perusahaanList.last['bank'],
          'bank_branch': perusahaanList.last['bank_branch'],
          'account_number': perusahaanList.last['account_number'],
          'account_owner': perusahaanList.last['account_owner'],
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(FetchProvincesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Informasi Pribadi"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            EasyStepper(
              activeStep: _currentStep,
              showStepBorder: false,
              activeStepTextColor: primaryColor,
              finishedStepTextColor: primaryColor,
              fitWidth: true,
              internalPadding: 0,
              activeStepBackgroundColor: Colors.white,
              finishedStepBackgroundColor: Colors.white,
              showLoadingAnimation: false,
              activeStepBorderType: BorderType.normal,
              lineStyle: LineStyle(
                lineSpace: 0,
                lineLength: 80,
                progressColor: primaryColor,
                lineType: LineType.normal,
                activeLineColor: primaryColor.withOpacity(0.5),
                unreachedLineColor: primaryColor.withOpacity(0.5),
                progress: 0.5,
                defaultLineColor: Colors.white,
                finishedLineColor: primaryColor,
              ),
              onStepReached: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    backgroundColor: _currentStep >= 0
                        ? primaryColor
                        : primaryColor.withOpacity(0.5),
                    radius: 20,
                    child: const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: 'Biodata Diri',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    backgroundColor: _currentStep >= 1
                        ? primaryColor
                        : primaryColor.withOpacity(0.5),
                    radius: 20,
                    child: const Text(
                      '2',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: 'Alamat Pribadi',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    backgroundColor: _currentStep >= 2
                        ? primaryColor
                        : primaryColor.withOpacity(0.5),
                    radius: 20,
                    child: const Text(
                      '3',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: 'Informasi\nPerusahaan',
                )
              ],
            ),
            _buildStepContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return BiodataDiriForm(
          onFormDataChanged: (data) {
            setState(() {
              biodataDiri = data;
            });
          },
          initialData: biodataDiri,
        );
      case 1:
        return AddressForm(
          onFormDataChanged: (data) {
            setState(() {
              address = data;
            });
          },
          initialData: address,
        );
      case 2:
        return InformasiPerusahaanForm(
          biodataDiri: biodataDiri,
          address: address,
          initialData: informasiPerusahaan,
        );
      default:
        return BiodataDiriForm(
          onFormDataChanged: (data) {},
          initialData: {},
        );
    }
  }
}
