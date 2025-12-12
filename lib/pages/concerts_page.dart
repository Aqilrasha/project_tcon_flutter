import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class ConcertsPage extends StatelessWidget {
  const ConcertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Konser',
      currentIndex: 3,
      body: const Center(child: Text('Halaman Konser (placeholder)')),
    );
  }
}
