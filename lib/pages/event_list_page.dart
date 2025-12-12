import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_detail_name.dart';
import '../widgets/tcon_scaffold.dart';

class EventListPage extends StatelessWidget {
  final List<Event> events;

  EventListPage({super.key})
    : events = [
        Event(
          id: '1',
          title: 'YOMANFESTTIVAL',
          artist: 'SLANK',
          description: 'SLANKERSSSS......',
          date: DateTime(2025, 12, 16),
          location: 'JOGJA',
          venue: 'Lokasi detail event',
          openGateTime: '18:00 WIB',
          showStartTime: '20:00 WIB',
          minPrice: 10000000,
          imageUrl:
              'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600&h-400&fit=crop',
          galleryImages: [
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600&h=400&fit=crop',
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600&h=400&fit=crop',
            'https://images.unsplash.com/photo-1501281668745-f6f2616ba4a1?w=600&h=400&fit=crop',
          ],
          specialNote:
              'Pastikan Anda tiba tepat waktu untuk menghindari antrian panjang.',
        ),
        Event(
          id: '2',
          title: 'PUNKY',
          artist: 'Various Artists',
          description: 'Konser punk terbesar tahun ini!',
          date: DateTime(2025, 12, 16),
          location: 'BOJONG MENTENG',
          venue: 'Venue utama',
          openGateTime: '17:00 WIB',
          showStartTime: '19:00 WIB',
          minPrice: 1000000000,
          imageUrl:
              'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600&h=400&fit=crop',
          galleryImages: [
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600&h=400&fit=crop',
            'https://images.unsplash.com/photo-1501281668745-f6f2616ba4a1?w=600&h=400&fit=crop',
            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600&h=400&fit=crop',
          ],
        ),
        Event(
          id: '3',
          title: 'INDIE JAM',
          artist: 'The Upstairs',
          description: 'Konser indie showcase 2025',
          date: DateTime(2025, 12, 20),
          location: 'JAKARTA',
          venue: 'Jakarta Convention Center',
          openGateTime: '16:00 WIB',
          showStartTime: '18:00 WIB',
          minPrice: 750000,
          imageUrl:
              'https://images.unsplash.com/photo-1501281668745-f6f2616ba4a1?w=600&h=400&fit=crop',
          galleryImages: [
            'https://images.unsplash.com/photo-1501281668745-f6f2616ba4a1?w=600&h=400&fit=crop',
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Konser',
      currentIndex: 3,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upcoming Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${events.length} events tersedia',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          // Event List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _buildEventCard(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailPage(event: event),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            SizedBox(
              height: 180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),

            // Event Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Date Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event.date.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_getMonthAbbreviation(event.date.month)} ${event.date.year}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Event Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'by ${event.artist}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event.location,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.formattedPrice,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetailPage(event: event),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Detail & Beli',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur gallery akan segera hadir!',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Lihat Gallery',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
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
