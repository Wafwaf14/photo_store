import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String? error;

    try {
      if (_isLogin) {
        error = await authProvider.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        error = await authProvider.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, const Color.fromARGB(255, 180, 188, 71)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Language Switcher
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              value: languageProvider.currentLocale.languageCode,
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Text('English'),
                                ),
                                DropdownMenuItem(
                                  value: 'fr',
                                  child: Text('Français'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  languageProvider.changeLanguage(value);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        
                        // Logo/Title
                        Icon(
                          Icons.photo_library,
                          size: 80,
                          color: const Color.fromARGB(255, 180, 188, 71),
                        ),
                        SizedBox(height: 16),
                        Text(
                          loc.translate('app_title'),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 32),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: loc.translate('email'),
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return loc.translate('email_required');
                            }
                            if (!value.contains('@')) {
                              return loc.translate('email_invalid');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: loc.translate('password'),
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return loc.translate('password_required');
                            }
                            if (value.length < 6) {
                              return loc.translate('password_short');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color.fromARGB(255, 180, 188, 71),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    _isLogin
                                        ? loc.translate('sign_in')
                                        : loc.translate('sign_up'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Toggle Login/Signup
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin
                                ? loc.translate('no_account')
                                : loc.translate('have_account'),
                            style: TextStyle(color: const Color.fromARGB(255, 180, 188, 71)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}