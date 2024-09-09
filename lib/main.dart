import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blackmarket/page/penjualan/penjualan_page.dart';
import 'package:blackmarket/page/pembelian/pembelian_page.dart';
import 'package:blackmarket/page/stock/stock_page.dart';
import 'package:blackmarket/page/data/data_page.dart';
import 'package:blackmarket/page/laporan/laporan_penjualan_page.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/penjualan/penjualan_model.dart';
import 'package:blackmarket/model/stock/stock_masuk_model.dart';
import 'package:blackmarket/model/stock/stock_keluar_model.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';
import 'package:blackmarket/model/data/pelanggan_model.dart';
import 'package:blackmarket/model/data/supplier_model.dart';
import 'package:blackmarket/model/stock/kategori_model.dart';
import 'package:blackmarket/model/laporan/laporan_penjualan_model.dart';
import 'package:blackmarket/model/pembelian/pembelian_model.dart';
import 'package:blackmarket/splash_screen.dart';
import 'package:blackmarket/page/login/login_page.dart';
import 'package:blackmarket/model/laporan/laporan_penjualan_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BarangAdapter());
  Hive.registerAdapter(PenjualanAdapter());
  Hive.registerAdapter(StockMasukAdapter());
  Hive.registerAdapter(StockKeluarAdapter());
  Hive.registerAdapter(KaryawanAdapter());
  Hive.registerAdapter(PelangganAdapter());
  Hive.registerAdapter(SupplierAdapter());
  Hive.registerAdapter(KategoriAdapter());
  Hive.registerAdapter(LaporanPenjualanAdapter());
  Hive.registerAdapter(PembelianAdapter());

  await Hive.openBox<Barang>('barangBox');
  await Hive.openBox<Penjualan>('penjualanBox');
  await Hive.openBox<StockMasuk>('stockMasukBox');
  await Hive.openBox<StockKeluar>('stockKeluarBox');
  await Hive.openBox<Karyawan>('karyawanBox');
  await Hive.openBox<Pelanggan>('pelangganBox');
  await Hive.openBox<Supplier>('supplierBox');
  await Hive.openBox<Kategori>('kategoriBox');
  await Hive.openBox<LaporanPenjualan>('laporanPenjualanBox');
  await Hive.openBox<Pembelian>('pembelianBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(), // Add route to MyHomePage
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  final _pageOptions = [
    PenjualanPage(),
    PembelianPage(),
    StockPage(),
    DataPage(),
    LaporanPenjualanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageOptions[_selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Penjualan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Pembelian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Laporan Laba Rugi',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
