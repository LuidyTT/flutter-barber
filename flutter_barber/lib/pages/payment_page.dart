// payment_page.dart
// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = 'credit_card';
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

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
          'Pagamento',
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
            // Order Summary
            _buildOrderSummary(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Payment Methods
            _buildPaymentMethods(size, isDarkMode),
            SizedBox(height: size.height * 0.03),

            // Card Form
            if (_selectedMethod == 'credit_card')
              _buildCardForm(size, isDarkMode),
            SizedBox(height: size.height * 0.05),

            // Pay Button
            _buildPayButton(size),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(Size size, bool isDarkMode) {
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
              'Resumo do Pedido',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _buildSummaryRow('Corte de Cabelo', 'R\$ 35,00', size, isDarkMode),
            _buildSummaryRow('Barba', 'R\$ 25,00', size, isDarkMode),
            _buildSummaryRow('Taxa de serviço', 'R\$ 5,00', size, isDarkMode),
            Divider(
              color: isDarkMode
                  ? _textDark.withOpacity(0.3)
                  : _textLight.withOpacity(0.3),
            ),
            _buildSummaryRow(
              'Total',
              'R\$ 65,00',
              size,
              isDarkMode,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value,
    Size size,
    bool isDarkMode, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: isDarkMode
                  ? _textDark.withOpacity(isTotal ? 1 : 0.7)
                  : _textLight.withOpacity(isTotal ? 1 : 0.7),
              fontSize: size.height * (isTotal ? 0.018 : 0.015),
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: isTotal
                  ? _primaryColor
                  : (isDarkMode
                        ? _textDark.withOpacity(0.7)
                        : _textLight.withOpacity(0.7)),
              fontSize: size.height * (isTotal ? 0.018 : 0.015),
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(Size size, bool isDarkMode) {
    final methods = [
      {
        'id': 'credit_card',
        'name': 'Cartão de Crédito',
        'icon': Icons.credit_card,
      },
      {
        'id': 'debit_card',
        'name': 'Cartão de Débito',
        'icon': Icons.credit_card,
      },
      {'id': 'pix', 'name': 'PIX', 'icon': Icons.qr_code},
      {'id': 'cash', 'name': 'Dinheiro', 'icon': Icons.money},
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
              'Método de Pagamento',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ...methods.map((method) {
              final isSelected = method['id'] == _selectedMethod;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedMethod = method['id'] as String),
                child: Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.01),
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
                      Icon(
                        method['icon'] as IconData,
                        color: isSelected
                            ? _primaryColor
                            : (isDarkMode ? _textDark : _textLight),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Text(
                        method['name'] as String,
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? _textDark : _textLight,
                          fontSize: size.height * 0.016,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: _primaryColor,
                          size: size.height * 0.02,
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

  Widget _buildCardForm(Size size, bool isDarkMode) {
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
              'Cartão de Crédito',
              style: GoogleFonts.poppins(
                color: isDarkMode ? _textDark : _textLight,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _buildCardField(
              'Número do Cartão',
              _cardController,
              size,
              isDarkMode,
              Icons.credit_card,
            ),
            SizedBox(height: size.height * 0.02),
            _buildCardField(
              'Nome no Cartão',
              _nameController,
              size,
              isDarkMode,
              Icons.person,
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Expanded(
                  child: _buildCardField(
                    'Validade',
                    _expiryController,
                    size,
                    isDarkMode,
                    Icons.calendar_today,
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: _buildCardField(
                    'CVV',
                    _cvvController,
                    size,
                    isDarkMode,
                    Icons.lock,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardField(
    String label,
    TextEditingController controller,
    Size size,
    bool isDarkMode,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(
        color: isDarkMode ? _textDark : _textLight,
        fontSize: size.height * 0.016,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode
              ? _textDark.withOpacity(0.7)
              : _textLight.withOpacity(0.7),
        ),
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? _textDark.withOpacity(0.3)
                : _textLight.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? _textDark.withOpacity(0.3)
                : _textLight.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryColor),
        ),
      ),
    );
  }

  Widget _buildPayButton(Size size) {
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
              // Payment processing logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pagamento realizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Pagar R\$ 65,00',
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
}
