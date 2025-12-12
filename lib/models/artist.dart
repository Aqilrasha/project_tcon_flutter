class Artist {
  final String id;
  final String name;
  final String genre;
  final String imageUrl;
  final String bannerUrl;
  final String about;
  final List<Map<String, String>> concerts;
  final Map<String, String> socialMedia;

  const Artist({
    required this.id,
    required this.name,
    required this.genre,
    required this.imageUrl,
    required this.bannerUrl,
    required this.about,
    required this.concerts,
    required this.socialMedia,
  });
}

// Sample data untuk artis
final List<Artist> artistsList = [
  Artist(
    id: '1',
    name: 'Arash Buana',
    genre: 'Indie Pop | R&B | Singer-Songwriter',
    imageUrl: 'lib/assets/images/arash buana.webp',
    bannerUrl: 'lib/assets/images/indeg.jpg.jpeg',
    about:
        'Arash Buana adalah penyanyi dan penulis lagu muda berbakat asal Indonesia '
        'yang dikenal karena karya-karyanya di genre pop indie dan R&B yang melankolis. '
        'Arash mulai mencuri perhatian publik dengan lagu-lagu viral seperti \'Gaya\' dan '
        '\'If U Could See Me Cryin in My Room\'.',
    concerts: [
      {
        'date': '18 Oct',
        'title': 'Arash Buana Live in Jakarta (Malam Perdana)',
        'venue': 'Istora Senayan, Jakarta',
      },
      {
        'date': '05 Nov',
        'title': 'Festival Musik A - Surabaya',
        'venue': 'Jatim Expo, Surabaya',
      },
    ],
    socialMedia: {
      'Website': 'arashbuana.com',
      'Twitter': '@arash_buana',
      'Instagram': '@arash_buana',
    },
  ),
  Artist(
    id: '2',
    name: 'Shakira Jasmine',
    genre: 'Rock Alternatif',
    imageUrl: 'lib/assets/images/Shakira.webp',
    bannerUrl: 'lib/assets/images/indeg.jpg.jpeg',
    about:
        'Shakira Jasmine adalah gitaris berbakat dengan gaya rock alternatif yang unik.',
    concerts: [
      {
        'date': '20 Oct',
        'title': 'Shakira Rock Night',
        'venue': 'Balai Sarbini, Jakarta',
      },
    ],
    socialMedia: {
      'Website': 'shakirajasmine.com',
      'Instagram': '@shakira_jasmine',
    },
  ),
  Artist(
    id: '3',
    name: 'Tiara Andini',
    genre: 'Acoustic Pop',
    imageUrl: 'lib/assets/images/tiara andini.png',
    bannerUrl: 'lib/assets/images/indeg.jpg.jpeg',
    about:
        'Tiara Andini adalah penyanyi dengan gaya acoustic pop yang menenangkan.',
    concerts: [
      {
        'date': '25 Oct',
        'title': 'Tiara Acoustic Session',
        'venue': 'Hard Rock Cafe, Jakarta',
      },
    ],
    socialMedia: {
      'Instagram': '@tiara_andini',
    },
  ),
  Artist(
    id: '4',
    name: 'Juicy Lucy',
    genre: 'Pop / R&B',
    imageUrl: 'lib/assets/images/juicy.webp',
    bannerUrl: 'lib/assets/images/indeg.jpg.jpeg',
    about: 'Juicy Lucy adalah artis pop R&B dengan energi yang tinggi.',
    concerts: [
      {
        'date': '28 Oct',
        'title': 'Juicy Lucy Live',
        'venue': 'Sportsmall PIK, Jakarta',
      },
    ],
    socialMedia: {
      'Instagram': '@juicylucy',
    },
  ),
  Artist(
    id: '5',
    name: 'Lyodra',
    genre: 'Pop / Dance',
    imageUrl: 'lib/assets/images/yodra.webp',
    bannerUrl: 'lib/assets/images/indeg.jpg.jpeg',
    about: 'Lyodra adalah penyanyi dengan gaya pop dance yang meriah.',
    concerts: [
      {
        'date': '30 Oct',
        'title': 'Lyodra Dance Party',
        'venue': 'Jakarta International Expo, Jakarta',
      },
    ],
    socialMedia: {
      'Instagram': '@lyodra_official',
    },
  ),
];
