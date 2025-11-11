import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import 'biodata.dart';
import 'kontak.dart';
import 'kalkulator.dart';
import 'cuaca.dart';
import 'berita.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // halaman utama
  final List<Widget> _pages = const [
    HomeDashboardPage(),
    BiodataPage(),
    KontakPage(),
    KalculatorPage(),
    CuacaPage(),
    BeritaPage(),
  ];

  // judul appbar
  final List<String> _titles = [
    'My Daily Hub',
    'Biodata',
    'Kontak',
    'Kalkulator',
    'Cuaca',
    'Berita',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: GoogleFonts.fredoka(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          selectedLabelStyle: GoogleFonts.fredoka(fontSize: 11),
          unselectedLabelStyle: GoogleFonts.fredoka(fontSize: 11),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Biodata',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: 'Kontak',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Kalkulator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Cuaca',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Berita',
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HOME DASHBOARD =================
class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hai, Jihan 👋',
            style: GoogleFonts.fredoka(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Selamat datang di pusat aktivitasmu.',
            style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          // === Profil Singkat ===
          _BigCard(
            title: 'Profil Singkat',
            icon: Icons.person,
            colors: const [AppColors.primary, AppColors.yellow],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _AlignedText(label: 'Nama',  value: 'Jihan Nur Alfiah'),
                _AlignedText(label: 'NIM',   value: '15-2024-215'),
                _AlignedText(label: 'Kelas', value: 'IFB-355 (BB)'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // === Kontak Utama ===
          _BigCard(
            title: 'Kontak Utama',
            icon: Icons.phone,
            colors: const [AppColors.pink, AppColors.primary],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _AlignedText(label: 'HP',    value: '0838-1234-5678'),
                _AlignedText(label: 'Email', value: 'jihan@example.com'),
                _AlignedText(label: 'IG',    value: '@jihan_nur_alfiah'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // === Dua kartu kecil ===
          Row(
            children: const [
              Expanded(
                child: _SmallCard(
                  title: 'Kalkulator',
                  icon: Icons.calculate,
                  colors: [AppColors.yellow, AppColors.primary],
                  description: 'Hitung cepat tugas atau keperluan harianmu.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SmallCard(
                  title: 'Cuaca',
                  icon: Icons.cloud,
                  colors: [AppColors.primary, AppColors.pink],
                  description: 'Cek cuaca sebelum berangkat aktivitas.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // === Berita Terbaru ===
          _BigCard(
            title: 'Berita Terbaru',
            icon: Icons.article,
            colors: const [AppColors.pink, AppColors.yellow],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BMKG: Gempa berkekuatan 5.3 SR terjadi di selatan Jawa Barat.',
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cuaca cerah berawan di Bandung dan sekitarnya hari ini.',
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tips aman menghadapi musim hujan: siapkan jas hujan & payung.',
                  style: GoogleFonts.fredoka(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================== WIDGET KARTU BESAR ==================
class _BigCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> colors;
  final Widget child;

  const _BigCard({
    required this.title,
    required this.icon,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.fredoka(
          color: Colors.white,
          fontSize: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

// ================== WIDGET KARTU KECIL ==================
class _SmallCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> colors;
  final String description;

  const _SmallCard({
    required this.title,
    required this.icon,
    required this.colors,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.fredoka(
          color: Colors.white,
          fontSize: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ================== WIDGET TITIK DUA SEJAJAR SEMPURNA ==================
class _AlignedText extends StatelessWidget {
  final String label;
  final String value;
  const _AlignedText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.fredoka(
      color: Colors.white,
      fontSize: 14,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label (Nama, NIM, Kelas, dll)
          SizedBox(
            width: 65, 
            child: Text(
              label,
              style: textStyle,
            ),
          ),
          // titik dua sejajar
          Text(
            ':',
            style: textStyle,
          ),
          const SizedBox(width: 6),
          // nilai di kanan
          Expanded(
            child: Text(
              value,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
