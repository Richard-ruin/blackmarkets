import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/pelanggan_model.dart';
import 'package:blackmarket/service/data/pelanggan_service.dart';

class PelangganFormPage extends StatefulWidget {
  final Pelanggan? pelanggan;

  PelangganFormPage({this.pelanggan});

  @override
  _PelangganFormPageState createState() => _PelangganFormPageState();
}

class _PelangganFormPageState extends State<PelangganFormPage> {
  final _formKey = GlobalKey<FormState>();
  late PelangganService _pelangganService;

  late String _id;
  late String _nama;
  late String _alamat;
  late String _nomorTelepon;
  late String _email;

  @override
  void initState() {
    super.initState();
    _pelangganService = PelangganService(Hive.box<Pelanggan>('pelangganBox'));

    if (widget.pelanggan != null) {
      _id = widget.pelanggan!.id;
      _nama = widget.pelanggan!.nama;
      _alamat = widget.pelanggan!.alamat;
      _nomorTelepon = widget.pelanggan!.nomorTelepon;
      _email = widget.pelanggan!.email;
    } else {
      _id = '';
      _nama = '';
      _alamat = '';
      _nomorTelepon = '';
      _email = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pelanggan == null ? 'Tambah Pelanggan' : 'Edit Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Pelanggan'),
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
                initialValue: _alamat,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan alamat';
                  }
                  return null;
                },
                onSaved: (value) {
                  _alamat = value!;
                },
              ),
              TextFormField(
                initialValue: _nomorTelepon,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan nomor telepon';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nomorTelepon = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
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

      final newPelanggan = Pelanggan(
        id: _id,
        nama: _nama,
        alamat: _alamat,
        nomorTelepon: _nomorTelepon,
        email: _email,
      );

      if (widget.pelanggan == null) {
        _pelangganService.addPelanggan(newPelanggan);
      } else {
        _pelangganService.updatePelanggan(newPelanggan);
      }

      Navigator.of(context).pop();
    }
  }
}
