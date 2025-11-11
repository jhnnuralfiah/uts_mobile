// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  String? _selectedGender = 'Perempuan';
  String _selectedProdi = 'Informatika';
  DateTime? _selectedDate;

  final TextEditingController _nameController =
      TextEditingController(text: 'Jihan Nur Alfiah');
  final TextEditingController _nimController =
      TextEditingController(text: '15-2024-215');
  final TextEditingController _classController =
      TextEditingController(text: 'IFB-355 (BB)');
  final TextEditingController _campusController =
      TextEditingController(text: 'Institut Teknologi Nasional Bandung');
  final TextEditingController _hobbyController =
      TextEditingController(text: 'Menonton Drama Korea, Membaca Novel');

  // untuk ambil foto profil
  final ImagePicker _picker = ImagePicker();
  Uint8List? _profileImageBytes;

  Future<void> _pickProfileImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _profileImageBytes = bytes;
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 1, 1),
      firstDate: DateTime(1990),
      lastDate: now,
      helpText: 'Pilih Tanggal Lahir',
    );

    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    }
  }

  String get _formattedDate {
    if (_selectedDate == null) return 'Belum dipilih';
    return '${_selectedDate!.day.toString().padLeft(2, '0')}-'
        '${_selectedDate!.month.toString().padLeft(2, '0')}-'
        '${_selectedDate!.year}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _classController.dispose();
    _campusController.dispose();
    _hobbyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider profileImage = _profileImageBytes != null
        ? MemoryImage(_profileImageBytes!)
        : const AssetImage('assets/img/profil.jpg');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ================= FOTO PROFIL + TITLE =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: profileImage,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _nameController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mahasiswa Informatika - ${_classController.text}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= INFORMASI AKADEMIK (INPUT TEKS) =================
          _SectionCard(
            title: 'Informasi Akademik',
            icon: Icons.school,
            colors: const [AppColors.primary, AppColors.yellow],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabeledTextField(
                  label: 'Nama',
                  controller: _nameController,
                  onChanged: (_) => setState(() {}),
                ),
                _LabeledTextField(
                  label: 'NIM',
                  controller: _nimController,
                ),
                _LabeledTextField(
                  label: 'Kelas',
                  controller: _classController,
                  onChanged: (_) => setState(() {}),
                ),
                _LabeledTextField(
                  label: 'Kampus',
                  controller: _campusController,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ================= INFORMASI TAMBAHAN (RADIO, DROPDOWN, TEKS, CALENDAR) =================
          _SectionCard(
            title: 'Informasi Tambahan',
            icon: Icons.edit,
            colors: const [AppColors.pink, AppColors.primary],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        value: 'Perempuan',
                        groupValue: _selectedGender,
                        activeColor: Colors.white,
                        title: const Text(
                          'Perempuan',
                          style: TextStyle(color: Colors.white),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _selectedGender = val;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        value: 'Laki-laki',
                        groupValue: _selectedGender,
                        activeColor: Colors.white,
                        title: const Text(
                          'Laki-laki',
                          style: TextStyle(color: Colors.white),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _selectedGender = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Text(
                  'Program Studi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedProdi,
                      dropdownColor: AppColors.pink,
                      iconEnabledColor: Colors.white,
                      items: const [
                        DropdownMenuItem(
                          value: 'Informatika',
                          child: Text('Informatika'),
                        ),
                        DropdownMenuItem(
                          value: 'Teknik Industri',
                          child: Text('Teknik Industri'),
                        ),
                        DropdownMenuItem(
                          value: 'Sistem Informasi',
                          child: Text('Sistem Informasi'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedProdi = val;
                          });
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Hobi/Minat',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _hobbyController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Tulis hobi/minat kamu...',
                    hintStyle:
                        const TextStyle(color: Colors.white70, fontSize: 13),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Tanggal Lahir',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formattedDate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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

// ============= KOMPONEN UMUM =============
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> colors;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        style: const TextStyle(
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
                  style: const TextStyle(
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

// Label dan TextField
class _LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const _LabeledTextField({
    required this.label,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: labelStyle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: Colors.white.withOpacity(0.12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
