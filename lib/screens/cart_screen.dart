import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_bangunan_app/providers/cart_provider.dart';
import 'package:global_bangunan_app/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const CartScreen({super.key, this.onBack});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // We no longer need local state for items, it's all in CartProvider

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final cartItems = cartProvider.items;
        
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
            title: Text(
              'My Cart (${cartProvider.uniqueItemCount})',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFF2E3192), // AppBar #2E3192
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Keranjang Anda Kosong',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return _buildCartItem(
                            context: context,
                            index: index,
                            item: item,
                            cartProvider: cartProvider,
                          );
                        },
                      ),
              ),
              _buildBottomCheckoutSection(context, cartProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItem({
    required BuildContext context,
    required int index,
    required CartItem item,
    required CartProvider cartProvider,
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
              value: item.isChecked,
              onChanged: (val) => cartProvider.toggleItemCheck(index, val ?? false),
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
                image: AssetImage(item.imagePath),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
            child: Image.asset(
              item.imagePath,
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
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.price,
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
                    InkWell(
                      onTap: () => cartProvider.decreaseQty(index),
                      child: _buildQtyButton(Icons.remove),
                    ),
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
                        '${item.qty}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () => cartProvider.increaseQty(index),
                      child: _buildQtyButton(Icons.add),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => cartProvider.removeItem(index),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
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

  Widget _buildBottomCheckoutSection(BuildContext context, CartProvider cartProvider) {
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
              value: cartProvider.isAllChecked,
              onChanged: (val) => cartProvider.toggleAllCheck(val ?? false),
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
            Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 const Text('Total:', style: TextStyle(color: Colors.white, fontSize: 12)),
                 Text(
                   'Rp ${cartProvider.totalPrice}', 
                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                 ),
               ]
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                final selectedItems = cartProvider.items.where((i) => i.isChecked).toList();
                if (selectedItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pilih minimal 1 produk untuk checkout!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      selectedItems: selectedItems,
                      totalPrice: cartProvider.totalPrice,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A4EBD), // Lighter blue for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
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
