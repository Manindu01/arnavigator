import 'package:flutter/material.dart';
import 'ar_navigator_screen.dart';
import 'services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const NavigatorPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // Load last selected tab
    StorageService.getInt(StorageKeys.selectedTabIndex).then((value) {
      if (!mounted) return;
      if (value != null && value >= 0 && value < _pages.length) {
        setState(() => _selectedIndex = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotScreen()),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1b263b),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // Save selection
          StorageService.setInt(StorageKeys.selectedTabIndex, index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Navigator',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Good Morning!',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1b263b),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.store_mall_directory,
                    title: 'Store Directory',
                    subtitle: 'Find Stores',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoreDirectoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.local_parking,
                    title: 'Parking',
                    subtitle: 'Find My Car',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ParkingScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.restaurant,
                    title: 'Food Court',
                    subtitle: 'Dining Options',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodCourtScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.local_offer,
                    title: 'Deals & Offers',
                    subtitle: 'Save Money',
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DealsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.directions_car,
                    title: 'Car Rental',
                    subtitle: 'Book Now',
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarRentalScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.event,
                    title: 'Events',
                    subtitle: 'What\'s On',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Mall Services
            const Text(
              'Mall Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  _buildServiceItem(
                    icon: Icons.info_outline,
                    title: 'Customer Service',
                    subtitle: 'Get help and information',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white12),
                  _buildServiceItem(
                    icon: Icons.accessible,
                    title: 'Accessibility Services',
                    subtitle: 'Wheelchair, stroller rentals',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white12),
                  _buildServiceItem(
                    icon: Icons.family_restroom,
                    title: 'Family Services',
                    subtitle: 'Baby changing, family rooms',
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white12),
                  _buildServiceItem(
                    icon: Icons.local_atm,
                    title: 'ATM & Banking',
                    subtitle: 'Find nearest ATM',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.orange, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white38,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff1b263b),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  List<String> _recentLocations = [];

  final List<Map<String, dynamic>> _defaultRecent = const [
    {
      'location': 'Westfield Shopping Center',
      'distance': 'Floor 2 - Electronics',
      'icon': Icons.shopping_bag,
    },
    {
      'location': 'Mall of America',
      'distance': 'Food Court - Level 3',
      'icon': Icons.restaurant,
    },
    {
      'location': 'Times Square Mall',
      'distance': 'Nike Store - Ground Floor',
      'icon': Icons.store,
    },
    {
      'location': 'Century City Mall',
      'distance': 'Parking Level B2',
      'icon': Icons.local_parking,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadRecent();
  }

  Future<void> _loadRecent() async {
    final list = await StorageService.getStringList(
      StorageKeys.recentDestinations,
    );
    if (!mounted) return;
    setState(() => _recentLocations = list);
  }

  Future<void> _addRecent(String location) async {
    final list = await StorageService.getStringList(
      StorageKeys.recentDestinations,
    );
    // Move to front and dedupe
    list.remove(location);
    list.insert(0, location);
    if (list.length > 10) list.removeRange(10, list.length);
    await StorageService.setStringList(StorageKeys.recentDestinations, list);
    if (!mounted) return;
    setState(() => _recentLocations = list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AR Mall Navigator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find your way through shopping malls with AR',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // AR Navigation Features
            const Text(
              'AR Navigation Features',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildNavigationCard(
                    title: 'AR Path View',
                    icon: Icons.view_in_ar,
                    color: Colors.orange,
                    subtitle: 'Live AR directions',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavigationCard(
                    title: 'Store Finder',
                    icon: Icons.store,
                    color: Colors.blue,
                    subtitle: 'Find any shop',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildNavigationCard(
                    title: 'Mall Map',
                    icon: Icons.map,
                    color: Colors.green,
                    subtitle: '3D floor plans',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavigationCard(
                    title: 'Scan & Go',
                    icon: Icons.qr_code_scanner,
                    color: Colors.purple,
                    subtitle: 'QR navigation',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recent Mall Visits
            const Text(
              'Recent Mall Visits',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  // Persisted recents
                  ..._recentLocations.map(
                    (loc) => _buildRecentSearchItem(
                      location: loc,
                      distance: 'Recent destination',
                      icon: Icons.history,
                      onNavigate: () => _addRecent(loc),
                    ),
                  ),
                  // Defaults
                  ..._defaultRecent.map(
                    (e) => _buildRecentSearchItem(
                      location: e['location'] as String,
                      distance: e['distance'] as String,
                      icon: e['icon'] as IconData,
                      onNavigate: () => _addRecent(e['location'] as String),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1b263b),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem({
    required String location,
    required String distance,
    required IconData icon,
    required VoidCallback onNavigate,
  }) {
    return Card(
      color: const Color(0xff1b263b),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(
          location,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(distance, style: TextStyle(color: Colors.grey[400])),
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
          tooltip: 'Navigate',
          onPressed: () {
            onNavigate();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NavigationScreen()),
            );
          },
        ),
        onTap: () {
          onNavigate();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NavigationScreen()),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(Icons.edit, 'Edit Profile'),
                  _buildMenuItem(Icons.security, 'Security'),
                  _buildMenuItem(Icons.notifications, 'Notifications'),
                  _buildMenuItem(Icons.help, 'Help & Support'),
                  _buildMenuItem(Icons.info, 'About'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Logout', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xff1b263b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: () {},
      ),
    );
  }
}

// ChatBot Screen
class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final data = await StorageService.getJson(StorageKeys.chatMessages);
    if (!mounted) return;
    if (data is List) {
      setState(() {
        _messages = data.map((e) {
          final map = e as Map<String, dynamic>;
          return ChatMessage(
            text: map['text'] as String? ?? '',
            isBot: map['isBot'] as bool? ?? false,
            timestamp:
                DateTime.tryParse(map['ts'] as String? ?? '') ?? DateTime.now(),
          );
        }).toList();
      });
    }
    if (_messages.isEmpty) {
      setState(() {
        _messages = [
          ChatMessage(
            text:
                "Hello! I'm your virtual assistant. How can I help you today?",
            isBot: true,
            timestamp: DateTime.now(),
          ),
        ];
      });
      _persistMessages();
    }
  }

  Future<void> _persistMessages() async {
    final list = _messages
        .map(
          (m) => {
            'text': m.text,
            'isBot': m.isBot,
            'ts': m.timestamp.toIso8601String(),
          },
        )
        .toList();
    await StorageService.setJson(StorageKeys.chatMessages, list);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: _messageController.text.trim(),
      isBot: false,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
    });
    _persistMessages();

    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1500), () {
      final botResponse = _generateBotResponse(userMessage.text);
      setState(() {
        _messages.add(
          ChatMessage(
            text: botResponse,
            isBot: true,
            timestamp: DateTime.now(),
          ),
        );
      });
      _persistMessages();
      _scrollToBottom();
    });
  }

  String _generateBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('hello') || message.contains('hi')) {
      return "Hello! How can I assist you today?";
    } else if (message.contains('help')) {
      return "I can help you with:\n• Account information\n• Navigation guidance\n• General questions\n• App features";
    } else if (message.contains('account') || message.contains('profile')) {
      return "You can manage your account by going to the Profile tab. There you can edit your information, change settings, and more.";
    } else if (message.contains('wallet') || message.contains('balance')) {
      return "Your current wallet balance is \$1,234.56. You can view transaction history and manage payments from the Wallet section.";
    } else if (message.contains('order')) {
      return "You have 12 active orders. You can track them in the Orders section from the Quick Actions menu.";
    } else if (message.contains('thank')) {
      return "You're welcome! Is there anything else I can help you with?";
    } else if (message.contains('bye') || message.contains('goodbye')) {
      return "Goodbye! Feel free to chat with me anytime you need assistance.";
    } else {
      return "I understand you're asking about '$userMessage'. Could you please provide more details so I can better assist you?";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xff1b263b),
              border: Border(top: BorderSide(color: Colors.white12, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff0d1b2a),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isBot
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isBot) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isBot ? const Color(0xff1b263b) : Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(message.isBot ? 4 : 18),
                  bottomRight: Radius.circular(message.isBot ? 18 : 4),
                ),
                border: message.isBot
                    ? Border.all(color: Colors.white12)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isBot ? Colors.white : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isBot ? Colors.white54 : Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!message.isBot) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: const Icon(Icons.person, color: Colors.white70, size: 18),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}

// Chat Message Model
class ChatMessage {
  final String text;
  final bool isBot;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isBot,
    required this.timestamp,
  });
}

// Car Rental Screen
class CarRentalScreen extends StatefulWidget {
  const CarRentalScreen({super.key});

  @override
  State<CarRentalScreen> createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  String selectedCarType = 'Economy';
  DateTime pickupDate = DateTime.now();
  DateTime returnDate = DateTime.now().add(const Duration(days: 1));
  String pickupLocation = 'Downtown';
  String returnLocation = 'Downtown';

  final List<Map<String, dynamic>> carTypes = [
    {
      'name': 'Economy',
      'price': '\$25/day',
      'image': '🚗',
      'features': ['Manual', '4 Seats', 'AC'],
    },
    {
      'name': 'Compact',
      'price': '\$35/day',
      'image': '🚙',
      'features': ['Automatic', '5 Seats', 'AC'],
    },
    {
      'name': 'SUV',
      'price': '\$65/day',
      'image': '🚐',
      'features': ['Automatic', '7 Seats', 'AC', '4WD'],
    },
    {
      'name': 'Luxury',
      'price': '\$120/day',
      'image': '🚘',
      'features': ['Automatic', '5 Seats', 'Leather', 'Premium'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Car Rental'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Details Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Location Selection
                  Row(
                    children: [
                      Expanded(
                        child: _buildLocationCard(
                          'Pickup',
                          pickupLocation,
                          Icons.location_on,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildLocationCard(
                          'Return',
                          returnLocation,
                          Icons.location_off,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date Selection
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateCard('Pickup Date', pickupDate),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateCard('Return Date', returnDate),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Available Cars Section
            const Text(
              'Available Cars',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Car List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: carTypes.length,
              itemBuilder: (context, index) {
                final car = carTypes[index];
                final isSelected = selectedCarType == car['name'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff1b263b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Colors.orange
                          : Colors.white.withOpacity(0.1),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          car['image'],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    title: Text(
                      car['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          car['price'],
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: (car['features'] as List<String>).map((
                            feature,
                          ) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: Radio<String>(
                      value: car['name'],
                      groupValue: selectedCarType,
                      onChanged: (value) {
                        setState(() {
                          selectedCarType = value!;
                        });
                      },
                      activeColor: Colors.orange,
                    ),
                    onTap: () {
                      setState(() {
                        selectedCarType = car['name'];
                      });
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Book Now Button
            ElevatedButton(
              onPressed: () {
                _showBookingConfirmation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(String title, String location, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff0d1b2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            location,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard(String title, DateTime date) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff0d1b2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            '${date.day}/${date.month}/${date.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    final selectedCar = carTypes.firstWhere(
      (car) => car['name'] == selectedCarType,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1b263b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Booking Confirmation',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car: ${selectedCar['name']} ${selectedCar['image']}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Price: ${selectedCar['price']}',
                style: const TextStyle(color: Colors.orange),
              ),
              const SizedBox(height: 8),
              Text(
                'Pickup: $pickupLocation on ${pickupDate.day}/${pickupDate.month}/${pickupDate.year}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Return: $returnLocation on ${returnDate.day}/${returnDate.month}/${returnDate.year}',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Car booked successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

// Store Directory Screen
class StoreDirectoryScreen extends StatefulWidget {
  const StoreDirectoryScreen({super.key});

  @override
  State<StoreDirectoryScreen> createState() => _StoreDirectoryScreenState();
}

class _StoreDirectoryScreenState extends State<StoreDirectoryScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Favorites',
    'Fashion',
    'Electronics',
    'Food',
    'Health',
    'Entertainment',
  ];

  Set<String> favoriteStores = {};

  final List<Map<String, dynamic>> stores = [
    {
      'name': 'Nike Store',
      'category': 'Fashion',
      'floor': 'Ground Floor',
      'status': 'Open',
      'hours': '10:00 AM - 10:00 PM',
    },
    {
      'name': 'Apple Store',
      'category': 'Electronics',
      'floor': 'Floor 2',
      'status': 'Open',
      'hours': '10:00 AM - 9:00 PM',
    },
    {
      'name': 'Zara',
      'category': 'Fashion',
      'floor': 'Floor 1',
      'status': 'Open',
      'hours': '10:00 AM - 10:00 PM',
    },
    {
      'name': 'McDonald\'s',
      'category': 'Food',
      'floor': 'Food Court',
      'status': 'Open',
      'hours': '8:00 AM - 11:00 PM',
    },
    {
      'name': 'Samsung Store',
      'category': 'Electronics',
      'floor': 'Floor 2',
      'status': 'Open',
      'hours': '10:00 AM - 9:00 PM',
    },
    {
      'name': 'H&M',
      'category': 'Fashion',
      'floor': 'Floor 1',
      'status': 'Open',
      'hours': '10:00 AM - 10:00 PM',
    },
    {
      'name': 'Pharmacy Plus',
      'category': 'Health',
      'floor': 'Ground Floor',
      'status': 'Open',
      'hours': '9:00 AM - 9:00 PM',
    },
    {
      'name': 'Cinema Complex',
      'category': 'Entertainment',
      'floor': 'Floor 3',
      'status': 'Open',
      'hours': '10:00 AM - 12:00 AM',
    },
  ];

  List<Map<String, dynamic>> get filteredStores {
    if (selectedCategory == 'All') return stores;
    if (selectedCategory == 'Favorites') {
      return stores
          .where((s) => favoriteStores.contains(s['name'] as String))
          .toList();
    }
    return stores
        .where((store) => store['category'] == selectedCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final list = await StorageService.getStringList(StorageKeys.favoriteStores);
    if (!mounted) return;
    setState(() => favoriteStores = list.toSet());
  }

  Future<void> _toggleFavorite(String name) async {
    final set = favoriteStores.toSet();
    if (set.contains(name)) {
      set.remove(name);
    } else {
      set.add(name);
    }
    await StorageService.setStringList(
      StorageKeys.favoriteStores,
      set.toList(),
    );
    if (!mounted) return;
    setState(() => favoriteStores = set);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Store Directory'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: const Color(0xff1b263b),
                    selectedColor: Colors.orange,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                );
              },
            ),
          ),

          // Store List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                final store = filteredStores[index];
                final isFav = favoriteStores.contains(store['name']);
                return Card(
                  color: const Color(0xff1b263b),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.store, color: Colors.orange),
                    ),
                    title: Text(
                      store['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          store['floor'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          '${store['status']} • ${store['hours']}',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.redAccent : Colors.white54,
                          ),
                          tooltip: isFav ? 'Unfavorite' : 'Add to favorites',
                          onPressed: () =>
                              _toggleFavorite(store['name'] as String),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.directions,
                            color: Colors.orange,
                          ),
                          tooltip: 'Navigate',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NavigationScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Parking Screen
class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Parking'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // My Parked Car
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.directions_car,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Car Location',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Level B2 - Section A - Spot 247',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Parked 2 hours ago',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NavigationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text('Navigate to My Car'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Parking Levels
            const Text(
              'Parking Availability',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildParkingLevel('Ground Level', 45, 120, Colors.red),
            _buildParkingLevel('Level B1', 78, 150, Colors.orange),
            _buildParkingLevel('Level B2', 92, 180, Colors.green),
            _buildParkingLevel('Level B3', 134, 200, Colors.green),

            const SizedBox(height: 30),

            // Parking Services
            const Text(
              'Parking Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildServiceCard(
                    'Valet Service',
                    Icons.person,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildServiceCard(
                    'Car Wash',
                    Icons.local_car_wash,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingLevel(
    String level,
    int available,
    int total,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1b263b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$available available of $total spaces',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${((available / total) * 100).round()}%',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1b263b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Food Court Screen
class FoodCourtScreen extends StatelessWidget {
  const FoodCourtScreen({super.key});

  final List<Map<String, dynamic>> restaurants = const [
    {
      'name': 'McDonald\'s',
      'type': 'Fast Food',
      'rating': 4.2,
      'time': '10-15 min',
      'image': '🍔',
    },
    {
      'name': 'Subway',
      'type': 'Sandwiches',
      'rating': 4.0,
      'time': '5-10 min',
      'image': '🥪',
    },
    {
      'name': 'KFC',
      'type': 'Chicken',
      'rating': 4.1,
      'time': '15-20 min',
      'image': '🍗',
    },
    {
      'name': 'Pizza Hut',
      'type': 'Pizza',
      'rating': 4.3,
      'time': '20-25 min',
      'image': '🍕',
    },
    {
      'name': 'Starbucks',
      'type': 'Coffee',
      'rating': 4.5,
      'time': '5-8 min',
      'image': '☕',
    },
    {
      'name': 'Panda Express',
      'type': 'Asian',
      'rating': 4.0,
      'time': '10-15 min',
      'image': '🥡',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Food Court'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Court Map
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff1b263b),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.map, color: Colors.orange, size: 30),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Food Court Map',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Level 3 - Central Area',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('View Map'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Restaurant List
            const Text(
              'Available Restaurants',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff1b263b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          restaurant['image'],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    title: Text(
                      restaurant['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          restaurant['type'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Text(
                              ' ${restaurant['rating']} • ${restaurant['time']}',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NavigationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(60, 35),
                      ),
                      child: const Text('Go', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Deals Screen
class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  final List<Map<String, dynamic>> deals = const [
    {
      'store': 'Nike',
      'deal': '30% Off All Shoes',
      'expires': '2 days left',
      'code': 'MALL30',
    },
    {
      'store': 'Zara',
      'deal': 'Buy 2 Get 1 Free',
      'expires': '5 days left',
      'code': 'ZARA3',
    },
    {
      'store': 'Apple Store',
      'deal': '10% Student Discount',
      'expires': 'Ongoing',
      'code': 'STUDENT10',
    },
    {
      'store': 'H&M',
      'deal': '50% Off Summer Collection',
      'expires': '1 week left',
      'code': 'SUMMER50',
    },
    {
      'store': 'Food Court',
      'deal': 'Free Drink with Meal',
      'expires': 'Today only',
      'code': 'DRINK2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Deals & Offers'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Deal
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withOpacity(0.8),
                    Colors.orange.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎉 Featured Deal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Mall-Wide Sale Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Up to 70% off at participating stores',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Valid until Sunday',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Current Offers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: deals.length,
              itemBuilder: (context, index) {
                final deal = deals[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff1b263b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_offer,
                        color: Colors.purple,
                      ),
                    ),
                    title: Text(
                      deal['store'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          deal['deal'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                deal['code'],
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              deal['expires'],
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy, color: Colors.orange),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Code ${deal['code']} copied!'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Events Screen
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  final List<Map<String, dynamic>> events = const [
    {
      'name': 'Summer Fashion Show',
      'date': 'July 28, 2025',
      'time': '7:00 PM',
      'location': 'Central Court',
      'image': '👗',
    },
    {
      'name': 'Kids Art Workshop',
      'date': 'July 30, 2025',
      'time': '2:00 PM',
      'location': 'Activity Zone',
      'image': '🎨',
    },
    {
      'name': 'Live Music Performance',
      'date': 'August 2, 2025',
      'time': '6:00 PM',
      'location': 'Food Court Stage',
      'image': '🎵',
    },
    {
      'name': 'Tech Product Launch',
      'date': 'August 5, 2025',
      'time': '11:00 AM',
      'location': 'Apple Store',
      'image': '📱',
    },
    {
      'name': 'Cooking Demo',
      'date': 'August 8, 2025',
      'time': '3:00 PM',
      'location': 'Food Court',
      'image': '👨‍🍳',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d1b2a),
      appBar: AppBar(
        backgroundColor: const Color(0xff1b263b),
        foregroundColor: Colors.white,
        title: const Text('Events'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Featured Event
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withOpacity(0.8),
                    Colors.blue.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌟 Today\'s Feature',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Summer Fashion Show',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Join us for an exclusive fashion showcase',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '7:00 PM • Central Court',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Upcoming Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff1b263b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          event['image'],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    title: Text(
                      event['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${event['date']} at ${event['time']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          event['location'],
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added ${event['name']} to calendar!',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size(50, 35),
                      ),
                      child: const Text('RSVP', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
