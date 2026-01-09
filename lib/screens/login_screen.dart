import 'package:flutter/material.dart';
import 'package:global_bangunan_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController(
    text: 'example@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '........',
  );
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E3192), // Biru atas
              Color(0xFF0E0F2C), // Biru gelap bawah
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Tab Bar (Masuk / Daftar)
              _buildTabBar(),

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab Masuk (Login)
                    _buildLoginForm(),

                    // Tab Daftar (Register) - placeholder
                    _buildRegisterForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: TabBar(
        controller: _tabController,
        indicator: const BoxDecoration(), // No indicator
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.6),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Masuk'),
          Tab(text: 'Daftar'),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Logo
          _buildLogo(),

          const SizedBox(height: 60),

          // Email Field
          _buildInputField(
            label: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          // Password Field
          _buildInputField(
            label: 'Password',
            controller: _passwordController,
            isPassword: true,
          ),

          // Lupa Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implementasi lupa password
              },
              child: const Text(
                'Lupa Password',
                style: TextStyle(color: Color(0xFF5B7FFF), fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Login Button
          _buildLoginButton(),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Logo
          _buildLogo(),

          const SizedBox(height: 40),

          // Nama Field
          _buildInputField(
            label: 'Nama Lengkap',
            controller: TextEditingController(),
          ),

          const SizedBox(height: 20),

          // Email Field
          _buildInputField(
            label: 'Email',
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          // Password Field
          _buildInputField(
            label: 'Password',
            controller: TextEditingController(),
            isPassword: true,
          ),

          const SizedBox(height: 20),

          // Konfirmasi Password Field
          _buildInputField(
            label: 'Konfirmasi Password',
            controller: TextEditingController(),
            isPassword: true,
          ),

          const SizedBox(height: 40),

          // Register Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke HomeScreen setelah daftar
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B4FD9),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Daftar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Logo from assets - tampil penuh
        Image.asset('assets/logo.jpeg', width: 150, fit: BoxFit.contain),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: isPassword && _obscurePassword,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke HomeScreen setelah login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4B4FD9),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
