import 'package:flutter/material.dart';
import 'datauser.dart';

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
      ),
      body: FutureBuilder<Map<String, String>>(
        future: UserPrefs.getUser(),
        builder: (context, snapshot) {
          final user = snapshot.data ?? {};
          final userName = (user['username'] != null && user['username']!.isNotEmpty) ? user['username']! : 'User';
          final userEmail = (user['email'] != null && user['email']!.isNotEmpty) ? user['email']! : 'user@email.com';
          final userRole = (user['role'] != null && user['role']!.isNotEmpty) ? user['role']! : 'Kosong';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 14),
                // Logo aplikasi di atas avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: 70),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Be',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'wara',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 8),
                Chip(
                  label: Text(userRole),
                  backgroundColor: Colors.blue[50],
                  labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 36),
                // Edit Profile & Lain-lain
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol edit profil
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profil'),
                      onPressed: () => _editProfile(context, userName, userEmail, userRole),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement change password
                      },
                      icon: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                      label: const Text('Ubah Password'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        side: const BorderSide(color: Colors.blueAccent),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: () {
                    // TODO: Implement other actions
                  },
                  child: const Text(
                    'Lainnya',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
