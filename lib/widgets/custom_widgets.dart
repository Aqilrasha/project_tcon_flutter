import 'package:flutter/material.dart';

/// Widget untuk header/navbar aplikasi
class TconAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showNavItems;
  final List<String> navItems;

  const TconAppBar({
    super.key,
    this.showNavItems = false,
    this.navItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Tcon
          Text(
            "Tcon",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Colors.red, Colors.indigo],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),

          // Menu (hanya jika showNavItems true)
          if (showNavItems)
            Row(
              children: navItems.map((item) => _navItem(item)).toList(),
            )
          else
            const SizedBox.shrink(),

          // Icon Profil
          const Icon(Icons.account_circle_rounded,
              size: 40, color: Colors.indigo),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

/// Widget untuk card artis
class ArtistCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String genre;
  final VoidCallback? onTap;

  const ArtistCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.genre,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isNetwork = imageUrl.startsWith("http");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 4,
                    color: Colors.indigo.shade300,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: isNetwork
                        ? NetworkImage(imageUrl)
                        : AssetImage("lib/$imageUrl") as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Name
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Genre
              Text(
                genre,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget untuk card konser
class ConcertCard extends StatelessWidget {
  final String title;
  final String artist;
  final String location;
  final String price;
  final String imageUrl;
  final VoidCallback? onBuyTicket;

  const ConcertCard({
    super.key,
    required this.title,
    required this.artist,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.onBuyTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "lib/$imageUrl",
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artist,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk item jadwal konser di detail artis
class ConcertScheduleItem extends StatelessWidget {
  final String day;
  final String month;
  final String title;
  final String location;
  final VoidCallback? onBuyTicket;

  const ConcertScheduleItem({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.location,
    this.onBuyTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Date box
          Container(
            width: 55,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  month.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Concert details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Buy ticket button
          ElevatedButton(
            onPressed: onBuyTicket,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Beli Tiket"),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk social media item
class SocialMediaItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback? onTap;

  const SocialMediaItem({
    super.key,
    required this.icon,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8f8f8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.indigo),
            const SizedBox(width: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk section title
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Helper function untuk card decoration
BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

/// Widget footer
class TconFooter extends StatelessWidget {
  final String? text;

  const TconFooter({
    super.key,
    this.text = "© 2024 Tcon. All Rights Reserved.",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[900],
      width: double.infinity,
      child: Center(
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
