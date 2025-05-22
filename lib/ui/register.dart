import 'package:flutter/material.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  bool isLoading = false;

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
                            hintText: 'Enter your username'
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value!.length < 8){
                              return 'Your password must be at least 8 characters long.';
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
                          decoration: InputDecoration(
                              hintText: 'Confirm your username'
                          ),
                        ),
                        Text(
                            style: TextTheme.of(context).bodyMedium,
                            'Password'
                        ),
                        TextFormField(
                          controller: _passwordTEC,
                          decoration: InputDecoration(
                              hintText: 'Enter your password'
                          ),
                        ),
                        Text(
                            style: TextTheme.of(context).bodyMedium,
                            'Confirm your password'
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Confirm your password'
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child:
                          isLoading == true ?
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
                          : ElevatedButton(
                              onPressed: () async {
                                if(_registerFormKey.currentState!.validate()){
                                  setState(() {
                                    isLoading = true;
                                  });
                                } try {
                                  await _supabaseService.signup(_usernameTEC.text, _passwordTEC.text);
                                } catch (error) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message:
                                      error.toString(),
                                    ),
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child:
                                Text('Register'))
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

// Navigare nella schermata di registrazione utente

/* setState(() {
                          _isLoading = true;
                        });
                        // Implementare chiamata supabase per registrare l'utente
                        AuthResponse response = await Supabase.instance.client.auth.signUp(
                            email: _emailTEC.text,
                            password: _passwordTEC.text
                        );
                        if (response.session != null) {
                          print(">>>>>> SIGN IN OK");
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          print(">>>>>> SIGN IN ERROR");
                        } */