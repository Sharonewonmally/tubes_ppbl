import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? profileImage;
  String username = "Pengguna Safae";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    final savedName = prefs.getString('profile_name');

    setState(() {
      if (imagePath != null) {
        profileImage = File(imagePath);
      }
      if (savedName != null) {
        username = savedName;
      }
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', image.path);

    setState(() {
      profileImage = File(image.path);
    });
  }

  Future<void> editName() async {
    final controller = TextEditingController(text: username);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Nama"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Masukkan nama baru",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('profile_name', controller.text);

                setState(() {
                  username = controller.text;
                });

                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            )
          ],
        );
      },
    );
  }

  Future<void> removePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');

    setState(() {
      profileImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Latar belakang yang lebih soft
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          // Membatasi lebar agar tetap rapi saat dibuka di layar monitor lebar (PC)
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // ================= FOTO PROFIL DENGAN BADGE KAMERA =================
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      onLongPress: () {
                        // Menggunakan Long Press agar lebih intuitif untuk menghapus foto
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Hapus Foto?"),
                            content: const Text("Apakah Anda yakin ingin menghapus foto profil?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Batal"),
                              ),
                              TextButton(
                                onPressed: () {
                                  removePhoto();
                                  Navigator.pop(context);
                                },
                                child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.blue[100],
                          backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
                          child: profileImage == null
                              ? const Icon(Icons.person, size: 65, color: Colors.blueAccent)
                              : null,
                        ),
                      ),
                    ),
                    // Indikator Edit Kamera
                    GestureDetector(
                      onTap: pickImage,
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ================= NAMA & SUBTITLE =================
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Pembaca & Penulis",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                // ================= LIST MENU UTAMA =================
                _buildMenuTile(
                  icon: Icons.edit_outlined,
                  title: "Edit Nama",
                  color: Colors.orange,
                  onTap: editName,
                ),
                _buildMenuTile(
                  icon: Icons.menu_book_outlined,
                  title: "Buku Dibaca",
                  color: Colors.blue,
                  trailingCount: "12",
                ),
                _buildMenuTile(
                  icon: Icons.history_edu_outlined,
                  title: "Cerita Ditulis",
                  color: Colors.purple,
                  trailingCount: "5",
                ),
                _buildMenuTile(
                  icon: Icons.stars_rounded,
                  title: "Poin",
                  color: Colors.amber[700]!,
                  trailingCount: "1250",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget agar kode menu tile lebih bersih, rapi, dan modular
  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required Color color,
    String? trailingCount,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: trailingCount != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trailingCount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              )
            : const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}