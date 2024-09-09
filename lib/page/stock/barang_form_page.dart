import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/service/stock/barang_service.dart';

class BarangFormPage extends StatefulWidget {
  final Barang? barang;

  BarangFormPage({this.barang});

  @override
  _BarangFormPageState createState() => _BarangFormPageState();
}

class _BarangFormPageState extends State<BarangFormPage> {
  final _formKey = GlobalKey<FormState>();
  late BarangService _barangService;

  late String _id;
  late String _nama;
  late String _kategori;
  late double _harga;
  late int _stok;

  @override
  void initState() {
    super.initState();
    _barangService = BarangService(Hive.box<Barang>('barangBox'));

    if (widget.barang != null) {
      _id = widget.barang!.id;
      _nama = widget.barang!.nama;
      _kategori = widget.barang!.kategori;
      _harga = widget.barang!.harga;
      _stok = widget.barang!.stok;
    } else {
      _id = '';
      _nama = '';
      _kategori = '';
      _harga = 0.0;
      _stok = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barang == null ? 'Tambah Barang' : 'Edit Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Barang'),
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
              TextFormField(
                initialValue: _nama,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan nama';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nama = value!;
                },
              ),
              TextFormField(
                initialValue: _kategori,
                decoration: InputDecoration(labelText: 'Kategori'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan kategori';
                  }
                  return null;
                },
                onSaved: (value) {
                  _kategori = value!;
                },
              ),
              TextFormField(
                initialValue: _harga.toString(),
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan harga';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Mohon masukkan harga yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _harga = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _stok.toString(),
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan stok';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Mohon masukkan stok yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _stok = int.parse(value!);
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

      final newBarang = Barang(
        id: _id,
        nama: _nama,
        kategori: _kategori,
        harga: _harga,
        stok: _stok,
      );

      if (widget.barang == null) {
        _barangService.addBarang(newBarang);
      } else {
        _barangService.updateBarang(newBarang);
      }

      Navigator.pop(context);
    }
  }
}
