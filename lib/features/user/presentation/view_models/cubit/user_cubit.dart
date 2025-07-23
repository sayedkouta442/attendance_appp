import 'package:attendance_appp/features/user/data/models/user_model.dart';
import 'package:attendance_appp/features/user/data/repos/user_repo_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepo) : super(UserInitial());

  final UserRepo _userRepo;

  Future<UserModel?> fetchUserData() async {
    emit(UserLoading());
    final result = await _userRepo.fetchUserData();

    return result.fold(
      (failure) {
        emit(UserFailure(failure.message));
        return null;
        // Return an empty UserModel on failure
      },
      (user) {
        emit(UserSuccess(user));
        return user; // Return the user data for further use if needed
      },
    );
  }
}
