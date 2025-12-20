import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const CartScreen({super.key, this.onBack});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Model data sederhana untuk cart item
  final List<Map<String, dynamic>> _cartItems = [
    {
      'title': 'DULUX PENTALITE A923 CEILING PAINT 25KG',
      'price': 'Rp 961.200',
      'qty': 2,
      'isChecked': true,
      'imagePath': 'assets/produk_2.png',
    },
    {
      'title': 'Kran Tembok',
      'price': 'Rp 92.500',
      'qty': 3,
      'isChecked': false,
      'imagePath': 'assets/produk_2.png',
    },
    {
      'title': 'LED Premiere',
      'price': 'Rp 42.500',
      'qty': 1,
      'isChecked': false,
      'imagePath': 'assets/produk_4.png',
    },
    {
      'title': 'LED Alpha',
      'price': 'Rp 19.900',
      'qty': 5,
      'isChecked': false,
      'imagePath': 'assets/produk_5.png',
    },
  ];

  bool _isAllChecked = false;

  @override
  void initState() {
    super.initState();
    _checkSelectAllStatus();
  }

  void _checkSelectAllStatus() {
    setState(() {
      _isAllChecked = _cartItems.every((item) => item['isChecked'] == true);
    });
  }

  void _toggleItem(int index, bool? val) {
    setState(() {
      _cartItems[index]['isChecked'] = val ?? false;
      _checkSelectAllStatus();
    });
  }

  void _toggleAll(bool? val) {
    setState(() {
      _isAllChecked = val ?? false;
      for (var item in _cartItems) {
        item['isChecked'] = _isAllChecked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2), // Background #e2e2e2
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: const Text(
          'My Cart (4)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E3192), // AppBar #2E3192
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _buildCartItem(
                  index: index,
                  title: item['title'],
                  price: item['price'],
                  qty: item['qty'],
                  isChecked: item['isChecked'],
                  imagePath: item['imagePath'],
                );
              },
            ),
          ),
          _buildBottomCheckoutSection(context),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required int index,
    required String title,
    required String price,
    required int qty,
    required bool isChecked,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: (val) => _toggleItem(index, val),
              activeColor: const Color(0xFF2E3192),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade100),
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ), // Use placeholder if asset doesn't exist
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Fallback if image not found
                },
              ),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (c, o, s) => const Icon(Icons.image),
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF2E3192),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Quantity Controls
                    _buildQtyButton(Icons.remove),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          vertical: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                      child: Text(
                        '$qty',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildQtyButton(Icons.add),
                    const Spacer(),
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                      size: 20,
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

  Widget _buildQtyButton(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Icon(icon, size: 16, color: Colors.black),
    );
  }

  Widget _buildBottomCheckoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF2E3192), // Dark Blue footer
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Checkbox(
              value: _isAllChecked,
              onChanged: _toggleAll,
              fillColor: WidgetStateProperty.resolveWith(
                (states) => Colors.white,
              ),
              checkColor: const Color(0xFF2E3192),
            ),
            const Text(
              'Semua',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF4A4EBD,
                ), // Lighter blue for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
