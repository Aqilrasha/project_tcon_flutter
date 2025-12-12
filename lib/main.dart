import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/home_from_html.dart';
import 'pages/artists_page.dart';
import 'pages/artist_detail_page.dart';
import 'pages/riwayat_pembayaran.dart';
import 'pages/event_list_page.dart';
import 'pages/profile_page.dart';
import 'pages/live_gallery.dart';
import 'pages/login_register.dart';

void main() {
  runApp(const TconApp());
}

class TconApp extends StatelessWidget {
  const TconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tcon - Concert Ticket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const LoginRegisterPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/home-html': (context) => const HomeFromHtmlPage(),
        '/artists': (context) => const ArtistsPage(),
        '/orders': (context) => const RiwayatPembayaranPage(),
        '/concerts': (context) => EventListPage(),
        '/profile': (context) => const ProfilePage(),
        '/artist-detail': (context) => const ArtistDetailPage(),
        '/gallery': (context) => const LiveGalleryPage(),
      },
    );
  }
}
