import 'package:flutter/material.dart';
import 'package:global_bangunan_app/components/product_item.dart';
import 'package:global_bangunan_app/components/brand_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Background abu-abu muda
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderPromo(),
            _buildBrandSection(),
            _buildHotDeals(context),
            _buildBestsellerSection(context),
            const SizedBox(height: 80), // Ruang agar tidak tertutup Bottom Nav Bar
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.headset_mic, color: Colors.white),
      ),
    );
  }

  // --- Widget Pembantu ---

  // 1. App Bar (Bagian Atas)
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          // Placeholder Logo Global Bangunan
          // Logo Global Bangunan
          Container(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(4),
             ),
             child: Image.asset(
              'assets/logo.jpeg',
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // 2. Banner Promo
  Widget _buildHeaderPromo() {
    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/gambar_membership.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 3. Section Brand
  Widget _buildBrandSection() {
    // List placeholder data brand
    final List<String> brands = ['LEMKRA', 'Hannochs', 'KIRIN', 'Miyako', 'CASTELLI', 'SANYO', 'M-TIGA', 'Dulux'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Brand', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(
                onPressed: () {},
                child: const Text('More >', style: TextStyle(color: Colors.blue, fontSize: 14)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return BrandLogo(logoText: brands[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 4. Hot Deals (Carousel)
  Widget _buildHotDeals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 10.0),
          child: Text('Hot Deals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        SizedBox(
          height: 100, // Tinggi yang sesuai untuk banner horizontal
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            children: [
              // Mengulang banner promo cat (Frame 3.png)
              _buildHotDealBanner(context),
              _buildHotDealBanner(context),
              _buildHotDealBanner(context),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Widget untuk Hot Deal Banner
  Widget _buildHotDealBanner(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200, // Placeholder warna untuk banner
        image: const DecorationImage(
          image: AssetImage('assets/hot_deals.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 5. Section Bestseller
  Widget _buildBestsellerSection(BuildContext context) {
    // List placeholder data produk
    final List<Map<String, String>> bestsellers = [
      {'title': 'Kran Tembok', 'price': 'Rp 92.500', 'imagePath': 'assets/produk_1.png'},
      {'title': 'DULUX PE...', 'price': 'Rp 961.200', 'imagePath': 'assets/produk_2.png'},
      {'title': 'LED BULB', 'price': 'Rp 113.000', 'imagePath': 'assets/produk_3.png'},
      {'title': 'LED Premiere', 'price': 'Rp 42.500', 'imagePath': 'assets/produk_4.png'},
      {'title': 'LED Basic', 'price': 'Rp 26.400', 'imagePath': 'assets/produk_5.png'},
      {'title': 'LP 3U green', 'price': 'Rp 43.000', 'imagePath': 'assets/produk_6.png'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0, right: 16.0),
          child: Center(
            child: Text(
              'Bestseller',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87.withOpacity(0.8),
              ),
            ),
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom sesuai design
            childAspectRatio: 0.7, // Rasio untuk membuat item lebih panjang
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: bestsellers.length,
          itemBuilder: (context, index) {
            final item = bestsellers[index];
            return ProductItem(
              title: item['title']!,
              price: item['price']!,
              imagePath: item['imagePath']!,
            );
          },
        ),
      ],
    );
  }

  // 6. Bottom Navigation Bar
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor, // Warna Biru
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Badge(label: Text('0'), child: Icon(Icons.chat_bubble_outline)),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Badge(label: Text('0'), child: Icon(Icons.chat_bubble_outline)),
            ),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: const Badge(label: Text('4'), child: Icon(Icons.shopping_cart)),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Badge(label: Text('4'), child: Icon(Icons.shopping_cart)),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.person),
            ),
            label: 'User',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Aksi navigasi
        },
      ),
    );
  }
}

// Widget untuk icon dan teks benefit member
class _PromoBenefit extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PromoBenefit({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.red, // Pastikan warna merah sesuai design
          radius: 12,
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: Colors.black87),
        ),
      ],
    );
  }
}