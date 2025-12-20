import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const NotificationScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2), // Background color #e2e2e2
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (onBack != null) {
              onBack!();
            } else {
              Navigator.of(context).pop();
            }
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // Handle notification tap
          },
          splashColor: const Color(0xFF2E3192).withOpacity(0.1),
          highlightColor: const Color(0xFF2E3192).withOpacity(0.05),
          hoverColor: const Color(0xFF2E3192).withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // color: Colors.white, // Moved to Material to allow InkWell effect
              borderRadius: BorderRadius.circular(15),
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
          ),
        ),
      ),
    );
  }
}
