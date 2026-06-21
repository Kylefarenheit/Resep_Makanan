import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedTab = 0; // 0 = Semua, 1 = Belum Dibaca, 2 = Dibaca

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'title': 'New recipe!',
      'message': 'Jauh di sana, di balik pegunungan katakata, jauh dari negara-negara.',
      'time': 'Today',
      'isRead': false,
    },
    {
      'title': 'Don\'t forget to try your saved recipe',
      'message': 'Far far away, behind the word mountains, far from the countries.',
      'time': 'Today',
      'isRead': false,
    },
    {
      'title': 'Don\'t forget to try your saved recipe',
      'message': 'Far far away, behind word mountains, far from the countries.',
      'time': 'Yesterday',
      'isRead': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    if (_selectedTab == 0) {
      return _allNotifications;
    } else if (_selectedTab == 1) {
      return _allNotifications.where((n) => n['isRead'] == false).toList();
    } else {
      return _allNotifications.where((n) => n['isRead'] == true).toList();
    }
  }

  void _markAsRead(int index) {
    setState(() {
      _allNotifications[index]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
      ),
      body: Column(
        children: [
          // Tab Selector (Semua / Belum Dibaca / Dibaca)
          _buildTabSelector(),
          const SizedBox(height: 16),
          
          // Daftar Notifikasi
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      final originalIndex = _allNotifications.indexOf(notification);
                      return _buildNotificationCard(
                        title: notification['title'],
                        message: notification['message'],
                        time: notification['time'],
                        isRead: notification['isRead'],
                        onTap: () => _markAsRead(originalIndex),
                      );
                    },
                  ),
          ),
          
          // Footer "You're all set!"
          _buildFooter(),
        ],
      ),
    );
  }

  // Widget Tab Selector
  Widget _buildTabSelector() {
    final tabs = ['Semua', 'Belum Dibaca', 'Dibaca'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: isSelected
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
                    tabs[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget Card Notifikasi
  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required bool isRead,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRead ? Colors.grey.shade200 : Colors.red.shade100,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Indikator belum dibaca (titik merah)
                if (!isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (!isRead) const SizedBox(width: 8),
                
                // Judul
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isRead ? Colors.black87 : Colors.black,
                    ),
                  ),
                ),
                
                // Waktu
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Pesan
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: isRead ? Colors.grey.shade600 : Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Empty State (ketika tidak ada notifikasi)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada notifikasi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Footer
  Widget _buildFooter() {
    if (_filteredNotifications.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          "You're all set!",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}