import 'package:app/chat_screen.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  // random data

  final List<Map<String, String>> messages = const [
    {'name': 'Sophia Carter', 'message': 'Sure, I\'ll send you the files by EOD.', 'avatar': 'assets/images/avatar_sophia.png'},
    {'name': 'Ethan Bennett', 'message': 'Thanks for the quick turnaround!', 'avatar': 'assets/images/avatar_ethan.png'},
    {'name': 'Olivia Hayes', 'message': 'Let\'s schedule a call for tomorrow.', 'avatar': 'assets/images/avatar_olivia.png'},
    {'name': 'Liam Foster', 'message': 'The project is looking great!', 'avatar': 'assets/images/avatar_liam.png'},
    {'name': 'Ava Moore', 'message': 'I\'ve reviewed the proposal and it\'s perfect.', 'avatar': 'assets/images/avatar_ava.png'},
    {'name': 'Noah Parker', 'message': 'Can we discuss the next steps?', 'avatar': 'assets/images/avatar_noah.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildMessagesList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search messages',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(height: 24, thickness: 1, indent: 70),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(message['avatar']!),
          ),
          title: Text(message['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            message['message']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey[600]),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
        );
      },
    );
  }
}