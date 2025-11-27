// barbers_page.dart
// ignore_for_file: unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_barber/pages/booking_page.dart' show BookingPage;
import 'package:google_fonts/google_fonts.dart';

class BarbersPage extends StatefulWidget {
  const BarbersPage({super.key});

  @override
  State<BarbersPage> createState() => _BarbersPageState();
}

class _BarbersPageState extends State<BarbersPage> {
  final List<Map<String, dynamic>> _barbers = [
    {
      'id': '1',
      'name': 'Carlos Silva',
      'specialty': 'Especialista em cortes modernos',
      'rating': 4.9,
      'reviews': 127,
      'experience': '5 anos',
      'price': 'R\$ 35,00',
      'image':
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&h=200&fit=crop',
      'services': ['Corte Social', 'Degradê', 'Navalhado', 'Buzz Cut'],
      'isAvailable': true,
      'distance': '1.2 km',
    },
    {
      'id': '2',
      'name': 'Miguel Santos',
      'specialty': 'Mestre em barbas e bigodes',
      'rating': 4.8,
      'reviews': 89,
      'experience': '7 anos',
      'price': 'R\$ 40,00',
      'image':
          'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?w=200&h=200&fit=crop',
      'services': [
        'Barba Tradicional',
        'Bigode',
        'Design de Barba',
        'Hidratação',
      ],
      'isAvailable': true,
      'distance': '0.8 km',
    },
    {
      'id': '3',
      'name': 'Ricardo Lima',
      'specialty': 'Cortes clássicos e vintage',
      'rating': 4.7,
      'reviews': 156,
      'experience': '10 anos',
      'price': 'R\$ 30,00',
      'image':
          'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=200&h=200&fit=crop',
      'services': ['Corte Clássico', 'Pompadour', 'Side Part', 'Undercut'],
      'isAvailable': false,
      'distance': '2.1 km',
    },
    {
      'id': '4',
      'name': 'André Costa',
      'specialty': 'Especialista em coloração',
      'rating': 4.6,
      'reviews': 73,
      'experience': '4 anos',
      'price': 'R\$ 45,00',
      'image':
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?w=200&h=200&fit=crop',
      'services': ['Coloração', 'Luzes', 'Mechas', 'Reflexos'],
      'isAvailable': true,
      'distance': '1.5 km',
    },
    {
      'id': '5',
      'name': 'Felipe Oliveira',
      'specialty': 'Cortes urbanos e modernos',
      'rating': 4.9,
      'reviews': 94,
      'experience': '3 anos',
      'price': 'R\$ 38,00',
      'image':
          'https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?w=200&h=200&fit=crop',
      'services': ['Fade', 'Texturizado', 'Corte Afro', 'Design'],
      'isAvailable': true,
      'distance': '0.5 km',
    },
  ];

  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _accentColor = const Color(0xffFF6584);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _hintColor = const Color(0xffA0AEC0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  List<Map<String, dynamic>> get _filteredBarbers {
    List<Map<String, dynamic>> filtered = _barbers;

    // Filtro por disponibilidade
    if (_selectedFilter == 'available') {
      filtered = filtered
          .where((barber) => barber['isAvailable'] == true)
          .toList();
    } else if (_selectedFilter == 'top_rated') {
      filtered = filtered.where((barber) => barber['rating'] >= 4.8).toList();
    }

    // Filtro por busca
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((barber) {
        final name = barber['name'].toString().toLowerCase();
        final specialty = barber['specialty'].toString().toLowerCase();
        final searchText = _searchController.text.toLowerCase();
        return name.contains(searchText) || specialty.contains(searchText);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode ? _darkBackground : _lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? _textDark : _textLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nossos Barbeiros',
          style: GoogleFonts.poppins(
            color: isDarkMode ? _textDark : _textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and Filters
          _buildSearchAndFilters(size, isDarkMode),
          SizedBox(height: size.height * 0.02),

          // Barbers List
          Expanded(
            child: _filteredBarbers.isEmpty
                ? _buildEmptyState(size, isDarkMode)
                : _buildBarbersList(size, isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(Size size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            decoration: BoxDecoration(
              color: isDarkMode ? _cardDark : _cardLight,
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
                Icon(Icons.search, color: _primaryColor),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar barbeiros...',
                      hintStyle: TextStyle(
                        color: isDarkMode
                            ? _textDark.withOpacity(0.5)
                            : _textLight.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear, size: size.height * 0.02),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),

          // Filter Chips
          SizedBox(
            height: size.height * 0.05,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Todos', 'all', size, isDarkMode),
                SizedBox(width: size.width * 0.02),
                _buildFilterChip('Disponíveis', 'available', size, isDarkMode),
                SizedBox(width: size.width * 0.02),
                _buildFilterChip(
                  'Melhores Avaliados',
                  'top_rated',
                  size,
                  isDarkMode,
                ),
                SizedBox(width: size.width * 0.02),
                _buildFilterChip('Mais Próximos', 'nearby', size, isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String value,
    Size size,
    bool isDarkMode,
  ) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? _primaryColor
              : (isDarkMode ? _cardDark : _cardLight),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? _primaryColor
                : (isDarkMode
                      ? _textDark.withOpacity(0.3)
                      : _textLight.withOpacity(0.3)),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected
                ? Colors.white
                : (isDarkMode ? _textDark : _textLight),
            fontSize: size.height * 0.014,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBarbersList(Size size, bool isDarkMode) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      itemCount: _filteredBarbers.length,
      itemBuilder: (context, index) {
        final barber = _filteredBarbers[index];
        return _buildBarberCard(barber, size, isDarkMode);
      },
    );
  }

  Widget _buildBarberCard(
    Map<String, dynamic> barber,
    Size size,
    bool isDarkMode,
  ) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barber Photo
                Stack(
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
                    if (!barber['isAvailable'])
                      Container(
                        width: size.width * 0.22,
                        height: size.width * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            'INDISPONÍVEL',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: size.height * 0.01,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: size.width * 0.04),

                // Barber Info
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              barber['distance'] as String,
                              style: GoogleFonts.poppins(
                                color: _primaryColor,
                                fontSize: size.height * 0.012,
                                fontWeight: FontWeight.w500,
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
                          fontSize: size.height * 0.014,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: size.height * 0.016,
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            barber['rating'].toString(),
                            style: GoogleFonts.poppins(
                              color: isDarkMode ? _textDark : _textLight,
                              fontSize: size.height * 0.014,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
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
                            barber['price'] as String,
                            style: GoogleFonts.poppins(
                              color: _primaryColor,
                              fontSize: size.height * 0.016,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        '${barber['experience']} de experiência',
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? _textDark.withOpacity(0.7)
                              : _textLight.withOpacity(0.7),
                          fontSize: size.height * 0.012,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),

            // Services
            SizedBox(
              height: size.height * 0.04,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: (barber['services'] as List).map<Widget>((service) {
                  return Container(
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkMode ? _darkBackground : _lightBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDarkMode
                            ? _textDark.withOpacity(0.3)
                            : _textLight.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      service,
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? _textDark : _textLight,
                        fontSize: size.height * 0.012,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: size.height * 0.015),

            // Action Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (barber['isAvailable'])
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: barber['isAvailable']
                        ? LinearGradient(
                            colors: [_primaryColor, _secondaryColor],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : null,
                    color: barber['isAvailable']
                        ? null
                        : Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: barber['isAvailable']
                        ? () {
                            // Navegar para agendamento com este barbeiro
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BookingPage(),
                              ),
                            );
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.012,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      barber['isAvailable']
                          ? 'Agendar Horário'
                          : 'Indisponível',
                      style: GoogleFonts.poppins(
                        color: barber['isAvailable']
                            ? Colors.white
                            : (isDarkMode
                                  ? _textDark.withOpacity(0.5)
                                  : _textLight.withOpacity(0.5)),
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Size size, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.content_paste_search,
            size: size.height * 0.1,
            color: isDarkMode
                ? _textDark.withOpacity(0.3)
                : _textLight.withOpacity(0.3),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            'Nenhum barbeiro encontrado',
            style: GoogleFonts.poppins(
              color: isDarkMode ? _textDark : _textLight,
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Tente ajustar os filtros ou termos de busca',
            style: GoogleFonts.poppins(
              color: isDarkMode
                  ? _textDark.withOpacity(0.7)
                  : _textLight.withOpacity(0.7),
              fontSize: size.height * 0.014,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _secondaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'all';
                      _searchController.clear();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Limpar Filtros',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
