import 'package:flutter/material.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({Key? key}) : super(key: key);

  @override
  _MyJobsScreenState createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // random data
  final List<Map<String, String>> activeJobs = [
    {'title': 'Remote Project Management', 'type': 'Project Manager', 'image': 'assets/images/job1.png'},
    {'title': 'Logo Design for Startup', 'type': 'Graphic Designer', 'image': 'assets/images/job2.png'},
    {'title': 'Blog Post Series', 'type': 'Content Writer', 'image': 'assets/images/job3.png'},
  ];

  final List<Map<String, String>> completedJobs = [
    {'title': 'E-commerce Site Audit', 'type': 'SEO Specialist', 'image': 'assets/images/job4.png'},
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false, 
        title: const Text(
          'My Jobs',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 30),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey, 
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Drafts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobList(activeJobs),
          _buildJobList(completedJobs),
          const Center(child: Text('No drafts yet.')),
        ],
      ),
    );
  }

  Widget _buildJobList(List<Map<String, String>> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs in this category.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = jobs[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              job['image']!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(width: 60, height: 60, color: Colors.grey[200]);
              },
            ),
          ),
          title: Text(job['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(job['type']!, style: TextStyle(color: Colors.grey[600])),
          onTap: () {},
        );
      },
    );
  }
}