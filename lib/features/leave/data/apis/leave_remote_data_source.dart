import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';

abstract class LeaveRemoteDataSource {
  Future<void> leaveRequest(LeaveModel leave);
}

class LeaveRemoteDateSourceImpl extends LeaveRemoteDataSource {
  @override
  Future<void> leaveRequest(LeaveModel leave) async {
    final response = await client.from('leave_requests').insert(leave.toJson());

    if (response.error != null) {
      throw Exception(
        'Failed to submit leave request: ${response.error!.message}',
      );
    }
  }
}
