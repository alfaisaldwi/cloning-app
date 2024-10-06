import 'package:fast8_test/utils/image_picker.dart';
import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../bloc/profile_event.dart';



class AddressForm extends StatefulWidget {
  final Function(Map<String, String>) onFormDataChanged;
  final Map<String, String> initialData;

  AddressForm({required this.onFormDataChanged, required this.initialData});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedVillage;
  final TextEditingController _addressDetailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(FetchProvincesEvent());
    _loadInitialData();
  }

  void _loadInitialData() {
    selectedProvince = widget.initialData['province'];
    selectedRegency = widget.initialData['regency'];
    selectedDistrict = widget.initialData['district'];
    selectedVillage = widget.initialData['village'];
    _addressDetailController.text = widget.initialData['addressDetail'] ?? '';
  }

  void _notifyDataChanged() {
    widget.onFormDataChanged({
      'province': selectedProvince ?? '',
      'regency': selectedRegency ?? '',
      'district': selectedDistrict ?? '',
      'village': selectedVillage ?? '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileErrorState) {
                return const Center(child: Text('Gagal memuat data wilayah.'));
              } else if (state is ProfileLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImagePickerWidget(),
                    buildVerticalSpacer(12),
                    const Text('NIK'),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    buildVerticalSpacer(12),
                    const Text('Alamat Sesuai KTP'),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    buildVerticalSpacer(12),
                    const Text('Provinsi'),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: selectedProvince,
                      items: state.provinces.map((province) {
                        return DropdownMenuItem<String>(
                          value: province['id'].toString(),
                          child: Text(province['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProvince = value;
                          selectedRegency = null;
                          selectedDistrict = null;
                          selectedVillage = null;
                          BlocProvider.of<ProfileBloc>(context)
                              .add(SelectProvinceEvent(value!));
                          _notifyDataChanged();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Kota/Kabupaten'),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: selectedRegency,
                      items: state.regencies.map((regency) {
                        return DropdownMenuItem<String>(
                          value: regency['id'].toString(),
                          child: Text(regency['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRegency = value;
                          selectedDistrict = null;
                          selectedVillage = null;
                          BlocProvider.of<ProfileBloc>(context)
                              .add(SelectRegencyEvent(value!));
                          _notifyDataChanged();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Kecamatan'),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: selectedDistrict,
                      items: state.districts.map((district) {
                        return DropdownMenuItem<String>(
                          value: district['id'].toString(),
                          child: Text(district['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                          selectedVillage = null;
                          BlocProvider.of<ProfileBloc>(context)
                              .add(SelectDistrictEvent(value!));
                          _notifyDataChanged();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Desa/Kelurahan'),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: selectedVillage,
                      items: state.villages.map((village) {
                        return DropdownMenuItem<String>(
                          value: village['id'].toString(),
                          child: Text(village['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedVillage = value;
                          _notifyDataChanged();
                        });
                      },
                    ),
                    buildVerticalSpacer(12),
                    const Text('Kode POS'),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    buildVerticalSpacer(20)
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
