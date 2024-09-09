import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/kategori_model.dart';
import 'package:blackmarket/service/stock/kategori_service.dart';
import 'package:blackmarket/page/stock/kategori_barang_form_page.dart';

class KategoriBarangPage extends StatefulWidget {
  @override
  _KategoriBarangPageState createState() => _KategoriBarangPageState();
}

class _KategoriBarangPageState extends State<KategoriBarangPage> {
  late KategoriService _kategoriService;
  late Box<Kategori> _kategoriBox;
  late Stream<BoxEvent> _kategoriBoxStream;

  @override
  void initState() {
    super.initState();
    _kategoriBox = Hive.box<Kategori>('kategoriBox');
    _kategoriService = KategoriService(_kategoriBox);
    _kategoriBoxStream = _kategoriBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Barang'),
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _kategoriBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data kategori'),
            );
          }

          List<Kategori> kategoriList = _kategoriBox.values.toList();

          if (kategoriList.isEmpty) {
            return Center(
              child: Text('Tidak ada data kategori'),
            );
          }

          return ListView.builder(
            itemCount: kategoriList.length,
            itemBuilder: (context, index) {
              Kategori kategori = kategoriList[index];
              return ListTile(
                title: Text(kategori.nama),
                subtitle: Text(kategori.deskripsi),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _kategoriService.deleteKategori(kategori.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          KategoriBarangFormPage(kategori: kategori),
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
              builder: (context) => KategoriBarangFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
