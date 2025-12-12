import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Pesanan',
      currentIndex: 2,
      body: const Center(child: Text('Halaman Pesanan (placeholder)')),
    );
  }
}
