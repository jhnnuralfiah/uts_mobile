import 'package:flutter/material.dart';
import '../theme.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // data berita statis 
    final List<_NewsItem> news = const [
      _NewsItem(
        title: 'Rangkuman Gempa Terkini dari BMKG',
        category: 'BMKG • Info Gempa',
        time: '5 menit lalu',
        snippet:
            'BMKG merilis informasi gempa terkini beserta lokasi, magnitudo, dan potensi dampaknya. Pastikan selalu waspada dan ikuti arahan resmi.',
        accentColor: AppColors.primary,
      ),
      _NewsItem(
        title: 'Cuaca Cerah Berawan, Cocok untuk Aktivitas Luar',
        category: 'Info Cuaca',
        time: '30 menit lalu',
        snippet:
            'Sejumlah wilayah Jawa Barat diprediksi cerah berawan sepanjang hari. Suhu udara masih terasa sejuk di pagi dan malam hari.',
        accentColor: AppColors.pink,
      ),
      _NewsItem(
        title: 'Tips Siaga Bencana untuk Mahasiswa Rantau',
        category: 'Panduan',
        time: '1 jam lalu',
        snippet:
            'Mulai dari menyiapkan tas darurat, menyimpan nomor penting, hingga memperhatikan struktur bangunan tempat tinggal.',
        accentColor: AppColors.yellow,
      ),
      _NewsItem(
        title: 'Kegiatan Kampus: Simulasi Kebencanaan Mingguan',
        category: 'Kegiatan Kampus',
        time: '2 jam lalu',
        snippet:
            'Beberapa kampus mulai rutin mengadakan simulasi tanggap bencana demi meningkatkan kesiapsiagaan sivitas akademika.',
        accentColor: AppColors.primary,
      ),
      _NewsItem(
        title: 'BMKG Imbau Warga Tidak Panik Terkait Isu Hoaks Gempa',
        category: 'BMKG • Klarifikasi',
        time: '3 jam lalu',
        snippet:
            'BMKG menegaskan bahwa informasi gempa berantai yang beredar di media sosial adalah tidak benar dan meminta masyarakat menyaring informasi.',
        accentColor: AppColors.pink,
      ),
      _NewsItem(
        title: 'Curah Hujan Meningkat, Waspadai Potensi Banjir Lokal',
        category: 'Info Cuaca',
        time: '4 jam lalu',
        snippet:
            'Beberapa daerah dataran rendah diminta waspada karena curah hujan diprediksi meningkat dalam beberapa hari ke depan.',
        accentColor: AppColors.yellow,
      ),
      _NewsItem(
        title: 'Edukasi Mitigasi Bencana Melalui Webinar Nasional',
        category: 'Edukasi',
        time: 'Kemarin',
        snippet:
            'Webinar menghadirkan narasumber dari BNPB, BMKG, dan akademisi untuk membahas langkah-langkah mitigasi bencana sejak dini.',
        accentColor: AppColors.primary,
      ),
      _NewsItem(
        title: 'Aplikasi Info Cuaca dan Gempa untuk Mahasiswa',
        category: 'Teknologi',
        time: 'Kemarin',
        snippet:
            'Berbagai aplikasi hadir untuk memudahkan mahasiswa memantau cuaca, gempa, dan peringatan dini langsung dari smartphone.',
        accentColor: AppColors.pink,
      ),
      _NewsItem(
        title: 'Simulasi Evakuasi Gempa di Lingkungan Kos Mahasiswa',
        category: 'Lingkungan',
        time: '2 hari lalu',
        snippet:
            'Pengelola kos mulai mengadakan simulasi evakuasi sebagai bentuk kepedulian terhadap keselamatan penghuni.',
        accentColor: AppColors.yellow,
      ),
      _NewsItem(
        title: 'Tips Menjaga Kesehatan di Musim Hujan',
        category: 'Kesehatan',
        time: '3 hari lalu',
        snippet:
            'Konsumsi vitamin, cukup istirahat, dan selalu membawa payung atau jas hujan saat beraktivitas di luar rumah.',
        accentColor: AppColors.primary,
      ),
    ];

    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu header / highlight berita
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // teks highlight
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Berita hari ini',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Pantau info gempa & cuaca\nlangsung dari satu tempat.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // icon besar
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.article_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Berita untuk kamu',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.85),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            // daftar berita
            Column(
              children: news
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _NewsCard(item: item),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== MODEL BERITA ======
class _NewsItem {
  final String title;
  final String category;
  final String time;
  final String snippet;
  final Color accentColor;

  const _NewsItem({
    required this.title,
    required this.category,
    required this.time,
    required this.snippet,
    required this.accentColor,
  });
}

// ====== WIDGET KARTU BERITA ======

class _NewsCard extends StatelessWidget {
  final _NewsItem item;

  const _NewsCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: item.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.article_outlined,
              color: item.accentColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          // teks berita
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.9),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.snippet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.time,
                      style: TextStyle(
                        color: Colors.grey.withValues(alpha: 0.9),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
