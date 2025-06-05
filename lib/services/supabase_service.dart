import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_model.dart';

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

  Future insertTask(String title, String description) async {
    try {
      await client
        .from('tasks')
        .insert({
          'title': title,
          'description': description,
        });
    } on PostgrestException catch (error) {
      if(kDebugMode) {
        print(">>>>>> INSERT ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if(kDebugMode) {
        print(">>>>>> GENERIC INSERT ERROR");
      }
      throw ">>>>>> GENERIC INSERT ERROR";
    }
  }

  Future updateTask(int id, String title, String description) async {
    try {
      await client
        .from('tasks')
        .update({
          'title': title,
          'description': description,
        }).eq('id', id);
    } on PostgrestException catch (error) {
      if(kDebugMode) {
        print(">>>>>> UPDATE ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if(kDebugMode) {
        print(">>>>>> GENERIC UPDATE ERROR");
      }
      throw ">>>>>> GENERIC UPDATE ERROR";
    }
  }

  Future deleteTask(int id) async {
    try {
      await client
          .from('tasks')
          .delete().eq('id', id);
    } on PostgrestException catch (error) {
      if(kDebugMode) {
        print(">>>>>> DELETE ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if(kDebugMode) {
        print(">>>>>> GENERIC DELETE ERROR");
      }
      throw ">>>>>> GENERIC DELETE ERROR";
    }
  }

  Future<List<SingleTaskModel>> fetchTasks() async {
    try {
      List<SingleTaskModel> results = [];
      final PostgrestList response = await client
          .from('tasks')
          .select('id, title, description').order('created_at', ascending: false);
      for (var singleResult in response) {
        results.add(SingleTaskModel.fromJson(singleResult));
      }
      return results;
    } on PostgrestException catch (error) {
      if(kDebugMode) {
        print(">>>>>> FETCH ERROR: ${error.message}");
      }
      throw error.message;
    } catch (e) {
      if(kDebugMode) {
        print(">>>>>> GENERIC FETCH ERROR");
      }
      throw ">>>>>> GENERIC FETCH ERROR";
    }
  }

}