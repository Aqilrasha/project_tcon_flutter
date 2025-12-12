class Event {
  final String id;
  final String title;
  final String artist;
  final String description;
  final DateTime date;
  final String location;
  final String venue;
  final String openGateTime;
  final String showStartTime;
  final int minPrice;
  final List<String> galleryImages;
  final String? specialNote;
  final String imageUrl; // Tambahkan field untuk gambar utama

  Event({
    required this.id,
    required this.title,
    required this.artist,
    required this.description,
    required this.date,
    required this.location,
    required this.venue,
    required this.openGateTime,
    required this.showStartTime,
    required this.minPrice,
    required this.imageUrl, // Tambahkan required parameter
    this.galleryImages = const [],
    this.specialNote,
  });

  String get formattedDate {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String get timeInfo {
    return 'Pintu Buka: $openGateTime | Pertunjukan Mulai: $showStartTime';
  }

  String get formattedPrice {
    if (minPrice >= 1000000) {
      return 'Rp ${(minPrice / 1000000).toStringAsFixed(0)}.000.000';
    }
    return 'Rp ${minPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  String _getMonthName(int month) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
