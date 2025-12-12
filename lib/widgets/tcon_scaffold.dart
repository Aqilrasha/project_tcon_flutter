import 'package:flutter/material.dart';

class TconScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String? title;

  const TconScaffold({
    super.key,
    required this.body,
    this.currentIndex = 0,
    this.title,
  });

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home-html');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/artists');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/orders');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/concerts');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tcon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo,
        elevation: 2,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.indigo),
                child: const Text(
                  'Tcon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _drawerTile(context, Icons.home, 'Beranda', 0),
              _drawerTile(context, Icons.people, 'Artis', 1),
              _drawerTile(context, Icons.receipt_long, 'Pesanan', 2),
              _drawerTile(context, Icons.event, 'Konser', 3),
              _drawerTile(context, Icons.person, 'Profil', 4),
            ],
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => _onNavTap(context, i),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Artis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Konser',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _drawerTile(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _onNavTap(context, index);
      },
    );
  }
}
