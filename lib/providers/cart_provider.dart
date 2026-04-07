import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String price; // e.g. "Rp 961.200"
  int qty;
  bool isChecked;
  final String imagePath;

  CartItem({
    required this.id, // For uniqueness, use title if ID is not available
    required this.title,
    required this.price,
    this.qty = 1,
    this.isChecked = false,
    required this.imagePath,
  });

  // Calculate parsed price if needed (e.g. from "Rp 961.200" to 961200)
  int get parsedPrice {
    final cleanString = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  bool get isAllChecked {
    if (_items.isEmpty) return false;
    return _items.every((item) => item.isChecked);
  }

  void addItem(CartItem newItem) {
    // Check if the item is already in the cart
    final index = _items.indexWhere((item) => item.title == newItem.title);
    if (index >= 0) {
      // Just increase quantity
      _items[index].qty++;
    } else {
      _items.add(newItem);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void increaseQty(int index) {
    _items[index].qty++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    if (_items[index].qty > 1) {
      _items[index].qty--;
    } else {
      // Opt: remove item if qty <= 0? (Currently just min 1)
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void toggleItemCheck(int index, bool isChecked) {
    _items[index].isChecked = isChecked;
    notifyListeners();
  }

  void toggleAllCheck(bool isChecked) {
    for (var item in _items) {
      item.isChecked = isChecked;
    }
    notifyListeners();
  }

  int get totalItemCount {
    return _items.fold(0, (sum, item) => sum + item.qty);
  }

  int get uniqueItemCount {
    return _items.length;
  }

  int get totalPrice {
    return _items
        .where((item) => item.isChecked)
        .fold(0, (sum, item) => sum + (item.parsedPrice * item.qty));
  }
}
