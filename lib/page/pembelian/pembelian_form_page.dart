import 'package:flutter/material.dart';
import 'package:blackmarket/model/pembelian/pembelian_model.dart';
import 'package:blackmarket/service/pembelian/pembelian_service.dart';

class PembelianFormPage extends StatefulWidget {
  final Pembelian? pembelian;

  PembelianFormPage({this.pembelian});

  @override
  _PembelianFormPageState createState() => _PembelianFormPageState();
}

class _PembelianFormPageState extends State<PembelianFormPage> {
  final PembelianService _pembelianService = PembelianService();
  final _formKey = GlobalKey<FormState>();

  late String _id;
  late DateTime _tanggalPembelian;
  late String _idSupplier;
  late double _totalPembelian;
  late List<DetailPembelian> _detailPembelian;

  @override
  void initState() {
    super.initState();
    if (widget.pembelian != null) {
      _id = widget.pembelian!.id;
      _tanggalPembelian = widget.pembelian!.tanggalPembelian;
      _idSupplier = widget.pembelian!.idSupplier;
      _totalPembelian = widget.pembelian!.totalPembelian;
      _detailPembelian = widget.pembelian!.detailPembelian;
    } else {
      _id = DateTime.now().millisecondsSinceEpoch.toString();
      _tanggalPembelian = DateTime.now();
      _idSupplier = '';
      _totalPembelian = 0.0;
      _detailPembelian = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.pembelian == null ? 'Tambah Pembelian' : 'Edit Pembelian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _idSupplier,
                decoration: InputDecoration(labelText: 'ID Supplier'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan ID Supplier';
                  }
                  return null;
                },
                onSaved: (value) {
                  _idSupplier = value!;
                },
              ),
              TextFormField(
                initialValue: _totalPembelian.toString(),
                decoration: InputDecoration(labelText: 'Total Pembelian'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan total pembelian';
                  }
                  return null;
                },
                onSaved: (value) {
                  _totalPembelian = double.parse(value!);
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

      final newPembelian = Pembelian(
        id: _id,
        tanggalPembelian: _tanggalPembelian,
        idSupplier: _idSupplier,
        totalPembelian: _totalPembelian,
        detailPembelian: _detailPembelian,
      );

      if (widget.pembelian == null) {
        _pembelianService.addPembelian(newPembelian);
      } else {
        _pembelianService.updatePembelian(newPembelian);
      }

      Navigator.pop(context);
    }
  }
}
