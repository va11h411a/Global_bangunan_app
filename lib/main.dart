import 'package:flutter/material.dart';
import 'package:global_bangunan_app/screens/splash_screen.dart';

import 'package:provider/provider.dart';
import 'package:global_bangunan_app/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const GlobalBangunanApp(),
    ),
  );
}

class GlobalBangunanApp extends StatelessWidget {
  const GlobalBangunanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Bangunan',
      debugShowCheckedModeBanner: false, // Untuk menghilangkan banner 'DEBUG'
      theme: ThemeData(
        primaryColor: const Color(0xFF003366), // Warna biru gelap logo
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(
              secondary: const Color(0xFFE50000), // Warna merah untuk aksen
            ),
        fontFamily: 'Roboto', // Contoh font
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
