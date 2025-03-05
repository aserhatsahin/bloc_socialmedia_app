import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:user_repository/src/user_repo.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc
    extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final UserRepository _userRepository;
  UpdateUserInfoBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(UpdateUserInfoInitial()) {
    on<UploadPicture>((event, emit) async {
      emit(UploadictureLoading());
      try {
        String userImage = await _userRepository.uploadPicture(
          event.file,
          event.userId,
        );
        emit(UploadPictureSuccess(userImage));
      } catch (e) {
        emit(UploadPictureFailure());
      }
    });
  }
}
