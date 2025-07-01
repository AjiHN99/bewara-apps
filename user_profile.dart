import 'package:flutter/material.dart';
import 'datauser.dart';
import 'splash_screen.dart';

/// Halaman Profile User
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, this.username, this.email, this.role});

  final String? username;
  final String? email;
  final String? role;

  // Fungsi untuk edit profil
  Future<void> _editProfile(
    BuildContext context,
    String userName,
    String userEmail,
    String userRole,
  ) async {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: userEmail);
    String selectedRole = userRole == 'Reporter' || userRole == 'Visitor'
        ? userRole
        : (userRole.isNotEmpty ? 'Lainnya' : 'Reporter');
    String initialCustomRole = userRole != 'Reporter' && userRole != 'Visitor' && userRole.isNotEmpty ? userRole : '';
    final customRoleController = TextEditingController(text: initialCustomRole);

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Profil'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nama'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Role',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Reporter'),
                          value: 'Reporter',
                          groupValue: selectedRole,
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value!;
                              customRoleController.clear();
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Visitor'),
                          value: 'Visitor',
                          groupValue: selectedRole,
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value!;
                              customRoleController.clear();
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Lainnya'),
                          value: 'Lainnya',
                          groupValue: selectedRole,
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value!;
                            });
                          },
                        ),
                        if (selectedRole == 'Lainnya')
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: customRoleController,
                              decoration: const InputDecoration(
                                labelText: 'Masukkan peran lain',
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Text(
                          'Peran yang dipilih: '
                          '${selectedRole == 'Lainnya' ? (customRoleController.text.isNotEmpty ? customRoleController.text : 'Lainnya') : selectedRole}',
                        ),
                      ],
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
                    final roleToSave = selectedRole == 'Lainnya'
                        ? customRoleController.text
                        : selectedRole;
                    Navigator.pop(context, {
                      'username': nameController.text,
                      'email': emailController.text,
                      'role': roleToSave,
                    });
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      await UserPrefs.saveUser(
        username: result['username'] ?? userName,
        email: result['email'] ?? userEmail,
        role: result['role'] ?? userRole,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: UserPrefs.getUser(),
        builder: (context, snapshot) {
          final user = snapshot.data ?? {};
          final userName = (user['username'] != null && user['username']!.isNotEmpty) ? user['username']! : 'User';
          final userEmail = (user['email'] != null && user['email']!.isNotEmpty) ? user['email']! : 'user@email.com';
          final userRole = (user['role'] != null && user['role']!.isNotEmpty) ? user['role']! : 'Kosong';

          return Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFe3f0ff), Color(0xFFf8fbff)],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0),
                    // Card profil utama
                    Container(
                      margin: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Logo dan nama aplikasi
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/logo.png', height: 54),
                              const SizedBox(width: 10),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Be',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'wara',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          // Avatar dengan border gradient
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.blue[200]!, Colors.blue[50]!],
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, size: 60, color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(userRole),
                            backgroundColor: Colors.blue[50],
                            labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Card aksi
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.06),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Tombol edit profil
                              ElevatedButton.icon(
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit Profil'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[50],
                                  foregroundColor: Colors.blueAccent,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => _editProfile(context, userName, userEmail, userRole),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          // Tombol lain-lain
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Tombol tentang aplikasi
                              TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (context) => SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/logo.png', height: 60),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Tentang Bewara',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF3F7FB),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: const Text(
                                                'Bewara adalah aplikasi berita modern yang memudahkan Anda untuk berbagi, membaca, dan mengelola informasi secara cepat dan aman.\n\nDirancang dengan antarmuka yang ramah pengguna, Bewara mendukung peran Reporter, Visitor, dan peran kustom lain sesuai kebutuhan komunitas Anda.\n\nFitur utama:\n• Tambah & kelola berita dengan mudah\n• Favoritkan berita penting\n• Edit profil dan peran\n• Tampilan profesional dan responsif\n\nBewara hadir untuk mendorong budaya berbagi informasi positif dan inspiratif di era digital.\n\nVersi: 1.0.0\n© 2025 Bewara Team',
                                                style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.6),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 18),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.verified, color: Colors.blueAccent, size: 20),
                                                SizedBox(width: 6),
                                                Text('Aplikasi ini aman & bebas iklan', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                            const SizedBox(height: 18),
                                            SizedBox(
                                              width: 120,
                                              child: ElevatedButton.icon(
                                                icon: Icon(Icons.close),
                                                label: Text('Tutup'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue[50],
                                                  foregroundColor: Colors.blueAccent,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    );
                                },
                                icon: const Icon(Icons.info_outline, color: Colors.black),
                                label: const Text(
                                  'Tentang Aplikasi',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Tombol logout
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                                    (route) => false,
                                  );
                                },
                                icon: const Icon(Icons.logout, color: Colors.redAccent),
                                label: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Motivasi/Quote
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Card(
                        color: Colors.blue[50],
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                          child: Column(
                            children: [
                              const Text(
                                '“Jadilah pembawa berita yang positif dan inspiratif!”',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.emoji_emotions, color: Colors.amber, size: 20),
                                  SizedBox(width: 4),
                                  Text('Semangat Berbagi!', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
