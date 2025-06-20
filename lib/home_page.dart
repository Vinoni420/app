// lib/home_page.dart

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart'; // To get the 'supabase' client

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user from Supabase
    final user = supabase.auth.currentUser;
    // Check how the user signed in. This will be 'google', 'email', etc.
    final provider = user?.appMetadata['provider'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                // --- THIS IS THE NEW "SMART" LOGIC ---
                // If the user signed in with Google, sign out from Google first.
                if (provider == 'google') {
                  await GoogleSignIn().signOut();
                }

                // Always sign out from Supabase
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