import 'package:supabase_flutter/supabase_flutter.dart';

var client = Supabase.instance.client;
var userId = client.auth.currentUser!.id;
