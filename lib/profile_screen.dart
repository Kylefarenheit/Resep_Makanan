import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0; // 0 = Video, 1 = Recipe

  final List<Map<String, dynamic>> _userRecipes = [
    {
      'title': 'Caramelambu Ayam Sayur Rudaai',
      'rating': 5.0,
      'ingredients': 12,
      'time': '40 min',
      'image': null,
    },
    {
      'title': 'Dadar Telur Mas Rusul',
      'rating': 1.0,
      'ingredients': 12,
      'time': '40 min',
      'image': null,
    },
    {
      'title': 'Nasi Goreng mang Fadly',
      'rating': 4.7,
      'ingredients': 12,
      'time': '40 min',
      'image': null,
    },
  ];

  final List<Map<String, dynamic>> _userVideos = [
    {
      'title': 'Cara Masak Ayam Goreng',
      'duration': '5:30',
      'views': '1.2K',
      'image': null,
    },
    {
      'title': 'Tutorial Memasak Nasi Goreng',
      'duration': '8:15',
      'views': '890',
      'image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Jam
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '19:27',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            
            // My Profile Section
            _buildProfileHeader(),
            const SizedBox(height: 24),
            
            // Stats Section (Recipe, Videos, Followers, Following)
            _buildStatsSection(),
            const SizedBox(height: 24),
            
            // Tab Selector (Video / Recipe)
            _buildTabSelector(),
            const SizedBox(height: 16),
            
            // Content berdasarkan tab yang dipilih
            _selectedTab == 0 ? _buildVideoTab() : _buildRecipeTab(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget Profile Header
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 50,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          
          // Nama dan Bio
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Mas Fadly',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.verified,
                      size: 18,
                      color: Colors.blue.shade400,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Halo Nama Saya Fadly, pembuat resep nikmat asal ngawi, sedap lah ya cik😊',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Tombol Edit Profile
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: 14, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(
                        'Edit profile',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Stats Section
  Widget _buildStatsSection() {
    final stats = [
      {'label': 'Recipe', 'value': '3'},
      {'label': 'Videos', 'value': '13'},
      {'label': 'Followers', 'value': '2'},
      {'label': 'Following', 'value': '120'},
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((stat) {
          return Column(
            children: [
              Text(
                stat['value']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat['label']!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Widget Tab Selector
  Widget _buildTabSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: _selectedTab == 0
                      ? [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Video',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selectedTab == 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: _selectedTab == 1
                      ? [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Recipe',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selectedTab == 1 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tab Video
  Widget _buildVideoTab() {
    if (_userVideos.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('Belum ada video'),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _userVideos.length,
      itemBuilder: (context, index) {
        final video = _userVideos[index];
        return _buildVideoCard(
          title: video['title']!,
          duration: video['duration']!,
          views: video['views']!,
        );
      },
    );
  }

  // Tab Recipe
  Widget _buildRecipeTab() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _userRecipes.length,
      itemBuilder: (context, index) {
        final recipe = _userRecipes[index];
        return _buildRecipeCard(
          title: recipe['title']!,
          rating: recipe['rating']!,
          ingredients: recipe['ingredients']!,
          time: recipe['time']!,
        );
      },
    );
  }

  // Card untuk Video
  Widget _buildVideoCard({
    required String title,
    required String duration,
    required String views,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.play_circle_filled,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.visibility,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        views,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card untuk Recipe
  Widget _buildRecipeCard({
    required String title,
    required double rating,
    required int ingredients,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.restaurant,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // Ingredients & Time
                  Row(
                    children: [
                      Text(
                        '$ingredients Ingredients',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}