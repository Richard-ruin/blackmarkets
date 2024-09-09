import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';
import 'package:blackmarket/service/data/karyawan_service.dart';

class KaryawanFormPage extends StatefulWidget {
  final Karyawan? karyawan;

  KaryawanFormPage({this.karyawan});

  @override
  _KaryawanFormPageState createState() => _KaryawanFormPageState();
}

class _KaryawanFormPageState extends State<KaryawanFormPage> {
  final _formKey = GlobalKey<FormState>();
  late KaryawanService _karyawanService;

  late String _id;
  late String _nama;
  late String _posisi;
  late double _gaji;
  late DateTime _tanggalBergabung;

  @override
  void initState() {
    super.initState();
    _karyawanService = KaryawanService(Hive.box<Karyawan>('karyawanBox'));

    if (widget.karyawan != null) {
      _id = widget.karyawan!.id;
      _nama = widget.karyawan!.nama;
      _posisi = widget.karyawan!.posisi;
      _gaji = widget.karyawan!.gaji;
      _tanggalBergabung = widget.karyawan!.tanggalBergabung;
    } else {
      _id = '';
      _nama = '';
      _posisi = '';
      _gaji = 0.0;
      _tanggalBergabung = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.karyawan == null ? 'Tambah Karyawan' : 'Edit Karyawan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Karyawan'),
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
                initialValue: _posisi,
                decoration: InputDecoration(labelText: 'Posisi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan posisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _posisi = value!;
                },
              ),
              TextFormField(
                initialValue: _gaji.toString(),
                decoration: InputDecoration(labelText: 'Gaji'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan gaji';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Mohon masukkan gaji yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _gaji = double.parse(value!);
                },
              ),
              ListTile(
                title: Text('Tanggal Bergabung'),
                subtitle: Text(_tanggalBergabung.toLocal().toString().split(' ')[0]),
                onTap: _pickDate,
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

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _tanggalBergabung,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _tanggalBergabung = date;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newKaryawan = Karyawan(
        id: _id,
        nama: _nama,
        posisi: _posisi,
        gaji: _gaji,
        tanggalBergabung: _tanggalBergabung,
      );

      if (widget.karyawan == null) {
        _karyawanService.addKaryawan(newKaryawan);
      } else {
        _karyawanService.updateKaryawan(newKaryawan);
      }

      Navigator.of(context).pop();
    }
  }
}
