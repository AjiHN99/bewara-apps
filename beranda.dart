import 'package:flutter/material.dart';
import 'news_list.dart';
import 'add_news_dialog.dart';
import 'user_profile.dart';
import 'favorite.dart';
import 'splash_screen.dart';
import 'buka_berita.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final List<Map<String, dynamic>> newsList = [];
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _addNews() async {
    final newNews = await showAddNewsDialog(context);
    if (newNews != null) {
      setState(() {
        newsList.add(newNews);
      });
    }
  }

  Widget _buildSearchBar({double? width, double? height, double radius = 12, double fontSize = 16}) {
    // Komponen search bar reusable
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: TextField(
          onChanged: (query) {
            setState(() {
              _searchQuery = query;
            });
          },
          decoration: InputDecoration(
            hintText: 'Cari berita...',
            prefixIcon: const Icon(Icons.search, size: 18, color: Colors.blueAccent),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            filled: true,
            fillColor: Colors.blue[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            expandedHeight: 140,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
                );
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: const Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final percent = ((constraints.maxHeight - kToolbarHeight) / (140 - kToolbarHeight)).clamp(0.0, 1.0);
                final curvedPercent = Curves.fastOutSlowIn.transform(percent);
                final logoSize = 30 + (77 - 30) * curvedPercent;
                final fontSize = 25 + (55 - 20) * curvedPercent;
                const double arrowBackWidth = 55.0;
                final double startLeft = MediaQuery.of(context).size.width / 2 - 135;
                final double endLeft = arrowBackWidth;
                final double animatedLeft = startLeft + (endLeft - startLeft) * (1 - curvedPercent);
                final double startTop = 40;
                final double endTop = 12;
                final double animatedTop = startTop + (endTop - startTop) * (1 - curvedPercent);
                return Stack(
                  children: [
                    // Logo + Tulisan Bewara
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.fastOutSlowIn,
                      left: animatedLeft,
                      top: animatedTop,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.fastOutSlowIn,
                            height: logoSize,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const SizedBox(width: 12),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.fastOutSlowIn,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            child: const Text('Be'),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.fastOutSlowIn,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            child: const Text('wara'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (newsList.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Selamat datang di aplikasi Bewara!\n\nBelum ada berita.\nSilakan tambahkan berita dengan menekan tombol + di kanan bawah.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 30,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
          else ...[
            // List Berita + Search Bar dalam satu baris (sejajar)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.list_alt, color: Colors.blueAccent, size: 25),
                    const SizedBox(width: 8),
                    Text(
                      'List Berita',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            color: Colors.blueAccent.withOpacity(0.10),
                            blurRadius: 6,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Tampilkan search bar selalu di bawah judul List Berita
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: _buildSearchBar(width: double.infinity, height: 40, radius: 12, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // List berita
            NewsList(
              newsList: _searchQuery.isEmpty
                  ? newsList
                  : newsList.where((news) {
                      final title = (news['title'] ?? '').toString().toLowerCase();
                      final summary = (news['summary'] ?? '').toString().toLowerCase();
                      final query = _searchQuery.toLowerCase();
                      return title.contains(query) || summary.contains(query);
                    }).toList(),
              onTapNews: (news) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setStateModal) {
                      final int newsIndex = newsList.indexOf(news);
                      bool isFavorite = news['isFavorite'] == true;
                      return BukaBerita(
                        news: news,
                        newsIndex: newsIndex,
                        isFavorite: isFavorite,
                        onToggleFavorite: () {
                          setState(() {
                            newsList[newsIndex]['isFavorite'] = !isFavorite;
                          });
                          setStateModal(() {});
                        },
                        onDelete: () {
                          Navigator.pop(context);
                          setState(() {
                            newsList.removeAt(newsIndex);
                          });
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'favBtn',
            backgroundColor: Colors.yellow[700],
            tooltip: 'Berita Favorit',
            child: const Icon(Icons.star, color: Colors.white),
            onPressed: () {
              final favoriteNews = newsList.where((n) => n['isFavorite'] == true).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteNewsScreen(
                    favoriteNews: favoriteNews,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'addBtn',
            onPressed: _addNews,
            backgroundColor: Colors.blue,
            tooltip: 'Tambah Berita',
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
