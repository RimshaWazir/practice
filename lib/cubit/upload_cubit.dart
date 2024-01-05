import 'dart:developer';

import 'package:app/Data/Repository/profile_repo.dart';
import 'package:app/cubit/upload_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyCubit extends Cubit<DummyState> {
  DummyCubit() : super(DummyInitial());

  addData({Map<String, dynamic>? body, List<String?>? images}) async {
    await Future.delayed(Duration.zero);

    emit(DummyLoading());
    try {
      await DummyRepo.dummyData(body: body, images: images).then((value) {
        if (value['Success']) {
          emit(DummyLoaded());
        }
      }).catchError((e) {
        emit(DummyError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(DummyError(error: "here is error${e.toString()}"));
      rethrow;
    }
  }
}
