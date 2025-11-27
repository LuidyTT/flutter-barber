// profile_page.dart
// ignore_for_file: unused_field, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_barber/pages/auth_pages.dart' show AuthPage;
import 'package:flutter_barber/service/user_service.dart' show UserService;
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

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
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: isDarkMode ? _textDark : _textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: isDarkMode ? _textDark : _textLight,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Menu Items
            _buildMenuItems(size, isDarkMode),
          ],
        ),
      ),
    );
  }

  // No ProfilePage, atualize o _buildProfileHeader:
  Widget _buildProfileHeader(Size size, bool isDarkMode) {
    return FutureBuilder<Map<String, String>>(
      future: UserService.getUserData(),
      builder: (context, snapshot) {
        final userData = snapshot.data ?? {};
        final firstName = userData['firstName'] ?? '';
        final lastName = userData['lastName'] ?? '';
        final email = userData['email'] ?? '';

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isDarkMode ? _cardDark : _cardLight,
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _primaryColor,
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$firstName $lastName'.trim().isEmpty
                            ? 'Usuário'
                            : '$firstName $lastName',
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? _textDark : _textLight,
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        email.isEmpty ? 'email@exemplo.com' : email,
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? _textDark.withOpacity(0.7)
                              : _textLight.withOpacity(0.7),
                          fontSize: size.height * 0.014,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
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
                          'Membro desde ${DateTime.now().month}/${DateTime.now().year}',
                          style: GoogleFonts.poppins(
                            color: _primaryColor,
                            fontSize: size.height * 0.012,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItems(Size size, bool isDarkMode) {
    final menuItems = [
      {
        'icon': Icons.person_outline,
        'title': 'Editar Perfil',
        'subtitle': 'Altere suas informações',
      },
      {
        'icon': Icons.history,
        'title': 'Histórico de Agendamentos',
        'subtitle': 'Veja seus agendamentos',
      },
      {
        'icon': Icons.credit_card,
        'title': 'Métodos de Pagamento',
        'subtitle': 'Gerencie suas formas de pagamento',
      },
      {
        'icon': Icons.notifications,
        'title': 'Notificações',
        'subtitle': 'Configure suas notificações',
      },
      {
        'icon': Icons.help,
        'title': 'Ajuda & Suporte',
        'subtitle': 'Tire suas dúvidas',
      },
      {
        'icon': Icons.security,
        'title': 'Privacidade',
        'subtitle': 'Controle sua privacidade',
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: menuItems.map((item) {
            return ListTile(
              leading: Container(
                width: size.width * 0.1,
                height: size.width * 0.1,
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: _primaryColor,
                  size: size.height * 0.02,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: GoogleFonts.poppins(
                  color: isDarkMode ? _textDark : _textLight,
                  fontSize: size.height * 0.016,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                item['subtitle'] as String,
                style: GoogleFonts.poppins(
                  color: isDarkMode
                      ? _textDark.withOpacity(0.7)
                      : _textLight.withOpacity(0.7),
                  fontSize: size.height * 0.012,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: isDarkMode
                    ? _textDark.withOpacity(0.5)
                    : _textLight.withOpacity(0.5),
                size: size.height * 0.016,
              ),
              onTap: () {
                // Navegar para a página correspondente
                print('Clicked: ${item['title']}');
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
