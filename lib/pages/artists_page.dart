import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/tcon_scaffold.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Artis',
      currentIndex: 1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ================= TITLE =================
              const Text(
                "Direktori Artis Musik Pilihan",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Telusuri artis favorit Anda dari berbagai genre, mulai dari superstar global hingga bintang lokal kebanggaan Indonesia.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 25),

              // ================== SEARCH BOX ==================
              _buildSearchBox(),
              const SizedBox(height: 25),

              // ================= GRID ARTISTS =================
              _buildArtistsGrid(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Build search box widget
  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(color: Colors.indigo.shade500, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari nama artis, grup, atau genre...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build artists grid
  Widget _buildArtistsGrid(BuildContext context) {
    final artists = [
      ("Arash Buana", "assets/images/arash buana.webp", "Pop Superstar"),
      ("Shakira Jasmine", "assets/images/Shakira.webp", "Rock Alternatif"),
      ("Tiara Andini", "assets/images/tiara andini.png", "Acoustic Pop"),
      ("Maudy Ayunda", "assets/images/maudy ayunda.webp", "Solo"),
      ("Juicy Lucy", "assets/images/juicy.webp", "Pop / R&B"),
      ("Sheila On 7", "assets/images/sheila.webp", "Lokal / Pop Rock"),
      ("Tulus", "assets/images/tulus.webp", "Lokal / Jazz Pop"),
      ("Lyodra", "assets/images/yodra.webp", "Pop / Dance"),
      ("Raisa", "assets/images/raisa.webp", "Lokal / R&B"),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 600) crossAxisCount = 3;
        if (constraints.maxWidth > 900) crossAxisCount = 5;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: artists
              .map(
                (artist) => ArtistCard(
                  name: artist.$1,
                  imageUrl: artist.$2,
                  genre: artist.$3,
                  onTap: () {
                    Navigator.pushNamed(context, '/artist-detail');
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
