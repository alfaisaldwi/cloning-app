abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final List<Map<String, dynamic>> provinces;
  final List<Map<String, dynamic>> regencies;
  final List<Map<String, dynamic>> districts;
  final List<Map<String, dynamic>> villages;
  final String? selectedProvince;
  final String? selectedRegency;
  final String? selectedDistrict;
  final String? selectedVillage;

  ProfileLoadedState({
    required this.provinces,
    required this.regencies,
    required this.districts,
    required this.villages,
    this.selectedProvince,
    this.selectedRegency,
    this.selectedDistrict,
    this.selectedVillage,
  });
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}

