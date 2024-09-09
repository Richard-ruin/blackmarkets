import 'package:flutter/material.dart';
import 'package:blackmarket/page/data/karyawan_page.dart';
import 'package:blackmarket/page/data/supplier_page.dart';
import 'package:blackmarket/page/data/pelanggan_page.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Data Karyawan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KaryawanPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Data Supplier'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupplierPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Data Pelanggan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PelangganPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
