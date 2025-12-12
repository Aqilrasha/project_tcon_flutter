import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class HomeFromHtmlPage extends StatefulWidget {
  const HomeFromHtmlPage({super.key});

  @override
  State<HomeFromHtmlPage> createState() => _HomeFromHtmlPageState();
}

class _HomeFromHtmlPageState extends State<HomeFromHtmlPage> {
  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Tcon',
      currentIndex: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HERO
            _buildHero(context),
            const SizedBox(height: 20),

            // ARTIS POPULER
            const Text(
              'Artis Populer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildArtistsGrid(),
            const SizedBox(height: 20),

            // KONSER UNGGULAN
            const Text(
              'Konser Unggulan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeaturedConcerts(),
            const SizedBox(height: 20),

            // BINTANG SOROTAN
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Bintang Sorotan: Tiara Andini',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'lib/assets/images/tiara andini.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Tiara Andini bukan hanya seorang penyanyi, dia adalah fenomena musik dengan kemampuan vokal dan storytelling yang kuat.',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Pencapaian penting',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // KONSER SOROTAN
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pengalaman Konser Wajib Tonton: Coolab Feast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'lib/assets/images/KonserCoolab.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Coolab Feast adalah konser dengan produksi panggung megah, visual sinematik, dan pengalaman emosional tak terlupakan.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Pesan Tiket Sekarang'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Center(child: Text('© 2024 Tcon. All Rights Reserved.')),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('lib/assets/images/indeg.jpg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.35)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Temukan & Beli Tiket Konser Favorit Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nikmati pengalaman tak terlupakan dengan musik live dari artis kesayangan Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      child: Text('Lihat Konser Mendatang'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistsGrid() {
    final artists = [
      ['Juicy Lucy', 'lib/assets/images/juicy.webp'],
      ['Arash Buana', 'lib/assets/images/arash buana.webp'],
      ['Shakira Jasmine', 'lib/assets/images/Shakira.webp'],
      ['Tiara Andini', 'lib/assets/images/tiara andini.png'],
      ['Lyodra', 'lib/assets/images/yodra.webp'],
      ['Maudy Ayunda', 'lib/assets/images/maudy ayunda.webp'],
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final a = artists[index];
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  a[1],
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(a[0], textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeaturedConcerts() {
    final concerts = [
      [
        'Dewa 19 All Stars 2.0',
        'Dewa19',
        'Stadion Utama GBK, Jakarta',
        'Rp 500.000',
        'lib/assets/images/konser dewa.webp',
      ],
      [
        'Thanks God It\'s Festival',
        'Tulus, Nadin Amizah, Raisa, dll.',
        'Stadion Utama GBK, Jakarta',
        'Rp 450.000',
        'lib/assets/images/KonserThanksGod.jpg',
      ],
      [
        'Coolab Fest',
        'Hindia, Feast, dll.',
        'Jakarta International Stadium',
        'Rp 300.000',
        'lib/assets/images/KonserCoolab.jpg',
      ],
    ];

    return Column(
      children: concerts.map((c) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: Image.asset(
                    c[4],
                    width: 140,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c[0],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c[1],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c[3],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 57, 94),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
