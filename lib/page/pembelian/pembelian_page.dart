import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/pembelian/pembelian_model.dart';
import 'package:blackmarket/service/pembelian/pembelian_service.dart';
import 'package:blackmarket/page/pembelian/pembelian_form_page.dart';

class PembelianPage extends StatefulWidget {
  @override
  _PembelianPageState createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  late PembelianService _pembelianService;
  late Box<Pembelian> _pembelianBox;
  late Stream<BoxEvent> _pembelianBoxStream;

  @override
  void initState() {
    super.initState();
    _pembelianBox = Hive.box<Pembelian>('pembelianBox');
    _pembelianService = PembelianService();
    _pembelianBoxStream = _pembelianBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pembelian'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PembelianFormPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _pembelianBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data pembelian'),
            );
          }

          List<Pembelian> pembelianList = _pembelianBox.values.toList();

          if (pembelianList.isEmpty) {
            return Center(
              child: Text('Tidak ada data pembelian'),
            );
          }

          return ListView.builder(
            itemCount: pembelianList.length,
            itemBuilder: (context, index) {
              Pembelian pembelian = pembelianList[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('ID Pembelian: ${pembelian.id}'),
                  subtitle:
                      Text('Total Pembelian: ${pembelian.totalPembelian}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PembelianFormPage(pembelian: pembelian),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
