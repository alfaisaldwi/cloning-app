abstract class ProfileEvent {}

class FetchProvincesEvent extends ProfileEvent {}

class SelectProvinceEvent extends ProfileEvent {
  final String provinceId;
  SelectProvinceEvent(this.provinceId);
}

class FetchRegenciesEvent extends ProfileEvent {
  final String provinceId;
  FetchRegenciesEvent(this.provinceId);
}

class SelectRegencyEvent extends ProfileEvent {
  final String regencyId;
  SelectRegencyEvent(this.regencyId);
}

class FetchDistrictsEvent extends ProfileEvent {
  final String regencyId;
  FetchDistrictsEvent(this.regencyId);
}

class SelectDistrictEvent extends ProfileEvent {
  final String districtId;
  SelectDistrictEvent(this.districtId);
}

class FetchVillagesEvent extends ProfileEvent {
  final String districtId;
  FetchVillagesEvent(this.districtId);
}


