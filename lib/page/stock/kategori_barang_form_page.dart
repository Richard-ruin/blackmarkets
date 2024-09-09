import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/kategori_model.dart';
import 'package:blackmarket/service/stock/kategori_service.dart';

class KategoriBarangFormPage extends StatefulWidget {
  final Kategori? kategori;

  KategoriBarangFormPage({this.kategori});

  @override
  _KategoriBarangFormPageState createState() => _KategoriBarangFormPageState();
}

class _KategoriBarangFormPageState extends State<KategoriBarangFormPage> {
  final _formKey = GlobalKey<FormState>();
  late KategoriService _kategoriService;

  late String _id;
  late String _nama;
  late String _deskripsi;

  @override
  void initState() {
    super.initState();
    _kategoriService = KategoriService(Hive.box<Kategori>('kategoriBox'));

    if (widget.kategori != null) {
      _id = widget.kategori!.id;
      _nama = widget.kategori!.nama;
      _deskripsi = widget.kategori!.deskripsi;
    } else {
      _id = '';
      _nama = '';
      _deskripsi = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kategori == null
            ? 'Tambah Kategori Barang'
            : 'Edit Kategori Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Kategori'),
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
                decoration: InputDecoration(labelText: 'Nama Kategori'),
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
                initialValue: _deskripsi,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan deskripsi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _deskripsi = value!;
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

      final newKategori = Kategori(
        id: _id,
        nama: _nama,
        deskripsi: _deskripsi,
      );

      if (widget.kategori == null) {
        _kategoriService.addKategori(newKategori);
      } else {
        _kategoriService.updateKategori(newKategori);
      }

      Navigator.pop(context);
    }
  }
}
