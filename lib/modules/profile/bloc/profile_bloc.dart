import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<FetchProvincesEvent>((event, emit) async {
      emit(ProfileLoadingState());

      try {
        final response = await http.get(Uri.parse(
            'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json'));

        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> provinces =
              List<Map<String, dynamic>>.from(json.decode(response.body));

          emit(ProfileLoadedState(
            provinces: provinces,
            regencies: [],
            districts: [],
            villages: [],
          ));
        } else {
          emit(ProfileErrorState('Failed to load provinces'));
        }
      } catch (e) {
        emit(ProfileErrorState('Failed to load provinces'));
      }
    });

    on<SelectProvinceEvent>((event, emit) async {
      final currentState = state;
      if (currentState is ProfileLoadedState) {
        emit(ProfileLoadingState());
        try {
          final response = await http.get(Uri.parse(
              'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/${event.provinceId}.json'));
          if (response.statusCode == 200) {
            final List<Map<String, dynamic>> regencies =
                List<Map<String, dynamic>>.from(json.decode(response.body));

            emit(ProfileLoadedState(
              provinces: currentState.provinces,
              regencies: regencies,
              districts: [],
              villages: [],
              selectedProvince: event.provinceId,
            ));
          } else {
            emit(ProfileErrorState('Failed to load regencies'));
          }
        } catch (e) {
          emit(ProfileErrorState('Failed to load regencies'));
        }
      }
    });

    on<SelectRegencyEvent>((event, emit) async {
      final currentState = state;
      if (currentState is ProfileLoadedState) {
        emit(ProfileLoadingState());
        try {
          final response = await http.get(Uri.parse(
              'https://emsifa.github.io/api-wilayah-indonesia/api/districts/${event.regencyId}.json'));
          if (response.statusCode == 200) {
            final List<Map<String, dynamic>> districts =
                List<Map<String, dynamic>>.from(json.decode(response.body));

            emit(ProfileLoadedState(
              provinces: currentState.provinces,
              regencies: currentState.regencies,
              districts: districts,
              villages: [],
              selectedProvince: currentState.selectedProvince,
              selectedRegency: event.regencyId,
            ));
          } else {
            emit(ProfileErrorState('Failed to load districts'));
          }
        } catch (e) {
          emit(ProfileErrorState('Failed to load districts'));
        }
      }
    });

    on<SelectDistrictEvent>((event, emit) async {
      final currentState = state;
      if (currentState is ProfileLoadedState) {
        emit(ProfileLoadingState());
        try {
          final response = await http.get(Uri.parse(
              'https://emsifa.github.io/api-wilayah-indonesia/api/villages/${event.districtId}.json'));
          if (response.statusCode == 200) {
            final List<Map<String, dynamic>> villages =
                List<Map<String, dynamic>>.from(json.decode(response.body));

            emit(ProfileLoadedState(
              provinces: currentState.provinces,
              regencies: currentState.regencies,
              districts: currentState.districts,
              villages: villages,
              selectedProvince: currentState.selectedProvince,
              selectedRegency: currentState.selectedRegency,
              selectedDistrict: event.districtId,
            ));
          } else {
            emit(ProfileErrorState('Failed to load villages'));
          }
        } catch (e) {
          emit(ProfileErrorState('Failed to load villages'));
        }
      }
    });
  }
  
}
