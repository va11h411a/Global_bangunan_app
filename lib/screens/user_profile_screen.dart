import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const UserProfileScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    // Warna biru khusus sesuai request
    final Color primaryBlue = const Color(0xFF2E3192);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu-abu muda
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section dengan Stack untuk overlap
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 1. Background Biru
                Container(
                  height: 240,
                  width: double.infinity,
                  color: primaryBlue,
                ),

                // 2. Profile Info (Nama & Avatar)
                Positioned(
                  top: 60, // Sesuaikan dengan safe area
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      // Avatar dengan Icon Edit
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(
                                'assets/Politeknik Negeri Semarang.png',
                              ), // Ganti dengan asset asli jika ada
                              // Fallback jika tidak ada gambar
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      // Nama User
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Solinep',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          // Bisa tambah member status atau email di sini jika perlu
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. Order Status Card (Overlapping)
                Positioned(
                  bottom: -40, // Membuatnya overlap keluar dari container biru
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildOrderStatusItem(
                          Icons.account_balance_wallet,
                          'Belum Bayar',
                          '0',
                        ),
                        _buildOrderStatusItem(
                          Icons.inventory_2,
                          'Dikemas',
                          '0',
                        ),
                        _buildOrderStatusItem(
                          Icons.local_shipping,
                          'Dikirim',
                          '0',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60), // Spacer untuk kompensasi overlap kartu
            // Menu Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuCard(Icons.favorite, 'Favorit Saya'),
                  _buildMenuCard(Icons.chat, 'Chat dengan Global Bangunan'),
                  _buildMenuCard(Icons.star, 'Penilaian'),
                  _buildMenuCard(Icons.settings, 'Pengaturan'),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusItem(IconData icon, String label, String count) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            if (count != '0')
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildMenuCard(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors
                .black, // Icon background hitam (lingkaran/shape) sesuai style
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Navigasi
        },
      ),
    );
  }
}
