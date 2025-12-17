import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2), // Background color #e2e2e2
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Since it's in bottom nav, back might logically mean go to Home or system back
            // For now, let's assuming it just pops if pushed, or we can handle tab switching if needed.
            // But usually, sub-tabs don't have back buttons to other tabs effectively unless nested.
            // However, the design shows a back arrow.
            // If this is a main tab, the back arrow might seem out of place unless it returns to Home specifically.
            // Let's implement pop for now, but in the context of BottomNav, this might need adjustment.
            // If we are strictly following a "Page" that navigates FROM home, push/pop works.
            // If it is a TAB, then no back button usually.
            // BUT, the prompt implies "page selanjutnya" (next page) and design has back arrow.
            // Implies it MIGHT be pushed on top?
            // User also said "Update HomeScreen or navigation to link to the new page".
            // AND the plan says "Update BottomNavigationBar ... to use _selectedIndex".
            // If it's a BottomNav item, usually no back button.
            // BUT, look at the design image: It has a Back Arrow AND Bottom Nav.
            // This is a common pattern in some apps where the specific tab has a header with back.
            // Or maybe it's just a screen pushed on top that HAS a bottom nav (less common).
            // Let's stick to the Tab implementation for now as planned.
            // If it's a tab, I'll make the back button switch to Home tab (index 0).
          },
        ),
        title: const Text(
          'Notifikasi (1)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E3192), // AppBar color #2E3192
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [_buildNotificationItem()],
      ),
    );
  }

  Widget _buildNotificationItem() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo/Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              // color: Colors.red, // Placeholder for the logo background
              borderRadius: BorderRadius.circular(8),
            ),
            // Assuming we don't have the exact "Promo Special" asset yet, uses icon or leaving empty
            // In the design it looks like a red 'tag' image.
            // I'll use a placeholder icon for now.
            child: const Icon(
              Icons.confirmation_number,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Promo Spesial',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Spesial Gajian Sale, Kamu Pasti Dapat Dis...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
