import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:attendance_appp/features/leave/data/repos/leave_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  LeaveCubit(this._leaveRepo) : super(LeaveInitial());

  final LeaveRepo _leaveRepo;
  Future<void> leaveRequest(LeaveModel leave) async {
    emit(LeaveLoading());

    final result = await _leaveRepo.leaveRequest(leave);

    return result.fold(
      (failure) {
        emit(LeaveFailure(failure.message));
      },
      (_) {
        emit(LeaveSuccess(leave));
      },
    );
  }
}
