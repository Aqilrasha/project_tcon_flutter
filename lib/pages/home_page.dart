import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: const Text(
          "Tcon",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.indigo, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HERO SECTION =================
            _buildHeroSection(context),

            const SizedBox(height: 25),

            // ================= ARTIS POPULER =================
            SectionTitle(title: "Artis Populer"),
            _buildPopularArtists(),

            const SizedBox(height: 20),

            // ================= KONSER UNGGULAN =================
            SectionTitle(title: "Konser Unggulan"),
            _buildFeaturedConcerts(),

            const SizedBox(height: 20),

            // ================= ARTIS SOROTAN =================
            _buildSpotlightArtist(),

            const SizedBox(height: 20),

            // ================= KONSER SOROTAN =================
            _buildSpotlightConcert(),

            const SizedBox(height: 30),

            // ================= FOOTER =================
            const TconFooter(),
          ],
        ),
      ),
    );
  }

  /// Hero section dengan gambar dan CTA button
  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("lib/assets/images/indeg.jpg.jpeg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.4),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Container(
          height: 280,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Temukan & Beli Tiket Konser Favorit Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Nikmati pengalaman tak terlupakan dengan musik live dari artis kesayangan Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/artists');
                },
                child: const Text(
                  "Lihat Konser Mendatang",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Daftar artis populer
  Widget _buildPopularArtists() {
    final artists = [
      ("Juicy Lucy", "juicy.webp"),
      ("Arash Buana", "arash buana.webp"),
      ("Shakira Jasmine", "Shakira.webp"),
      ("Tiara Andini", "tiara andini.png"),
      ("Lyodra", "yodra.webp"),
      ("Maudy Ayunda", "maudy ayunda.webp"),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: artists
            .map(
              (artist) => SizedBox(
                width: 100,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("lib/assets/images/${artist.$2}"),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      artist.$1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  /// Konser unggulan
  Widget _buildFeaturedConcerts() {
    final concerts = [
      (
        "Dewa 19 All Stars 2.0",
        "Dewa19",
        "Stadion Utama GBK, Jakarta",
        "Rp 500.000",
        "konser dewa.webp",
      ),
      (
        "Thanks God It's Festival",
        "Tulus, Nadin Amizah, Raisa, dll.",
        "Stadion Utama GBK, Jakarta",
        "Rp 450.000",
        "KonserThanksGod.jpg",
      ),
      (
        "Coolab Fest",
        "Hindia, Feast, dll.",
        "Jakarta International Stadium",
        "Rp 300.000",
        "KonserCoolab.jpg",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: concerts
            .map(
              (concert) => ConcertCard(
                title: concert.$1,
                artist: concert.$2,
                location: concert.$3,
                price: concert.$4,
                imageUrl: concert.$5,
                onBuyTicket: () {
                  // TODO: Handle ticket purchase
                },
              ),
            )
            .toList(),
      ),
    );
  }

  /// Artis sorotan
  Widget _buildSpotlightArtist() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionTitle(title: "Bintang Sorotan: Tiara Andini"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: cardDecoration(),
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/tiara andini.png",
                  width: 280,
                  height: 280,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Tiara Andini bukan hanya seorang penyanyi, "
                  "dia adalah fenomena musik dengan kemampuan vokal dan storytelling yang kuat.",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Konser sorotan
  Widget _buildSpotlightConcert() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SectionTitle(title: "Pengalaman Konser Wajib Tonton: Coolab Feast"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: cardDecoration(),
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/KonserCoolab.jpg",
                  width: 280,
                  height: 260,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Coolab Feast adalah konser dengan produksi panggung megah, visual sinematik, dan pengalaman emosional tak terlupakan.",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Handle ticket purchase
                  },
                  child: const Text("Pesan Tiket Sekarang"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
