import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  static Future initialize() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  Future login(String email, String password) async {
    try {
      await client.auth.signInWithPassword(
          email: email,
          password: password
      );
    } on AuthApiException catch (error) {
      if (kDebugMode) {
        print(">>>>>> LOGIN ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if (kDebugMode) {
        print(">>>>>> ERRORE GENERICO");
      }
      throw "Generic error";
    }
  }

  Future logout() async {
    try {
      await client.auth.signOut();
    } on AuthApiException catch (error) {
      if (kDebugMode) {
        print(">>>>>> LOGIN ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if (kDebugMode) {
        print(">>>>>> ERRORE GENERICO");
      }
      throw "Generic error";
    }
  }

  Future signup(String email, String password) async {
    try {
      await client.auth.signUp(email: email, password: password);
    } on AuthApiException catch (error) {
      if(kDebugMode) {
        print(">>>>>> SIGNUP ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if(kDebugMode) {
        print(">>>>>> GENERIC SIGNUP ERROR");
      }
      throw ">>>>>> GENERIC SIGNUP ERROR";
    }
  }

}