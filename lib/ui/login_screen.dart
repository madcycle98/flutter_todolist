import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/themes/todo_theme.dart';
import 'package:todo_list/ui/register.dart';
import 'package:todo_list/ui/tasks_list.dart';
import 'package:todo_list/utils/custom_regexp.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;

  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _emailTEC.text = "andrea.zaltron@proteko.it";
    _passwordTEC.text = "Pollo1";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 64, 24, 64),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                spacing: 8,
                children: [
                  Text(
                    'Welcome!',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  Text(
                    'Your work faster and structured with Todyapp',
                    style: TextTheme.of(context).bodySmall,
                  ),
                  SizedBox(
                    height: 64,
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Email Address',
                      style: TextTheme.of(context).bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: _emailTEC,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!CustomRegExp().checkValidEmail.hasMatch(value!)) {
                          return "Inserisci una mail valida";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Text(
                      'Password',
                      style: TextTheme.of(context).bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: _passwordTEC,
                      decoration: InputDecoration(
                          hintText: "Password"
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value == '') {
                          return "Inserisci una password valida";
                        } else {
                          return null;
                        }
                      },
                    ),
                    _isLoading
                        ? Padding(
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
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                // Implementare chiamata supabase per autenticare l'utente
                                try {
                                  await _supabaseService.login(_emailTEC.text, _passwordTEC.text);
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => TasksList()));
                                } catch (error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message:
                                      error.toString(),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text('Login')
                          ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Not registered ?",
                      style: TextTheme.of(context).bodyMedium,
                    ),
                    ElevatedButton(
                      onPressed: ()  {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Register()));
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(TodoTheme.backgroundGreen2),
                      ),
                      child: Text("Sign up")
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
