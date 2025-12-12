import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _profileImage;
  String _selectedDOB = '';
  String _statusMessage = '';
  Color _statusColor = Colors.green;
  bool _showStatus = false;

  // Simulated user data
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    userData = {
      'name': 'Aqila Rasha',
      'email': 'aqilarasha2@gmail.com',
      'phone': '08123456789',
      'dob': '15/08/2000',
      'bio': 'Penggemar musik dan konser lokal',
      'isLoggedIn': true,
      'password': 'tcondefaultpassword',
    };
    _loadUserProfile();
  }

  void _loadUserProfile() {
    _nameController.text = userData['name'] ?? '';
    _phoneController.text = userData['phone'] ?? '';
    _bioController.text = userData['bio'] ?? '';
    _selectedDOB = userData['dob'] ?? '';
  }

  void _displayStatus(String message, bool isSuccess) {
    setState(() {
      _statusMessage = message;
      _statusColor = isSuccess ? Colors.green : Colors.red;
      _showStatus = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showStatus = false;
        });
      }
    });
  }

  void _handleSaveProfile() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _displayStatus('Nama Lengkap harus diisi.', false);
      return;
    }

    setState(() {
      userData['name'] = name;
      userData['phone'] = _phoneController.text.trim();
      userData['dob'] = _selectedDOB;
      userData['bio'] = _bioController.text.trim();
    });

    _displayStatus('Perubahan profil berhasil disimpan!', true);
  }

  void _handleLogout() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                userData['isLoggedIn'] = false;
              });
              _displayStatus('Anda berhasil keluar dari akun.', true);
              Future.delayed(const Duration(milliseconds: 800), () {
                if (mounted) {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              });
            },
            child: const Text('Ya, Keluar'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Kata Sandi'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi Lama',
                  hintText: 'Masukkan kata sandi lama Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi Baru',
                  hintText: 'Minimal 8 karakter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Kata Sandi Baru',
                  hintText: 'Ulangi kata sandi baru Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final oldPass = _oldPasswordController.text;
              final newPass = _newPasswordController.text;
              final confirmPass = _confirmPasswordController.text;

              if (oldPass != userData['password']) {
                _displayStatus('Kata sandi lama tidak sesuai.', false);
                return;
              }
              if (newPass != confirmPass) {
                _displayStatus('Konfirmasi kata sandi tidak cocok.', false);
                return;
              }
              if (newPass == oldPass) {
                _displayStatus(
                  'Kata sandi baru tidak boleh sama dengan yang lama.',
                  false,
                );
                return;
              }
              if (newPass.length < 8) {
                _displayStatus(
                  'Kata sandi baru harus minimal 8 karakter.',
                  false,
                );
                return;
              }

              setState(() {
                userData['password'] = newPass;
              });

              Navigator.pop(context);
              _displayStatus('Kata sandi Anda telah diperbarui.', true);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstName = userData['name'].toString().trim().isNotEmpty
        ? userData['name'].toString().split(' ')[0]
        : 'Pengguna';

    return TconScaffold(
      title: 'Profil',
      currentIndex: 4,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.indigo, width: 4),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImage == null
                        ? GestureDetector(
                            onTap: () => _showImageSourceDialog(),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Unggah Foto',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _showImageSourceDialog(),
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.3),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Halo, $firstName Tcon!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kelola data pribadi dan preferensi akun Anda di sini.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Personal Information Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Dasar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            hintText: 'Masukkan nama lengkap Anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue:
                              userData['email'] ?? 'user.default@tcon.id',
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Alamat Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Email tidak dapat diubah.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Telepon',
                            hintText: 'Contoh: 08123456789',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _selectDate(),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tanggal Lahir',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      _selectedDOB.isEmpty
                                          ? 'Pilih tanggal lahir'
                                          : _selectedDOB,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.indigo,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _bioController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Bio Singkat',
                            hintText: 'Ceritakan sedikit tentang diri Anda...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        if (_showStatus)
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _statusMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSaveProfile,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.indigo,
                            ),
                            child: const Text(
                              'Simpan Informasi Profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Account Settings Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pengaturan Akun',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Keamanan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: _showChangePasswordDialog,
                                  icon: const Icon(
                                    Icons.lock,
                                    color: Colors.indigo,
                                  ),
                                  label: const Text(
                                    'Ubah Kata Sandi',
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Lindungi akun Anda dengan mengganti kata sandi secara berkala.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleLogout,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.red,
                            ),
                            child: const Text(
                              'Keluar (Logout)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Sumber Foto'),
        content: const Text('Demo: Anda dapat mengganti foto profil di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _displayStatus('Fitur kamera akan segera tersedia.', true);
            },
            child: const Text('Kamera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _displayStatus('Fitur galeri akan segera tersedia.', true);
            },
            child: const Text('Galeri'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDOB = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }
}
