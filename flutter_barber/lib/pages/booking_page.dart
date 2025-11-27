// booking_page.dart
// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  String _selectedService = 'Corte de Cabelo';
  String _selectedBarber = 'Carlos Silva';

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? _textDark : _textLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Agendar Serviço',
          style: GoogleFonts.poppins(
            color: isDarkMode ? _textDark : _textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Selection
            _buildServiceCard(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Barber Selection
            _buildBarberCard(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Date Selection
            _buildDateCard(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Time Selection
            _buildTimeCard(size, isDarkMode),
            SizedBox(height: size.height * 0.05),

            // Confirm Button
            _buildConfirmButton(size),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Size size, bool isDarkMode) {
    final services = [
      'Corte de Cabelo',
      'Barba',
      'Sobrancelha',
      'Corte + Barba',
      'Limpeza de Pele',
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serviço',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Wrap(
              spacing: size.width * 0.03,
              runSpacing: size.height * 0.015,
              children: services.map((service) {
                final isSelected = service == _selectedService;
                return GestureDetector(
                  onTap: () => setState(() => _selectedService = service),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.012,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? _primaryColor
                            : isDarkMode
                            ? _textDark.withOpacity(0.3)
                            : _textLight.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      service,
                      style: GoogleFonts.poppins(
                        color: isSelected
                            ? Colors.white
                            : (isDarkMode ? _textDark : _textLight),
                        fontSize: size.height * 0.015,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberCard(Size size, bool isDarkMode) {
    final barbers = [
      {'name': 'Carlos Silva', 'rating': 4.9, 'specialty': 'Cortes Modernos'},
      {'name': 'Miguel Santos', 'rating': 4.8, 'specialty': 'Barbas'},
      {'name': 'Ricardo Lima', 'rating': 4.7, 'specialty': 'Cortes Clássicos'},
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escolha o Barbeiro',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ...barbers.map((barber) {
              final isSelected = barber['name'] == _selectedBarber;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedBarber = barber['name'] as String),
                child: Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.015),
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected ? _primaryColor : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.12,
                        height: size.width * 0.12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              barber['name'] as String,
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? _textDark : _textLight,
                                fontSize: size.height * 0.016,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              barber['specialty'] as String,
                              style: GoogleFonts.poppins(
                                color: isDarkMode
                                    ? _textDark.withOpacity(0.7)
                                    : _textLight.withOpacity(0.7),
                                fontSize: size.height * 0.014,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              color: isDarkMode ? _textDark : _textLight,
                              fontSize: size.height * 0.014,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(Size size, bool isDarkMode) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: isDarkMode ? _darkBackground : _lightBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: _primaryColor),
                    SizedBox(width: size.width * 0.03),
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? _textDark : _textLight,
                        fontSize: size.height * 0.016,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard(Size size, bool isDarkMode) {
    final times = [
      '09:00',
      '10:00',
      '11:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: isDarkMode ? _cardDark : _cardLight,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horário',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Wrap(
              spacing: size.width * 0.03,
              runSpacing: size.height * 0.015,
              children: times.map((time) {
                final isSelected =
                    time ==
                    '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
                return GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.012,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? _primaryColor
                            : isDarkMode
                            ? _textDark.withOpacity(0.3)
                            : _textLight.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      time,
                      style: GoogleFonts.poppins(
                        color: isSelected
                            ? Colors.white
                            : (isDarkMode ? _textDark : _textLight),
                        fontSize: size.height * 0.015,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(Size size) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor, _secondaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            onPressed: () {
              // Confirm booking logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Agendamento confirmado com $_selectedBarber'),
                  backgroundColor: _primaryColor,
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Confirmar Agendamento',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }
}
