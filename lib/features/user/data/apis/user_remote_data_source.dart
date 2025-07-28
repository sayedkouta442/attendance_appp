import 'package:attendance_appp/core/utils/constants.dart';
import 'package:attendance_appp/features/leave/data/models/leave_model.dart';
import 'package:attendance_appp/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> fetchUserData();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> fetchUserData() async {
    // var userId = Supabase.instance.client.auth.currentUser?.id;

    final debugEmployees = await client.from('employees').select('id');
    print('Existing employee IDs: $debugEmployees');

    final reponse = await client
        .from('employees')
        .select('''
          id,
          full_name,
          email,
          phone_number,
          join_date,
          job_title,
          image_url,
          departments(name),
          branches(name)
        ''')
        .eq('id', userId)
        .maybeSingle();

    if (reponse == null) {
      throw Exception('Failed to fetch user data:');
    }

    return UserModel.fromJson(reponse);
  }
}
