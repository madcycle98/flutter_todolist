import 'package:flutter/material.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/ui/tasks_list.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utils/custom_regexp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final SupabaseService _supabaseService = SupabaseService();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _usernameCheckTEC = TextEditingController();
  final TextEditingController _passwordCheckTEC = TextEditingController();
  bool isLoading = false;
  bool _obscurePsw = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,64,24,64),
          child: Center(
            child: Column(
              spacing: 24,
              children: [
                Text(
                  'Create Account',
                  style: TextTheme.of(context).headlineMedium,
                ),
                Text(
                  'Create your account and feel the benefits',
                  style: TextTheme.of(context).bodySmall,
                ),
                Form(
                  key: _registerFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: TextTheme.of(context).bodyMedium,
                          'Username'
                        ),
                        TextFormField(
                          controller: _usernameTEC,
                          decoration: InputDecoration(
                            hintText: 'Enter your email'
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.length < 6){
                              return 'Your email must be at least 6 characters long.';
                            }else if(!CustomRegExp().checkValidEmail.hasMatch(value)){
                              return 'Your email must be a valid email.';
                            }else{
                              return null;
                            }
                          },
                        ),
                        Text(
                          style: TextTheme.of(context).bodyMedium,
                          'Confirm your username'
                        ),
                        TextFormField(
                          controller: _usernameCheckTEC,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Confirm your username'
                          ),
                          validator: (value){
                            if(value != _usernameTEC.text){
                              return 'Usernames don\'t match';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Text(
                            style: TextTheme.of(context).bodyMedium,
                            'Password'
                        ),
                        TextFormField(
                          controller: _passwordTEC,
                          keyboardType: TextInputType.text,
                          obscureText: _obscurePsw,
                          decoration: InputDecoration(
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePsw = !_obscurePsw;
                                  });
                                },
                                icon: Icon(_obscurePsw ? Icons.visibility : Icons.visibility_off,))
                          ),
                          validator: (value) {
                            if(!CustomRegExp().checkValidPassword.hasMatch(value!)) {
                              return 'Password isn\'t valid.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        // Sistemare tutti i validator!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        Text(
                            style: TextTheme.of(context).bodyMedium,
                            'Confirm your password'
                        ),
                        TextFormField(
                          controller: _passwordCheckTEC,
                          keyboardType: TextInputType.text,
                          obscureText: _obscurePsw,
                          decoration: InputDecoration(
                              hintText: 'Confirm your password',
                              suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                _obscurePsw = !_obscurePsw;
                                });
                              },
                              icon: Icon(_obscurePsw ? Icons.visibility : Icons.visibility_off,))
                          ),
                          validator: (value) {
                            if(value != _passwordTEC.text) {
                              return "Password don't match";
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child:
                          isLoading == false ?
                          ElevatedButton(
                              onPressed: () async {
                                if(_registerFormKey.currentState!.validate()){
                                  setState(() {
                                    isLoading = true;
                                  });
                                 try {
                                  await _supabaseService.signup(_usernameTEC.text, _passwordTEC.text);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => TasksList()));
                                } catch (error) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message:
                                      error.toString(),
                                    ),
                                  );
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                 }
                                }
                              },
                              child:
                                Text('Register'))
                          :
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                            child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                            ),
                          )
                          )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

