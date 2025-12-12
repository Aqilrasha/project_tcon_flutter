import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/tcon_scaffold.dart';

class ArtistDetailPage extends StatelessWidget {
  const ArtistDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TconScaffold(
      title: 'Artis',
      currentIndex: 1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildArtistBanner(),

            Padding(
              padding: const EdgeInsets.all(20),

              // ========================= RESPONSIVE LAYOUT =========================
              child: screenWidth < 750
                  ? Column(
                      children: [
                        _buildAboutSection(),
                        const SizedBox(height: 30),
                        _buildConcertScheduleSection(),
                        const SizedBox(height: 30),
                        _buildSocialMediaSection(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildAboutSection(),
                              const SizedBox(height: 30),
                              _buildConcertScheduleSection(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(flex: 1, child: _buildSocialMediaSection()),
                      ],
                    ),
            ),

            const SizedBox(height: 40),
            const TconFooter(),
          ],
        ),
      ),
    );
  }

  // ======================== ARTIST BANNER ========================
  Widget _buildArtistBanner() {
    return Stack(
      children: [
        // BACKGROUND IMAGE (FIXED)
        Container(
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/indeg.jpg.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // GRADIENT
        Container(
          height: 400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.6),
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),

        // PROFILE & NAME
        Positioned(
          bottom: 30,
          left: 20,
          child: Row(
            children: [
              // PROFILE IMAGE (FIXED)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
                  image: const DecorationImage(
                    image: AssetImage("lib/assets/images/arash buana.webp"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Arash Buana",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Indie Pop | R&B | Singer-Songwriter",
                    style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
                  ),
                  const SizedBox(height: 14),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Ikuti (+3.5M Fans)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ======================== ABOUT SECTION ========================
  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _sectionDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tentang Arash Buana",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 14),
          Text(
            "Arash Buana adalah penyanyi dan penulis lagu muda berbakat asal Indonesia "
            "yang dikenal karena karya-karyanya di genre pop indie dan R&B yang melankolis.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            "Genre: Indie Pop, R&B, Soul.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ======================== CONCERT SECTION ========================
  Widget _buildConcertScheduleSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _sectionDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Jadwal Konser Mendatang",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          ConcertScheduleItem(
            day: "18",
            month: "Okt",
            title: "Arash Buana Live in Jakarta (Malam Perdana)",
            location: "Istora Senayan, Jakarta",
            onBuyTicket: () {},
          ),
          ConcertScheduleItem(
            day: "05",
            month: "Nov",
            title: "Festival Musik A - Surabaya",
            location: "Jatim Expo, Surabaya",
            onBuyTicket: () {},
          ),
        ],
      ),
    );
  }

  // ======================== SOCIAL MEDIA SECTION ========================
  Widget _buildSocialMediaSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _sectionDecoration(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sosial Media",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),

          SocialMediaItem(icon: Icons.language, name: "Official Website"),
          SocialMediaItem(
            icon: Icons.alternate_email_rounded,
            name: "Twitter (@arash_buana)",
          ),
          SocialMediaItem(
            icon: Icons.camera_alt_outlined,
            name: "Instagram (@arash_buana)",
          ),
        ],
      ),
    );
  }

  // ======================== DECORATION REUSABLE ========================
  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withValues(alpha: 0.05),
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
