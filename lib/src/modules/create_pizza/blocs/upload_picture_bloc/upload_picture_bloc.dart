import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  PizzaRepo pizzaRepo;

  UploadPictureBloc(this.pizzaRepo) : super(UploadPictureLoading()) {
    on<UploadPicture>((event, emit) async {
      try{
        String url = await pizzaRepo.sendImage(event.file, event.name);
      }catch(e){
        emit(UploadPictureFailure());
      }

    });
  }
}
