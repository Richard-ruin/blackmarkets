import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/service/stock/barang_service.dart';
import 'package:blackmarket/page/stock/barang_form_page.dart';

class DaftarBarangPage extends StatefulWidget {
  @override
  _DaftarBarangPageState createState() => _DaftarBarangPageState();
}

class _DaftarBarangPageState extends State<DaftarBarangPage> {
  late BarangService _barangService;
  late Box<Barang> _barangBox;
  late Stream<BoxEvent> _barangBoxStream;

  @override
  void initState() {
    super.initState();
    _barangBox = Hive.box<Barang>('barangBox');
    _barangService = BarangService(_barangBox);
    _barangBoxStream = _barangBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Barang'),
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _barangBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data barang'),
            );
          }

          List<Barang> barangList = _barangBox.values.toList();

          if (barangList.isEmpty) {
            return Center(
              child: Text('Tidak ada data barang'),
            );
          }

          return ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              Barang barang = barangList[index];
              return ListTile(
                title: Text(barang.nama),
                subtitle: Text('Stok: ${barang.stok} | Harga: ${barang.harga}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _barangService.deleteBarang(barang.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarangFormPage(barang: barang),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BarangFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
