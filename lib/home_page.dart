import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final provider = user?.appMetadata['provider'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                if (provider == 'google') {
                  await GoogleSignIn().signOut();
                }
                await supabase.auth.signOut();
                
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error during sign out: ${error.toString()}'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ));
                }
              }
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome! You have successfully signed in.',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}