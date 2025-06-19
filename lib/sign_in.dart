import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ofhowauzjobeglixwwur.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9maG93YXV6am9iZWdsaXh3d3VyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAxNTkyNjUsImV4cCI6MjA2NTczNTI2NX0.XRfLYsS1x9oHbtORMJy4JGXtrOxOPolPI7r00tASEmU',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Supabase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  bool _loading = false;

  final supabase = Supabase.instance.client;

  // --- START: CORRECTED METHOD ---
  Future<void> _authenticate() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please enter email and password.');
      return;
    }

    setState(() => _loading = true);

    try {
      if (_isLogin) {
        // Use the new method: signInWithPassword
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } else {
        // Use the new method: signUp with named parameters
        await supabase.auth.signUp(
          email: email,
          password: password,
        );
      }

      if (mounted) {
        _showMessage(_isLogin ? 'Login successful!' : 'Signup successful! Please check your email.');
        // TODO: Navigate to your app's home page
      }
    } on AuthException catch (e) {
      _showMessage('Authentication Failed: ${e.message}');
    } catch (e) {
      _showMessage('An unexpected error occurred: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }
  // --- END: CORRECTED METHOD ---


  // --- START: CORRECTED METHOD ---
  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);

    try {
      // Use the new method: signInWithOAuth
      await supabase.auth.signInWithOAuth(OAuthProvider.google);

    } on AuthException catch (e) {
      _showMessage('Google Sign-In Failed: ${e.message}');
    } catch (e) {
      _showMessage('An unexpected error occurred: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }
  // --- END: CORRECTED METHOD ---

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // The build method remains unchanged.
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autofillHints: [AutofillHints.email],
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              autofillHints: [AutofillHints.password],
            ),
            SizedBox(height: 24),
            _loading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _authenticate,
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: Image.asset( // Use Image.asset
                          'assets/images/google.png', // The path to your local file
                          height: 18,
                          width: 18,
                        ),
                        label: Text('Sign in with Google'),
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextButton(
                        onPressed: () => setState(() => _isLogin = !_isLogin),
                        child: Text(_isLogin
                            ? "Don't have an account? Sign Up"
                            : "Already have an account? Login"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
