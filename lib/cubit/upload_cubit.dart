import 'dart:developer';

import 'package:app/ApiServices/api_services.dart';
import 'package:app/Data/AppData/data.dart';
import 'package:app/Data/Repository/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/cubit/upload_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateState> {
  ProfileUpdateCubit() : super(ProfileUpdateInitial());

  Future<void> updateProfile(
      Map<String, dynamic> body, String? imagePath) async {
    emit(ProfileUpdateLoading());
    try {
      var response = await ProfileRepository.updateProfile(body, imagePath);
      if (response['Success']) {
        emit(ProfileUpdateSuccess());
      } else {
        emit(ProfileUpdateError(response['error']));
      }
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }
}
