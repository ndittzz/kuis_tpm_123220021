import 'package:flutter/material.dart';
import 'package:quiz_123220021_mohamadrisqiaditiya/screens/profile_page.dart';
import 'package:quiz_123220021_mohamadrisqiaditiya/screens/trapesium_page.dart';
import 'package:quiz_123220021_mohamadrisqiaditiya/screens/kubus_page.dart';
import 'package:quiz_123220021_mohamadrisqiaditiya/screens/hitung_hari_page.dart';
import 'package:quiz_123220021_mohamadrisqiaditiya/screens/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOMEPAGE',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Hai, $username! 👋',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _buatMenu(context, menuItems[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () => _tampilExit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buatMenu(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => item.page)),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              item.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _tampilExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Yakin ingin keluar?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Batal')),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final Widget page;

  MenuItem({required this.title, required this.icon, required this.page});
}

final List<MenuItem> menuItems = [
  MenuItem(title: 'Profile', icon: Icons.person, page: ProfilePage()),
  MenuItem(
      title: 'Hitung Trapesium', icon: Icons.calculate, page: TrapesiumPage()),
  MenuItem(
      title: 'Hitung Kubus',
      icon: Icons.format_list_numbered,
      page: KubusPage()),
  MenuItem(title: 'Hitung Hari', icon: Icons.numbers, page: HariPage()),
];
