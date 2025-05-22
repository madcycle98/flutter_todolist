import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final _usernameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                          child: ElevatedButton(
                            onPressed: (){
                              print(_passwordTEC);
                              print(_usernameTEC);
                            },
                            child:
                              Text('Register')),
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