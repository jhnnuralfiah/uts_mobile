import 'package:flutter/material.dart';
import '../theme.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    // daftar kontak statis (acak)
    final List<_Contact> contacts = [
      _Contact(name: 'Jihan Nur Alfiah', phone: '0838-1234-0001', imageAsset: 'assets/img/profil.jpg'),
      _Contact(name: 'Alya Putri',       phone: '0838-1234-0002'),
      _Contact(name: 'Budi Santoso',     phone: '0838-1234-0003'),
      _Contact(name: 'Lestari',          phone: '0838-1234-0004'),
      _Contact(name: 'Dani Handayani',   phone: '0838-1234-0005'),
      _Contact(name: 'Eka Nuraini',      phone: '0838-1234-0006'),
      _Contact(name: 'Fajar',            phone: '0838-1234-0007'),
      _Contact(name: 'Ramdan Saputra',   phone: '0838-1234-0008'),
      _Contact(name: 'Hadi Kurniawan',   phone: '0838-1234-0009'),
      _Contact(name: 'Indah Rizkiya',    phone: '0838-1234-0010'),
      _Contact(name: 'Jhohanes',         phone: '0838-1234-0011'),
      _Contact(name: 'Kevin Hartono',    phone: '0838-1234-0012'),
      _Contact(name: 'Lia Maharani',     phone: '0838-1234-0013'),
      _Contact(name: 'Novita Anggraini', phone: '0838-1234-0014'),
      _Contact(name: 'Siti Aisyah',      phone: '0838-1234-0015'),
    ];

    // urutkan hasil tampilan
    final List<_Contact> sortedContacts = [...contacts]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Container(
      color: AppColors.background,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        itemCount: sortedContacts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final contact = sortedContacts[index];
          return _ContactCard(contact: contact);
        },
      ),
    );
  }
}

// ====== MODEL KONTAK ======
class _Contact {
  final String name;
  final String phone;
  final String? imageAsset;

  const _Contact({
    required this.name,
    required this.phone,
    this.imageAsset,
  });

  String get initial {
    if (name.isEmpty) return '?';
    return name.trim()[0].toUpperCase();
  }
}

// ====== WIDGET KARTU KONTAK ======
class _ContactCard extends StatelessWidget {
  final _Contact contact;

  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          _ContactAvatar(contact: contact),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  contact.phone,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.phone_rounded,
            size: 20,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _ContactAvatar extends StatelessWidget {
  final _Contact contact;

  const _ContactAvatar({required this.contact});

  @override
  Widget build(BuildContext context) {
    if (contact.imageAsset != null && contact.imageAsset!.isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(contact.imageAsset!),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.pink,
      child: Text(
        contact.initial,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
