import 'package:flutter/material.dart';
import 'package:blackmarket/page/stock/daftar_barang_page.dart';
import 'package:blackmarket/page/stock/kategori_barang_page.dart';
import 'package:blackmarket/page/stock/stock_masuk_page.dart';
import 'package:blackmarket/page/stock/stock_keluar_page.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Daftar Barang'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarBarangPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Kategori Barang'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KategoriBarangPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Stock Masuk'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockMasukPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Stock Keluar'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockKeluarPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
