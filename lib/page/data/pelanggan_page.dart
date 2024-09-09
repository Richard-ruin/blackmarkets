import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/pelanggan_model.dart';
import 'package:blackmarket/service/data/pelanggan_service.dart';
import 'package:blackmarket/page/data/pelanggan_form_page.dart';

class PelangganPage extends StatefulWidget {
  @override
  _PelangganPageState createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  late PelangganService _pelangganService;
  late Box<Pelanggan> _pelangganBox;
  late Stream<BoxEvent> _pelangganBoxStream;

  @override
  void initState() {
    super.initState();
    _pelangganBox = Hive.box<Pelanggan>('pelangganBox');
    _pelangganService = PelangganService(_pelangganBox);
    _pelangganBoxStream = _pelangganBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pelanggan'),
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _pelangganBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data pelanggan'),
            );
          }

          List<Pelanggan> pelangganList = _pelangganBox.values.toList();

          if (pelangganList.isEmpty) {
            return Center(
              child: Text('Tidak ada data pelanggan'),
            );
          }

          return ListView.builder(
            itemCount: pelangganList.length,
            itemBuilder: (context, index) {
              Pelanggan pelanggan = pelangganList[index];
              return ListTile(
                title: Text(pelanggan.nama),
                subtitle: Text(pelanggan.alamat),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _pelangganService.deletePelanggan(pelanggan.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PelangganFormPage(pelanggan: pelanggan),
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
              builder: (context) => PelangganFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
