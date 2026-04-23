import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const url = 'https://mgpnserjtspbrjxhumpc.supabase.co';

  // ⚠️ ONE LINE ONLY (no line breaks)
  static const anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ncG5zZXJqdHNwYnJqeGh1bXBjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY5NTA2NjgsImV4cCI6MjA5MjUyNjY2OH0.lqMuFnat0MtIi0yn9dsn_haC0eDPW7Xnpz6XR9_CBfA';
}

final supabase = Supabase.instance.client;