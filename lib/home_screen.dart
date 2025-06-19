// lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // --- MOCK DATA ---
  // In a real app, this would come from an API or a state management solution
  final List<Map<String, String>> featuredFreelancers = const [
    {'name': 'Sarah, Designer', 'role': 'UI/UX Designer', 'image': 'assets/images/avatar_sarah.png'},
    {'name': 'Mark, Developer', 'role': 'Web Developer', 'image': 'assets/images/avatar_mark.png'},
    {'name': 'Emily, Writer', 'role': 'Content Writer', 'image': 'assets/images/avatar_emily.png'},
  ];

  final List<Map<String, String>> popularCategories = const [
    {'name': 'Design', 'image': 'assets/images/category_design.png'},
    {'name': 'Development', 'image': 'assets/images/category_development.png'},
    {'name': 'Writing', 'image': 'assets/images/category_writing.png'},
    {'name': 'Marketing', 'image': 'assets/images/category_marketing.png'},
  ];
  // --- END MOCK DATA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  // WIDGET BUILDER METHODS

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0, // Removes the shadow
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: const Text(
        'Connect',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.list, color: Colors.black),
          onPressed: () { /* TODO: Implement filter/menu action */ },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 30),
            _buildSectionHeader('Featured Freelancers'),
            const SizedBox(height: 15),
            _buildFeaturedFreelancersList(),
            const SizedBox(height: 30),
            _buildSectionHeader('Popular Job Categories'),
            const SizedBox(height: 15),
            _buildPopularCategoriesGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Find freelancers or jobs',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildFeaturedFreelancersList() {
    return SizedBox(
      height: 160, // Give the ListView a fixed height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredFreelancers.length,
        itemBuilder: (context, index) {
          final freelancer = featuredFreelancers[index];
          return Container(
            width: 120, // Give each item a fixed width
            margin: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(freelancer['image']!),
                  backgroundColor: Colors.grey[300], // Fallback color
                ),
                const SizedBox(height: 10),
                Text(
                  freelancer['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  freelancer['role']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularCategoriesGrid() {
    return GridView.builder(
      shrinkWrap: true, // Important to use inside a Column/SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(), // The outer scroll view will handle scrolling
      itemCount: popularCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1 / 1.2, // Adjust aspect ratio (width / height)
      ),
      itemBuilder: (context, index) {
        final category = popularCategories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(category['image']!),
                    fit: BoxFit.cover,
                  ),
                   color: Colors.grey[300], // Fallback color
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name']!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        );
      },
    );
  }
}