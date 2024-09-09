import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';
import 'package:blackmarket/model/stock/stock_keluar_model.dart';
import 'package:blackmarket/service/stock/stock_keluar_service.dart';

class StockKeluarFormPage extends StatefulWidget {
  final StockKeluar? stockKeluar;

  StockKeluarFormPage({this.stockKeluar});

  @override
  _StockKeluarFormPageState createState() => _StockKeluarFormPageState();
}

class _StockKeluarFormPageState extends State<StockKeluarFormPage> {
  final _formKey = GlobalKey<FormState>();
  late StockKeluarService _stockKeluarService;

  late String _id;
  late Barang _barang;
  late int _jumlah;
  late DateTime _tanggalKeluar;
  late Karyawan _karyawan;

  @override
  void initState() {
    super.initState();
    _stockKeluarService =
        StockKeluarService(Hive.box<StockKeluar>('stockKeluarBox'));

    if (widget.stockKeluar != null) {
      _id = widget.stockKeluar!.id;
      _barang = widget.stockKeluar!.barang;
      _jumlah = widget.stockKeluar!.jumlah;
      _tanggalKeluar = widget.stockKeluar!.tanggalKeluar;
      _karyawan = widget.stockKeluar!.karyawan;
    } else {
      _id = '';
      _barang = Hive.box<Barang>('barangBox').values.first;
      _jumlah = 0;
      _tanggalKeluar = DateTime.now();
      _karyawan = Hive.box<Karyawan>('karyawanBox').values.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockKeluar == null
            ? 'Tambah Stok Keluar'
            : 'Edit Stok Keluar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Stok Keluar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _id = value!;
                },
              ),
              DropdownButtonFormField<Barang>(
                value: _barang,
                decoration: InputDecoration(labelText: 'Barang'),
                items: Hive.box<Barang>('barangBox')
                    .values
                    .map((barang) => DropdownMenuItem(
                          value: barang,
                          child: Text(barang.nama),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _barang = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Mohon pilih barang';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _jumlah.toString(),
                decoration: InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan jumlah';
                  }
                  return null;
                },
                onSaved: (value) {
                  _jumlah = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _tanggalKeluar.toString(),
                decoration: InputDecoration(labelText: 'Tanggal Keluar'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan tanggal keluar';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tanggalKeluar = DateTime.parse(value!);
                },
              ),
              DropdownButtonFormField<Karyawan>(
                value: _karyawan,
                decoration: InputDecoration(labelText: 'Karyawan'),
                items: Hive.box<Karyawan>('karyawanBox')
                    .values
                    .map((karyawan) => DropdownMenuItem(
                          value: karyawan,
                          child: Text(karyawan.nama),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _karyawan = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Mohon pilih karyawan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newStockKeluar = StockKeluar(
        id: _id,
        barang: _barang,
        jumlah: _jumlah,
        tanggalKeluar: _tanggalKeluar,
        karyawan: _karyawan,
      );

      if (widget.stockKeluar == null) {
        _stockKeluarService.addStockKeluar(newStockKeluar);
      } else {
        _stockKeluarService.updateStockKeluar(newStockKeluar);
      }

      Navigator.pop(context);
    }
  }
}
