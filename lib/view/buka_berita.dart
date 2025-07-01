import 'package:flutter/material.dart';

class BukaBerita extends StatelessWidget {
  final Map<String, dynamic> news;
  final int newsIndex;
  final bool isFavorite;
  final Function()? onToggleFavorite;
  final Function()? onDelete;

  const BukaBerita({
    super.key,
    required this.news,
    required this.newsIndex,
    required this.isFavorite,
    this.onToggleFavorite,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 90),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((news['image'] as String).isNotEmpty)
                  // Pengaturan ukuran gambar sama persis dengan NewsList
                  ClipRRect(
                    
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // Rasio profesional landscape
                      child: Image.network(
                        news['image'],
                        height: 210, // Tinggi profesional
                        width: double.infinity,
                        fit: BoxFit.cover, // Gambar akan crop agar proporsional
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (news['categories'] != null && (news['categories'] as List).isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: (news['categories'] as List<dynamic>)
                        .map<Widget>((cat) => Chip(
                              label: Text(cat.toString()),
                              backgroundColor: Colors.blue[50],
                              labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 12),
                Text(
                  news['title'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  news['summary'],
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 24,
          bottom: 24,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[100],
                  foregroundColor: isFavorite ? Colors.orange : Colors.grey[600],
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black12,
                ),
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  size: 22,
                  color: isFavorite ? Colors.orange : Colors.grey[600],
                ),
                label: Text(
                  isFavorite ? 'Favorit' : 'Favorit',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              if (onDelete != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.redAccent,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.black12,
                  ),
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 22),
                  label: const Text('Hapus', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.redAccent,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black12,
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 22),
                label: const Text('Tutup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
