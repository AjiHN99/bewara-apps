import 'package:flutter/material.dart';

/// Widget untuk menampilkan dialog tambah berita baru
Future<Map<String, dynamic>?> showAddNewsDialog(BuildContext context) {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final summaryController = TextEditingController();
  final imageController = TextEditingController();

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Tambah Berita'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            // Kategori: bisa multi kategori dengan koma
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Kategori (+ koma)'),
              onSubmitted: (_) {}, // agar keyboard enter tidak menambah baris
            ),
            // Ringkasan: bisa multiline (enter untuk baris baru)
            TextField(
              controller: summaryController,
              decoration: const InputDecoration(labelText: 'Ringkasan'),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 5,
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'URL Gambar (opsional)'),
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
            if (titleController.text.isNotEmpty && categoryController.text.isNotEmpty) {
              // Split kategori dengan koma, trim spasi
              final categories = categoryController.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              Navigator.pop(context, {
                'title': titleController.text,
                'categories': categories, // simpan sebagai list
                'summary': summaryController.text,
                'image': imageController.text,
              });
            }
          },
          child: const Text('Tambah'),
        ),
      ],
    ),
  );
}
