// lib/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // As noted, the back arrow is removed as we are in the main nav
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildSectionTitle('About'),
              const SizedBox(height: 8),
              _buildAboutText(),
              const SizedBox(height: 24),
              _buildSectionTitle('Skills'),
              const SizedBox(height: 12),
              _buildSkillsChips(),
              const SizedBox(height: 24),
              _buildSectionTitle('Reviews'),
              const SizedBox(height: 16),
              _buildReviewsSection(),
              const SizedBox(height: 16),
              _buildReviewItem('Ethan Harper', '2 months ago', 'assets/images/avatar_ethan.png',
                'Sophia is an exceptional designer. Her attention to detail and user-centric approach resulted in a fantastic product. Highly recommend!',
                5, 1, 5),
              const Divider(height: 32),
              _buildReviewItem('Olivia Bennett', '3 months ago', 'assets/images/avatar_olivia.png',
                'Sophia delivered a solid design, but there were a few minor issues that needed addressing. Overall, a good experience.',
                2, 0, 4),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/avatar_sophia.png'),
          ),
          SizedBox(height: 12),
          Text(
            'Sophia Carter',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'UX Designer | Joined 2021',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('4.9', 'Rating'),
        _buildStatCard('12', 'Jobs'),
        _buildStatCard('20', 'Hours'),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 90,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildAboutText() {
    return Text(
      'Experienced UX designer with a passion for creating intuitive and user-friendly interfaces. Specializing in user research, wireframing, and prototyping.',
      style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
    );
  }

  Widget _buildSkillsChips() {
    final skills = ['User Research', 'Wireframing', 'Interaction Design', 'Prototyping', 'Usability Testing'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: skills.map((skill) => Chip(
        label: Text(skill),
        backgroundColor: Colors.grey[200],
        labelStyle: const TextStyle(color: Colors.black54),
        side: BorderSide.none,
      )).toList(),
    );
  }

  Widget _buildReviewsSection() {
    return Row(
      children: [
        // Left side: Overall Rating
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('4.9', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Row(
              children: List.generate(5, (index) => Icon(
                index < 4 ? Icons.star : Icons.star_half, // 4.5 stars
                color: Colors.amber,
                size: 18,
              )),
            ),
            const SizedBox(height: 4),
            const Text('15 reviews', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 20),
        // Right side: Rating bars
        Expanded(
          child: Column(
            children: [
              _buildRatingBar('5', 0.80),
              _buildRatingBar('4', 0.10),
              _buildRatingBar('3', 0.05),
              _buildRatingBar('2', 0.03),
              _buildRatingBar('1', 0.02),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String label, double value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[200],
            color: Colors.black,
            minHeight: 6,
          ),
        ),
        const SizedBox(width: 8),
        Text('${(value * 100).toInt()}%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildReviewItem(String name, String date, String avatar, String reviewText, int likes, int dislikes, int starRating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Row(
              children: List.generate(5, (index) => Icon(
                index < starRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              )),
            )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          reviewText,
          style: TextStyle(color: Colors.grey[800], height: 1.4),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text('$likes'),
            const SizedBox(width: 16),
            Icon(Icons.thumb_down_alt_outlined, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text('$dislikes'),
          ],
        ),
      ],
    );
  }
}