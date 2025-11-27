// cart_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_barber/pages/payment_page.dart' show PaymentPage;
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Corte de Cabelo',
      'barber': 'Carlos Silva',
      'price': 35.00,
      'duration': '30 min',
      'quantity': 1,
    },
    {
      'name': 'Barba',
      'barber': 'Carlos Silva',
      'price': 25.00,
      'duration': '20 min',
      'quantity': 1,
    },
  ];

  final Color _primaryColor = const Color(0xff6C63FF);
  final Color _secondaryColor = const Color(0xff4A90E2);
  final Color _lightBackground = const Color(0xffF8F9FA);
  final Color _darkBackground = const Color(0xff1A1D21);
  final Color _textLight = const Color(0xff2D3748);
  final Color _textDark = const Color(0xffE2E8F0);
  final Color _cardLight = Colors.white;
  final Color _cardDark = const Color(0xff2D3748);

  double get _totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int),
    );
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
          'Carrinho',
          style: GoogleFonts.poppins(
            color: isDarkMode ? _textDark : _textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? _buildEmptyCart(size, isDarkMode)
                : _buildCartItems(size, isDarkMode),
          ),
          if (_cartItems.isNotEmpty) _buildTotalSection(size, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(Size size, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: size.height * 0.1,
            color: isDarkMode
                ? _textDark.withOpacity(0.3)
                : _textLight.withOpacity(0.3),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            'Carrinho Vazio',
            style: GoogleFonts.poppins(
              color: isDarkMode ? _textDark : _textLight,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Adicione serviços ao carrinho',
            style: GoogleFonts.poppins(
              color: isDarkMode
                  ? _textDark.withOpacity(0.7)
                  : _textLight.withOpacity(0.7),
              fontSize: size.height * 0.016,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(Size size, bool isDarkMode) {
    return ListView.builder(
      padding: EdgeInsets.all(size.width * 0.04),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: size.height * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isDarkMode ? _cardDark : _cardLight,
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              children: [
                // Service Icon
                Container(
                  width: size.width * 0.15,
                  height: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.cut, color: _primaryColor),
                ),
                SizedBox(width: size.width * 0.04),

                // Service Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] as String,
                        style: GoogleFonts.poppins(
                          color: isDarkMode ? _textDark : _textLight,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        item['barber'] as String,
                        style: GoogleFonts.poppins(
                          color: isDarkMode
                              ? _textDark.withOpacity(0.7)
                              : _textLight.withOpacity(0.7),
                          fontSize: size.height * 0.014,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        'Duração: ${item['duration']}',
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

                // Quantity and Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$${item['price'].toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: _primaryColor,
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: size.height * 0.02),
                          onPressed: () => _updateQuantity(index, -1),
                          style: IconButton.styleFrom(
                            backgroundColor: isDarkMode
                                ? _darkBackground
                                : _lightBackground,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          item['quantity'].toString(),
                          style: GoogleFonts.poppins(
                            color: isDarkMode ? _textDark : _textLight,
                            fontSize: size.height * 0.016,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        IconButton(
                          icon: Icon(Icons.add, size: size.height * 0.02),
                          onPressed: () => _updateQuantity(index, 1),
                          style: IconButton.styleFrom(
                            backgroundColor: isDarkMode
                                ? _darkBackground
                                : _lightBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalSection(Size size, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: isDarkMode ? _cardDark : _cardLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: GoogleFonts.poppins(
                  color: isDarkMode ? _textDark : _textLight,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'R\$${_totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: _primaryColor,
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Container(
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
                    // Checkout logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentPage(),
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
                    'Finalizar Compra',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: size.height * 0.018,
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

  void _updateQuantity(int index, int change) {
    setState(() {
      final newQuantity = (_cartItems[index]['quantity'] as int) + change;
      if (newQuantity > 0) {
        _cartItems[index]['quantity'] = newQuantity;
      } else {
        _cartItems.removeAt(index);
      }
    });
  }
}
