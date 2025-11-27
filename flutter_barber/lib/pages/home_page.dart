// home_page.dart
// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_barber/service/user_service.dart' show UserService;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barber/pages/barbers_page.dart';
import 'package:flutter_barber/pages/booking_page.dart';
import 'package:flutter_barber/pages/cart_page.dart';
import 'package:flutter_barber/pages/profile_page.dart';
import 'package:flutter_barber/service/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Map<String, String> _userData = {
    'firstName': '',
    'lastName': '',
    'email': '',
  };

  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _accentColor = const Color(0xffFF6584);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  // Lista de páginas para a navegação
  final List<Widget> _pages = [
    const HomeContent(),
    const BookingPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserService.getUserData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? _darkBackground : _lightBackground,
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(isDarkMode),
    );
  }

  Widget _buildBottomNavBar(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? _cardDark : _cardLight,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: _primaryColor,
        unselectedItemColor: isDarkMode
            ? _textDark.withOpacity(0.5)
            : _textLight.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Conteúdo da Home Page separado
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  Map<String, String> _userData = {
    'firstName': '',
    'lastName': '',
    'email': '',
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await UserService.getUserData();
    setState(() {
      _userData = userData;
    });
  }

  String get _userFirstName => _userData['firstName']?.isNotEmpty == true
      ? _userData['firstName']!
      : 'Usuário';

  get _textLight => null;

  get _textDark => null;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Search Bar
            _buildSearchBar(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Services Section
            _buildServicesSection(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Featured Barbers
            _buildFeaturedBarbers(size, isDarkMode, context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $_userFirstName!',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Encontre o melhor corte',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          width: size.width * 0.12,
          height: size.width * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff6C63FF),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  // ... (resto do código permanece igual)
  Widget _buildSearchBar(Size size, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff2D3748) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: const Color(0xff6C63FF)),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar barbeiros ou serviços...',
                hintStyle: TextStyle(
                  color: isDarkMode
                      ? const Color(0xffE2E8F0).withOpacity(0.5)
                      : const Color(0xff2D3748).withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(Size size, bool isDarkMode) {
    final services = [
      {'icon': Icons.cut, 'name': 'Corte', 'color': const Color(0xff6C63FF)},
      {'icon': Icons.face, 'name': 'Barba', 'color': const Color(0xff4A90E2)},
      {
        'icon': Icons.spa,
        'name': 'Sobrancelha',
        'color': const Color(0xffFF6584),
      },
      {'icon': Icons.clean_hands, 'name': 'Limpeza', 'color': Colors.amber},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Serviços',
          style: GoogleFonts.poppins(
            color: isDarkMode
                ? const Color(0xffE2E8F0)
                : const Color(0xff2D3748),
            fontSize: size.height * 0.022,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingPage(),
                    ),
                  );
                },
                child: Container(
                  width: size.width * 0.22,
                  margin: EdgeInsets.only(right: size.width * 0.03),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xff2D3748) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(size.width * 0.04),
                        decoration: BoxDecoration(
                          color: service['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          service['icon'] as IconData,
                          color: Colors.white,
                          size: size.height * 0.025,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        service['name'] as String,
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? const Color(0xffE2E8F0)
                              : const Color(0xff2D3748),
                          fontSize: size.height * 0.014,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedBarbers(
    Size size,
    bool isDarkMode,
    BuildContext context,
  ) {
    final barbers = [
      {
        'name': 'Carlos Silva',
        'specialty': 'Especialista em cortes modernos',
        'rating': 4.9,
        'image':
            'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop',
        'price': 'R\$ 35,00',
      },
      {
        'name': 'Miguel Santos',
        'specialty': 'Mestre em barbas',
        'rating': 4.8,
        'image':
            'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?w=150&h=150&fit=crop',
        'price': 'R\$ 40,00',
      },
      {
        'name': 'Ricardo Lima',
        'specialty': 'Cortes clássicos',
        'rating': 4.7,
        'image':
            'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=150&h=150&fit=crop',
        'price': 'R\$ 30,00',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Barbeiros em Destaque',
              style: GoogleFonts.poppins(
                color: isDarkMode
                    ? const Color(0xffE2E8F0)
                    : const Color(0xff2D3748),
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BarbersPage()),
                );
              },
              child: Text(
                'Ver todos',
                style: GoogleFonts.poppins(
                  color: const Color(0xff6C63FF),
                  fontSize: size.height * 0.014,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: barbers.length,
          itemBuilder: (context, index) {
            final barber = barbers[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.02),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xff2D3748) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(barber['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              barber['name'] as String,
                              style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? const Color(0xffE2E8F0)
                                    : const Color(0xff2D3748),
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              barber['specialty'] as String,
                              style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? const Color(0xffE2E8F0).withOpacity(0.7)
                                    : const Color(0xff2D3748).withOpacity(0.7),
                                fontSize: size.height * 0.014,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: size.height * 0.018,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  barber['rating'].toString(),
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? const Color(0xffE2E8F0)
                                        : const Color(0xff2D3748),
                                    fontSize: size.height * 0.014,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  barber['price'] as String,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff6C63FF),
                                    fontSize: size.height * 0.016,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
