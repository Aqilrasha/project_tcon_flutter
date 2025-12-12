import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class LiveGalleryPage extends StatefulWidget {
  const LiveGalleryPage({super.key});

  @override
  State<LiveGalleryPage> createState() => _LiveGalleryPageState();
}

class _LiveGalleryPageState extends State<LiveGalleryPage> {
  final List<Map<String, dynamic>> moments = [];
  final TextEditingController _descController = TextEditingController();
  String? _selectedImageBase64;
  bool _isLoading = false;
  String? _statusMessage;
  Color? _statusColor;

  @override
  void initState() {
    super.initState();
    _loadMomentsFromMemory();
  }

  void _loadMomentsFromMemory() {
    setState(() {
      moments.sort(
        (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int),
      );
    });
  }

  Future<void> _selectImage() async {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Foto'),
        content: const Text(
          'Untuk demo ini, gunakan gambar sample.\n\nDalam aplikasi sebenarnya, ini akan membuka file picker.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedImageBase64 = _generateSampleBase64Image();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gambar sample dipilih')),
              );
            },
            child: const Text('Gunakan Gambar Sample'),
          ),
        ],
      ),
    );
  }

  String _generateSampleBase64Image() {
    return 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==';
  }

  void _uploadPhotoMoment() {
    final description = _descController.text.trim();

    if (description.isEmpty) {
      _showMessage(
        'Tuliskan deskripsi momen Anda terlebih dahulu!',
        Colors.red,
      );
      return;
    }

    if (_selectedImageBase64 == null) {
      _showMessage('Pilih foto terlebih dahulu!', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final newMoment = {
        'photoBase64': _selectedImageBase64,
        'description': description,
        'userName': 'Pengunjung Konser',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      setState(() {
        moments.add(newMoment);
        moments.sort(
          (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int),
        );
        _descController.clear();
        _selectedImageBase64 = null;
        _isLoading = false;
      });

      _showMessage('Momen berhasil disimpan!', Colors.green);
    });
  }

  void _showMessage(String message, Color color) {
    setState(() {
      _statusMessage = message;
      _statusColor = color;
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _statusMessage = null;
        });
      }
    });
  }

  Widget _buildLatestMomentCard(Map<String, dynamic> moment) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      moment['timestamp'] as int,
    );
    final formattedTime =
        '${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    final initial = (moment['userName'] as String)
        .substring(0, 1)
        .toUpperCase();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo[200],
                    border: Border.all(color: Colors.indigo, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moment['userName'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$formattedTime (Tersimpan Lokal)',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.grey[300],
            child: _buildImageWidget(moment['photoBase64'] as String),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              moment['description'] as String,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> moment) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Colors.black26,
                ),
              ],
            ),
            child: _buildImageWidget(moment['photoBase64'] as String),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withValues(alpha: 0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    moment['description'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String base64String) {
    try {
      return Image.memory(base64Decode(base64String), fit: BoxFit.cover);
    } catch (e) {
      return Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
      );
    }
  }

  String _getMonthName(int month) {
    const months = [
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

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Galeri Momen',
      currentIndex: -1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const Text(
                    'Gallery Momen Konser',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Data tersimpan di perangkat Anda (Local Storage).',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
                border: Border(top: BorderSide(color: Colors.indigo, width: 4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bagikan Momen Anda',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descController,
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Apa yang Anda lihat?',
                      hintText: 'Tuliskan momen tak terlupakan Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _selectImage,
                    icon: const Icon(Icons.image),
                    label: Text(
                      _selectedImageBase64 != null
                          ? 'Gambar Dipilih ✓'
                          : 'Pilih Foto',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _uploadPhotoMoment,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.indigo,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Simpan & Tampilkan Momen',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (_statusMessage != null)
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            _statusColor?.withValues(alpha: 0.1) ?? Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _statusMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _statusColor ?? Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (moments.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Momen Terkini',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: _buildLatestMomentCard(moments[0]),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Belum ada momen yang disimpan. Unggah momen pertama Anda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
            if (moments.length > 1)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Semua Momen Tersimpan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: moments.length - 1,
                      itemBuilder: (context, index) =>
                          _buildPhotoCard(moments[index + 1]),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
