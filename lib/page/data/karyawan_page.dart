import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';
import 'package:blackmarket/service/data/karyawan_service.dart';
import 'package:blackmarket/page/data/karyawan_form_page.dart';

class KaryawanPage extends StatefulWidget {
  @override
  _KaryawanPageState createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  late KaryawanService _karyawanService;
  late Box<Karyawan> _karyawanBox;
  late Stream<BoxEvent> _karyawanBoxStream;

  @override
  void initState() {
    super.initState();
    _karyawanBox = Hive.box<Karyawan>('karyawanBox');
    _karyawanService = KaryawanService(_karyawanBox);
    _karyawanBoxStream = _karyawanBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Karyawan'),
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _karyawanBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data karyawan'),
            );
          }

          List<Karyawan> karyawanList = _karyawanBox.values.toList();

          if (karyawanList.isEmpty) {
            return Center(
              child: Text('Tidak ada data karyawan'),
            );
          }

          return ListView.builder(
            itemCount: karyawanList.length,
            itemBuilder: (context, index) {
              Karyawan karyawan = karyawanList[index];
              return ListTile(
                title: Text(karyawan.nama),
                subtitle: Text(karyawan.posisi),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _karyawanService.deleteKaryawan(karyawan.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          KaryawanFormPage(karyawan: karyawan),
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
              builder: (context) => KaryawanFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
