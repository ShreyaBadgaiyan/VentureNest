import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/auth/login_screen.dart';
import 'package:ui/investor_screens/ifunded.dart';
import 'package:ui/investor_screens/ihome.dart';
import 'package:ui/investor_screens/iprofile.dart';
import 'package:ui/investor_screens/istatistics.dart';

class INavigationMenu extends StatefulWidget {
  final String uid;

  const INavigationMenu({super.key, required this.uid});

  @override
  State<INavigationMenu> createState() => _INavigationMenuState();
}

class _INavigationMenuState extends State<INavigationMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> logout(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
    await auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const InvestorHomeScreen(),
      const InvestorStatisticsScreen(),
      const InvestmentDoneScreen(),
      InvestorProfileView()
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 32, 172, 130),
        title: const Center(
          child: Text(
            'Investor Interface',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.logout),
            onPressed: _showLogoutDialog,
          )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 32, 172, 130),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.graph),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.money),
            label: 'Investment Acquired',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Statistics Screen'));
  }
}

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Investment Acquired Screen'));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Screen'));
  }
}
