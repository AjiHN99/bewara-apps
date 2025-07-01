import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<Map<String, dynamic>> newsList;
  final void Function(Map<String, dynamic>)? onTapNews;

  const NewsList({
    super.key,
    required this.newsList,
    this.onTapNews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final news = newsList[index];
            return GestureDetector(
              onTap: () => onTapNews?.call(news),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(bottom: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((news['image'] as String).isNotEmpty)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                news['image'],
                                height: 210,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 4,
                                children: (news['categories'] as List<dynamic>? ?? [])
                                    .map<Widget>((cat) => Chip(
                                          label: Text(cat.toString()),
                                          backgroundColor: Colors.blue[50],
                                          labelStyle: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                        ))
                                    .toList(),
                              ),
                              const SizedBox(height: 14),
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: newsList.length,
        ),
      ),
    );
  }
}
