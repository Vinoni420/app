// lib/chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          // This Expanded widget creates the empty space for the conversation.
          Expanded(
            child: Container(),
          ),
          
          // The message input bar at the bottom.
          _buildMessageComposer(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      shadowColor: Colors.grey[200],
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const Text('Sophia', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.black),
          onPressed: () { /* TODO: Implement video call */ },
        ),
      ],
    );
  }

  Widget _buildMessageComposer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar_ethan.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.image_outlined, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Icon(Icons.mic_none, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}