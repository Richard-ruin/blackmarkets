import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blackmarket/model/penjualan/penjualan_model.dart';
import 'package:blackmarket/service/penjualan/penjualan_service.dart';
import 'package:blackmarket/service/laporan/laporan_penjualan_service.dart';
import 'package:blackmarket/model/laporan/laporan_penjualan_model.dart';
import 'package:blackmarket/page/penjualan/penjualan_page.dart';

class PrintPage extends StatelessWidget {
  final List<Penjualan> listPenjualan;
  final String namaPembeli;
  final double pembayaran;

  PrintPage({
    required this.listPenjualan,
    required this.namaPembeli,
    required this.pembayaran,
  });

  double _calculateTotal() {
    return listPenjualan.fold(
        0, (sum, item) => sum + (item.barang.harga * item.jumlah));
  }

  double _calculateKembalian() {
    return pembayaran - _calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'BLACKMARKET',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text('Sukajadi, Sarijadi Block 7/90'),
            ),
            Center(
              child: Text('Telp.(0729) 23458 / 081274837474'),
            ),
            Divider(),
            _buildInfoRow(
                'Tgl.Trans', DateFormat('d/M/yyyy').format(DateTime.now())),
            _buildInfoRow('Jam', DateFormat('HH:mm:ss').format(DateTime.now())),
            _buildInfoRow(
                'No Faktur', 'I/SL-${DateTime.now().millisecondsSinceEpoch}'),
            _buildInfoRow('Pelanggan', namaPembeli),
            _buildInfoRow('Kasir', 'Eka'),
            Divider(),
            _buildTableHeader(),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: listPenjualan.length,
                itemBuilder: (context, index) {
                  final penjualan = listPenjualan[index];
                  return _buildTableRow(penjualan);
                },
              ),
            ),
            Divider(),
            _buildInfoRow('Jumlah', '${listPenjualan.length} Item'),
            _buildInfoRow(
                'Total',
                NumberFormat.currency(locale: 'id', symbol: 'Rp')
                    .format(_calculateTotal())),
            _buildInfoRow(
                'Pembayaran',
                NumberFormat.currency(locale: 'id', symbol: 'Rp')
                    .format(pembayaran)),
            _buildInfoRow(
                'Kembalian',
                NumberFormat.currency(locale: 'id', symbol: 'Rp')
                    .format(_calculateKembalian())),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Kembali'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Menyimpan laporan penjualan
                    final laporanPenjualanService = LaporanPenjualanService();
                    await laporanPenjualanService.addLaporanPenjualan(
                      LaporanPenjualan(
                        tanggal: DateTime.now(),
                        jumlahPembeli: 1,
                        totalQty: listPenjualan
                            .map((e) => e.jumlah)
                            .reduce((a, b) => a + b),
                        totalHarga: _calculateTotal(),
                      ),
                    );
                    // Menutup halaman PrintPage setelah menyimpan
                    Navigator.of(context).pop();
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Nama')),
        Expanded(flex: 1, child: Text('Qty')),
        Expanded(flex: 2, child: Text('Harga')),
        Expanded(flex: 1, child: Text('Total')),
      ],
    );
  }

  Widget _buildTableRow(Penjualan penjualan) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(penjualan.barang.nama)),
        Expanded(flex: 1, child: Text(penjualan.jumlah.toString())),
        Expanded(
          flex: 2,
          child: Text(NumberFormat.currency(locale: 'id', symbol: 'Rp')
              .format(penjualan.barang.harga)),
        ),
        Expanded(
          flex: 1,
          child: Text(NumberFormat.currency(locale: 'id', symbol: 'Rp')
              .format(penjualan.barang.harga * penjualan.jumlah)),
        ),
      ],
    );
  }
}
