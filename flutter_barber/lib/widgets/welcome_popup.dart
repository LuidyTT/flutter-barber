// lib/widgets/welcome_popup.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePopup extends StatelessWidget {
  final String userName;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onClose;

  const WelcomePopup({
    super.key,
    required this.userName,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.all(size.width * 0.08),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícone e saudação
              Row(
                children: [
                  Container(
                    width: size.width * 0.12,
                    height: size.width * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.celebration_rounded,
                      color: Colors.white,
                      size: size.width * 0.06,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, $userName! 🎉',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Text(
                          'Estamos felizes em te ver aqui!',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: size.height * 0.014,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),

              // Mensagem de boas-vindas
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Pronto para renovar o visual?',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Explore nossos barbeiros, serviços e agende seu horário com facilidade.',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: size.height * 0.012,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Barra de busca simplificada
              Container(
                height: size.height * 0.05,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white.withOpacity(0.7),
                      size: size.height * 0.02,
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Text(
                        'Buscar barbeiros, serviços, promoções...',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: size.height * 0.013,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Botão de ação
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onClose,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Explorar Agora',
                            style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: size.height * 0.016,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
