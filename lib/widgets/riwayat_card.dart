import 'package:flutter/material.dart';

class RiwayatCard extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String? imagePath;

  const RiwayatCard({
    super.key,
    required this.judul,
    required this.tanggal,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Merapikan format tanggal (memotong milidetik)
    String tanggalFormatted = tanggal;
    if (tanggalFormatted.contains('.')) {
      tanggalFormatted = tanggalFormatted.split('.').first;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath ?? 'assets/cover/default.jpeg',
              width: 45,
              height: 65,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 45,
                  height: 65,
                  color: Colors.grey[300],
                  child: const Icon(Icons.book, size: 20),
                );
              },
            ),
          ),
        ),
        title: Text(
          judul,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                tanggalFormatted,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}