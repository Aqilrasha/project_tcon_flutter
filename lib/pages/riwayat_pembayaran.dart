import 'package:flutter/material.dart';
import '../widgets/tcon_scaffold.dart';

class RiwayatPembayaranPage extends StatefulWidget {
  const RiwayatPembayaranPage({super.key});

  @override
  State<RiwayatPembayaranPage> createState() => _RiwayatPembayaranPageState();
}

class _RiwayatPembayaranPageState extends State<RiwayatPembayaranPage> {
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    transactions = [
      {
        'id': 'TCN-20251003-A8X9',
        'title': 'Konser K-Pop Fest 2025',
        'status': 'SELESAI',
        'statusColor': Colors.green,
        'transacDate': '3 Oktober 2025, 05:06 WIB',
        'method': 'QRIS',
        'quantity': '2 Tiket (Reguler)',
        'total': 'Rp 450.000',
        'detail': {
          'date': '12 Desember 2025',
          'location': 'Stadion Gelora Bangsa',
          'category': 'Reguler',
          'unitPrice': 'Rp 200.000',
          'subtotal': 'Rp 400.000',
          'fee': 'Rp 50.000',
          'totalPaid': 'Rp 450.000',
          'methodDetail': 'QRIS (Lunas)',
          'paidTime': '3 Oktober 2025, 05:06 WIB',
        },
      },
      {
        'id': 'TCN-20250915-C7L3',
        'title': 'Konser Jazz on the Beach',
        'status': 'MENUNGGU PEMBAYARAN',
        'statusColor': Colors.amber,
        'transacDate': '15 September 2025, 18:30 WIB',
        'method': 'Transfer Bank',
        'quantity': '1 Tiket (VIP)',
        'total': 'Rp 850.000',
        'detail': {
          'date': '20 November 2025',
          'location': 'Pantai Indah',
          'category': 'VIP',
          'unitPrice': 'Rp 800.000',
          'subtotal': 'Rp 800.000',
          'fee': 'Rp 50.000',
          'totalPaid': 'Rp 850.000',
          'methodDetail': 'Transfer Bank (Awaiting)',
          'paidTime': 'N/A',
        },
      },
      {
        'id': 'TCN-20250801-D9Z1',
        'title': 'Tiket Meet & Greet Idol',
        'status': 'DIBATALKAN',
        'statusColor': Colors.red,
        'transacDate': '1 Agustus 2025, 10:00 WIB',
        'method': 'E-Wallet',
        'quantity': '1 Tiket (Premium)',
        'total': 'Rp 1.500.000',
        'detail': null,
      },
    ];
  }

  void _showDetail(Map<String, dynamic> tx) {
    final detail = tx['detail'];
    if (detail == null) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Tiket ${tx['title']}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tanggal Konser: ${detail['date']}'),
              const SizedBox(height: 8),
              Text('Lokasi: ${detail['location']}'),
              const SizedBox(height: 8),
              Text('Kategori: ${detail['category']}'),
              const Divider(),
              Text('Harga Satuan: ${detail['unitPrice']}'),
              Text('Subtotal: ${detail['subtotal']}'),
              Text('Biaya Layanan: ${detail['fee']}'),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL DIBAYAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    detail['totalPaid'],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Status Pembayaran: ${detail['methodDetail']}'),
              Text('Waktu Pembayaran: ${detail['paidTime']}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showPayment(String id) {
    final tx = transactions.firstWhere((t) => t['id'] == id);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lanjutkan Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tx['title']),
            const SizedBox(height: 8),
            Text('Jumlah: ${tx['quantity']} - Total: ${tx['total']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tx['status'] = 'SELESAI';
                tx['statusColor'] = Colors.green;
                if (tx['detail'] != null) {
                  tx['detail']['methodDetail'] =
                      tx['detail']['methodDetail']
                          .toString()
                          .split('(')[0]
                          .trim() +
                      ' (Lunas)';
                  tx['detail']['paidTime'] = DateTime.now().toString();
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Bayar Sekarang'),
          ),
        ],
      ),
    );
  }

  void _confirmCancel(String id) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembatalan'),
        content: const Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                final idx = transactions.indexWhere((t) => t['id'] == id);
                if (idx != -1) {
                  transactions[idx]['status'] = 'DIBATALKAN';
                  transactions[idx]['statusColor'] = Colors.red;
                  transactions[idx]['detail'] = null;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> tx) {
    final statusColor = tx['statusColor'] as Color;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID Transaksi: ${tx['id']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tx['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tanggal Transaksi',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        tx['transacDate'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Metode Pembayaran',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        tx['method'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jumlah Tiket',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        tx['quantity'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        tx['total'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (tx['status'] == 'SELESAI')
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showDetail(tx),
                  child: const Text('Lihat Detail Tiket'),
                ),
              ),
            if (tx['status'] == 'MENUNGGU PEMBAYARAN')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _confirmCancel(tx['id'] as String),
                    child: const Text(
                      'Batalkan Pesanan',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _showPayment(tx['id'] as String),
                    child: const Text('Lanjutkan Bayar'),
                  ),
                ],
              ),
            if (tx['status'] == 'DIBATALKAN')
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Dibatalkan',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TconScaffold(
      title: 'Pesanan',
      currentIndex: 2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Riwayat Pembelian Tiket Anda',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${transactions.length} events tersedia',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) => _buildCard(transactions[index]),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
