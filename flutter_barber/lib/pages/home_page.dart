// lib/pages/home_page.dart
// ignore_for_file: deprecated_member_use, unused_field, unused_element, unnecessary_to_list_in_spreads, avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barber/service/user_service.dart';
import 'package:flutter_barber/service/popup_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barber/pages/barbers_page.dart';
import 'package:flutter_barber/pages/booking_page.dart';
import 'package:flutter_barber/pages/cart_page.dart';
import 'package:flutter_barber/pages/profile_page.dart';
import 'package:flutter_barber/widgets/welcome_popup.dart';

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
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: isDarkMode ? _cardDark : _cardLight,
          elevation: 0,
          selectedItemColor: _primaryColor,
          unselectedItemColor: isDarkMode
              ? _textDark.withOpacity(0.5)
              : _textLight.withOpacity(0.5),
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == 0
                      ? _primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: _currentIndex == 0 ? 24 : 22,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == 1
                      ? _primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.calendar_today_rounded,
                  size: _currentIndex == 1 ? 24 : 22,
                ),
              ),
              label: 'Agendar',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == 2
                      ? _primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  size: _currentIndex == 2 ? 24 : 22,
                ),
              ),
              label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == 3
                      ? _primaryColor.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: _currentIndex == 3 ? 24 : 22,
                ),
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

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
  final TextEditingController _searchController = TextEditingController();
  int _selectedPromoIndex = 0;
  late PageController _pageController;
  Timer? _timer;
  Timer? _popupTimer;

  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _accentColor = const Color(0xffFF6584);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  final List<Map<String, dynamic>> _promotions = [
    {
      'title': 'Primeiro Corte',
      'subtitle': '50% de desconto',
      'description': 'Na primeira visita à nossa barbearia',
      'color': const Color(0xff6C63FF),
      'icon': Icons.local_offer_rounded,
    },
    {
      'title': 'Combo Completo',
      'subtitle': 'Corte + Barba',
      'description': 'Economize R\$ 20 no combo completo',
      'color': const Color(0xff4A90E2),
      'icon': Icons.spa_rounded,
    },
    {
      'title': 'Fidelidade',
      'subtitle': '10 cortes = 1 grátis',
      'description': 'Acumule cortes e ganhe um gratuito',
      'color': const Color(0xffFF6584),
      'icon': Icons.loyalty_rounded,
    },
  ];

  final List<Map<String, dynamic>> _editableBarbers = [
    {
      'name': 'Carlos Silva',
      'specialty': 'Especialista em cortes modernos',
      'rating': 4.9,
      'reviews': 127,
      'image':
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&h=200&fit=crop',
      'price': 'R\$ 35,00',
      'isAvailable': true,
      'experience': '5 anos',
    },
    {
      'name': 'Miguel Santos',
      'specialty': 'Mestre em barbas',
      'rating': 4.8,
      'reviews': 89,
      'image':
          'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?w=200&h=200&fit=crop',
      'price': 'R\$ 40,00',
      'isAvailable': true,
      'experience': '7 anos',
    },
    {
      'name': 'Ricardo Lima',
      'specialty': 'Cortes clássicos',
      'rating': 4.7,
      'reviews': 156,
      'image':
          'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=200&h=200&fit=crop',
      'price': 'R\$ 30,00',
      'isAvailable': true,
      'experience': '10 anos',
    },
  ];

  @override
  void initState() {
    super.initState();
    print('HomeContent initState called');
    _loadUserData();
    _pageController = PageController(viewportFraction: 0.95);
    _startAutoCarousel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomePopup();
      PopupService.debugPopupStatus();
    });
  }

  void _startAutoCarousel() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage;
        if (_selectedPromoIndex < _promotions.length - 1) {
          nextPage = _selectedPromoIndex + 1;
        } else {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _showWelcomePopup() async {
    try {
      print('Iniciando _showWelcomePopup...');

      await Future.delayed(const Duration(milliseconds: 2000));

      if (!mounted) {
        print('Widget não está montado, cancelando popup');
        return;
      }

      final shouldShowPopup = await PopupService.shouldShowWelcomePopup();
      print('Should show welcome popup: $shouldShowPopup');

      if (shouldShowPopup) {
        print('Mostrando popup de boas-vindas...');
        _showWelcomeDialog();

        _popupTimer = Timer(const Duration(seconds: 8), () {
          if (mounted) {
            print('Fechando popup automaticamente após 8 segundos');
            _closeWelcomePopup();
          }
        });
      } else {
        print('Popup já foi mostrado anteriormente');
      }
    } catch (e) {
      print('Error showing welcome popup: $e');
    }
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WelcomePopup(
          userName: _userData['firstName'] ?? 'Usuário',
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          onClose: _closeWelcomePopup,
        );
      },
    ).then((value) {
      _popupTimer?.cancel();
      PopupService.setWelcomePopupShown();
    });
  }

  void _closeWelcomePopup() {
    print('Fechando popup de boas-vindas');
    PopupService.setWelcomePopupShown();
    _popupTimer?.cancel();
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _timer?.cancel();
    _popupTimer?.cancel();
    super.dispose();
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

  void _toggleBarberAvailability(int index) {
    setState(() {
      _editableBarbers[index]['isAvailable'] =
          !_editableBarbers[index]['isAvailable'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode ? _darkBackground : _lightBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  bottom: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header com saudação
                    _buildHeader(size, isDarkMode),
                    SizedBox(height: size.height * 0.03),

                    // Search Bar
                    _buildSearchBar(size, isDarkMode),
                    SizedBox(height: size.height * 0.03),

                    // Promotions Carousel
                    _buildPromotionsCarousel(size, isDarkMode),
                    SizedBox(height: size.height * 0.04),

                    // Quick Actions
                    _buildQuickActions(size, isDarkMode),
                    SizedBox(height: size.height * 0.04),

                    // Services Section
                    _buildServicesSection(size, isDarkMode),
                    SizedBox(height: size.height * 0.04),

                    // Featured Barbers
                    _buildFeaturedBarbers(size, isDarkMode, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, ${_userFirstName}! 👋',
            style: GoogleFonts.poppins(
              color: isDarkMode ? _textDark : _textLight,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            'Pronto para renovar o visual?',
            style: GoogleFonts.poppins(
              color: isDarkMode
                  ? _textDark.withOpacity(0.7)
                  : _textLight.withOpacity(0.7),
              fontSize: size.height * 0.014,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(Size size, bool isDarkMode) {
    return Container(
      height: size.height * 0.065,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? _cardDark : _cardLight,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? _textDark.withOpacity(0.1)
              : _textLight.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: _primaryColor,
            size: size.height * 0.026,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.016,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar barbeiros, serviços, promoções...',
                hintStyle: GoogleFonts.poppins(
                  color: isDarkMode
                      ? _textDark.withOpacity(0.5)
                      : _textLight.withOpacity(0.5),
                  fontSize: size.height * 0.015,
                ),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(size.width * 0.02),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? _textDark.withOpacity(0.1)
                      : _textLight.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.clear_rounded,
                  color: isDarkMode
                      ? _textDark.withOpacity(0.5)
                      : _textLight.withOpacity(0.5),
                  size: size.height * 0.018,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromotionsCarousel(Size size, bool isDarkMode) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.16,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _promotions.length,
            onPageChanged: (index) {
              setState(() {
                _selectedPromoIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final promo = _promotions[index];
              return GestureDetector(
                onTap: () {
                  // Navegar para promoções
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        promo['color'] as Color,
                        (promo['color'] as Color).withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (promo['color'] as Color).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.12,
                              height: size.width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                promo['icon'] as IconData,
                                color: Colors.white,
                                size: size.height * 0.025,
                              ),
                            ),
                            SizedBox(width: size.width * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    promo['title'] as String,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: size.height * 0.018,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Text(
                                    promo['subtitle'] as String,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: size.height * 0.016,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  Text(
                                    promo['description'] as String,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: size.height * 0.012,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white.withOpacity(0.8),
                              size: size.height * 0.018,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promotions.length, (index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _selectedPromoIndex == index
                    ? size.width * 0.06
                    : size.width * 0.02,
                height: size.width * 0.02,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.008),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedPromoIndex == index
                      ? _primaryColor
                      : isDarkMode
                      ? _textDark.withOpacity(0.3)
                      : _textLight.withOpacity(0.3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQuickActions(Size size, bool isDarkMode) {
    final actions = [
      {
        'icon': Icons.calendar_month_rounded,
        'name': 'Agendar',
        'color': _primaryColor,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookingPage()),
          );
        },
      },
      {
        'icon': Icons.people_alt_rounded,
        'name': 'Barbeiros',
        'color': _secondaryColor,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarbersPage()),
          );
        },
      },
      {
        'icon': Icons.local_offer_rounded,
        'name': 'Promoções',
        'color': _accentColor,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookingPage()),
          );
        },
      },
      {
        'icon': Icons.history_rounded,
        'name': 'Histórico',
        'color': Colors.orange,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Acesso Rápido',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? _textDark : _textLight,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '• • •',
                style: GoogleFonts.poppins(
                  color: isDarkMode
                      ? _textDark.withOpacity(0.5)
                      : _textLight.withOpacity(0.5),
                  fontSize: size.height * 0.016,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: size.width * 0.03,
            mainAxisSpacing: size.height * 0.015,
            childAspectRatio: 0.85,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return GestureDetector(
              onTap: action['onTap'] as VoidCallback,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.16,
                    height: size.width * 0.16,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          action['color'] as Color,
                          (action['color'] as Color).withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (action['color'] as Color).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      action['icon'] as IconData,
                      color: Colors.white,
                      size: size.height * 0.026,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    action['name'] as String,
                    style: GoogleFonts.poppins(
                      color: isDarkMode ? _textDark : _textLight,
                      fontSize: size.height * 0.012,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildServicesSection(Size size, bool isDarkMode) {
    final services = [
      {
        'icon': Icons.cut_rounded,
        'name': 'Corte',
        'description': 'Estilo personalizado',
        'color': _primaryColor,
        'price': 'R\$ 30-50',
        'time': '30 min',
      },
      {
        'icon': Icons.face_retouching_natural_rounded,
        'name': 'Barba',
        'description': 'Acabamento perfeito',
        'color': _secondaryColor,
        'price': 'R\$ 20-35',
        'time': '25 min',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'name': 'Sobrancelha',
        'description': 'Design profissional',
        'color': _accentColor,
        'price': 'R\$ 15-25',
        'time': '15 min',
      },
      {
        'icon': Icons.spa_rounded,
        'name': 'Completo',
        'description': 'Corte + Barba',
        'color': Colors.green,
        'price': 'R\$ 45-70',
        'time': '50 min',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Serviços em Destaque',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingPage()),
                );
              },
              child: Row(
                children: [
                  Text(
                    'Ver todos',
                    style: GoogleFonts.poppins(
                      color: _primaryColor,
                      fontSize: size.height * 0.014,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.01),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: _primaryColor,
                    size: size.height * 0.014,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.18,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
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
                  width: size.width * 0.75,
                  margin: EdgeInsets.only(
                    right: size.width * 0.04,
                    left: index == 0 ? size.width * 0.02 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? _cardDark : _cardLight,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              service['color'] as Color,
                              (service['color'] as Color).withOpacity(0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              service['icon'] as IconData,
                              color: Colors.white,
                              size: size.height * 0.035,
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.003,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                service['time'] as String,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: size.height * 0.01,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                service['name'] as String,
                                style: GoogleFonts.poppins(
                                  color: isDarkMode ? _textDark : _textLight,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Text(
                                service['description'] as String,
                                style: GoogleFonts.poppins(
                                  color: isDarkMode
                                      ? _textDark.withOpacity(0.7)
                                      : _textLight.withOpacity(0.7),
                                  fontSize: size.height * 0.013,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                children: [
                                  Text(
                                    service['price'] as String,
                                    style: GoogleFonts.poppins(
                                      color: _primaryColor,
                                      fontSize: size.height * 0.016,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'AGENDAR',
                                      style: GoogleFonts.poppins(
                                        color: _primaryColor,
                                        fontSize: size.height * 0.01,
                                        fontWeight: FontWeight.w700,
                                      ),
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
        ),
      ],
    );
  }

  Widget _buildFeaturedBarbers(
    Size size,
    bool isDarkMode,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Barbeiros em Destaque',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
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
              child: Row(
                children: [
                  Text(
                    'Ver todos',
                    style: GoogleFonts.poppins(
                      color: _primaryColor,
                      fontSize: size.height * 0.014,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.01),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: _primaryColor,
                    size: size.height * 0.014,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        ..._editableBarbers.asMap().entries.map((entry) {
          final index = entry.key;
          final barber = entry.value;
          return _buildBarberCard(barber, index, size, isDarkMode, context);
        }).toList(),
      ],
    );
  }

  Widget _buildBarberCard(
    Map<String, dynamic> barber,
    int index,
    Size size,
    bool isDarkMode,
    BuildContext context,
  ) {
    final isAvailable = barber['isAvailable'] as bool;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingPage()),
        );
      },
      onLongPress: () {
        _toggleBarberAvailability(index);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.02),
        decoration: BoxDecoration(
          color: isDarkMode ? _cardDark : _cardLight,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Row(
            children: [
              Container(
                width: size.width * 0.22,
                height: size.width * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(barber['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.04),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            barber['name'] as String,
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? _textDark : _textLight,
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _toggleBarberAvailability(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: isAvailable
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isAvailable
                                      ? Icons.check_circle_rounded
                                      : Icons.do_not_disturb_rounded,
                                  color: isAvailable
                                      ? Colors.green
                                      : Colors.red,
                                  size: size.height * 0.012,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  isAvailable ? 'Disponível' : 'Ocupado',
                                  style: GoogleFonts.poppins(
                                    color: isAvailable
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: size.height * 0.01,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      barber['specialty'] as String,
                      style: GoogleFonts.poppins(
                        color: isDarkMode
                            ? _textDark.withOpacity(0.7)
                            : _textLight.withOpacity(0.7),
                        fontSize: size.height * 0.013,
                      ),
                    ),
                    SizedBox(height: size.height * 0.008),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: size.height * 0.016,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          barber['rating'].toString(),
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? _textDark : _textLight,
                            fontSize: size.height * 0.014,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          '(${barber['reviews']} reviews)',
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? _textDark.withOpacity(0.7)
                                : _textLight.withOpacity(0.7),
                            fontSize: size.height * 0.012,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          barber['experience'] as String,
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? _textDark.withOpacity(0.7)
                                : _textLight.withOpacity(0.7),
                            fontSize: size.height * 0.011,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.008),
                    Row(
                      children: [
                        Text(
                          barber['price'] as String,
                          style: GoogleFonts.poppins(
                            color: _primaryColor,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        if (isAvailable)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.006,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [_primaryColor, _secondaryColor],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'AGENDAR',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: size.height * 0.01,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        if (!isAvailable)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.006,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'INDISPONÍVEL',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: size.height * 0.01,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
