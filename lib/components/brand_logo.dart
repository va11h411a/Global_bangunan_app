import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  final String logoText;
  // Dalam project nyata, Anda akan menggunakan Image.asset atau Image.network
  // Tapi untuk tujuan tampilan, kita gunakan Container dengan teks.

  const BrandLogo({
    super.key,
    required this.logoText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Text(
          logoText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}