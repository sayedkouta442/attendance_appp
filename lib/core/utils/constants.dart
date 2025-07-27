import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

var client = Supabase.instance.client;
var userId = client.auth.currentUser!.id;

const Color primaryColor = Color(0xff3662e1);
