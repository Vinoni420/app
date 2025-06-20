// lib/login_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    setState(() => _isLoading = true);
    try {
      await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        _showSuccessSnackBar('Success! created account.');
        setState(() => _isLogin = true);
      }
    } on AuthException catch (error) {
      if (mounted) _showErrorSnackBar(error.message);
    } catch (error) {
      if (mounted) _showErrorSnackBar('An unexpected error occurred');
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    setState(() => _isLoading = true);
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        _showSuccessSnackBar('Login successful!');
        // In this version, we don't navigate away. The user is logged in.
      }
    } on AuthException catch (error) {
      if (mounted) _showErrorSnackBar(error.message);
    } catch (error) {
      if (mounted) _showErrorSnackBar('An unexpected error occurred');
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      if (kIsWeb) {
        await supabase.auth.signInWithOAuth(OAuthProvider.google);
      } else {
        final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']!;
        final GoogleSignIn googleSignIn = GoogleSignIn(clientId: webClientId);
        final googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }
        final googleAuth = await googleUser.authentication;
        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;
        if (accessToken == null || idToken == null) {
          throw 'Google sign in failed: missing token.';
        }
        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
      }
      if (mounted) {
        _showSuccessSnackBar('Google sign-in successful!');
      }
    } on AuthException catch (error) {
      if (mounted) _showErrorSnackBar(error.message);
    } catch (error) {
      if (mounted) _showErrorSnackBar(error.toString());
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This build method is the same as the one you had before.
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(_isLogin ? 'Welcome Back!' : 'Create Your Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || v.trim().isEmpty || !v.contains('@'))
                      ? 'Please enter a valid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Please enter a password';
                    if (!_isLogin && v.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _isLogin ? _signIn : _signUp,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: Text(_isLogin ? 'LOGIN' : 'SIGN UP')),
                const SizedBox(height: 16),
                Row(children: [
                  const Expanded(child: Divider()),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR', style: TextStyle(color: Colors.grey[600]))),
                  const Expanded(child: Divider()),
                ]),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _signInWithGoogle,
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In with Google'),
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () => setState(() {
                            _isLogin = !_isLogin;
                            _formKey.currentState?.reset();
                          }),
                  child: Text(_isLogin
                      ? 'Don\'t have an account? Sign Up'
                      : 'Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}