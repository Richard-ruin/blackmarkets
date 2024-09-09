import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/data/supplier_model.dart';
import 'package:blackmarket/model/stock/stock_masuk_model.dart';
import 'package:blackmarket/service/stock/stock_masuk_service.dart';

class StockMasukFormPage extends StatefulWidget {
  final StockMasuk? stockMasuk;

  StockMasukFormPage({this.stockMasuk});

  @override
  _StockMasukFormPageState createState() => _StockMasukFormPageState();
}

class _StockMasukFormPageState extends State<StockMasukFormPage> {
  final _formKey = GlobalKey<FormState>();
  late StockMasukService _stockMasukService;

  late String _id;
  late Barang _barang;
  late int _jumlah;
  late DateTime _tanggalMasuk;
  late Supplier _supplier;

  @override
  void initState() {
    super.initState();
    _stockMasukService =
        StockMasukService(Hive.box<StockMasuk>('stockMasukBox'));

    if (widget.stockMasuk != null) {
      _id = widget.stockMasuk!.id;
      _barang = widget.stockMasuk!.barang;
      _jumlah = widget.stockMasuk!.jumlah;
      _tanggalMasuk = widget.stockMasuk!.tanggalMasuk;
      _supplier = widget.stockMasuk!.supplier;
    } else {
      _id = '';
      _barang = Hive.box<Barang>('barangBox').values.first;
      _jumlah = 0;
      _tanggalMasuk = DateTime.now();
      _supplier = Hive.box<Supplier>('supplierBox').values.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockMasuk == null
            ? 'Tambah Stok Masuk'
            : 'Edit Stok Masuk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _id,
                decoration: InputDecoration(labelText: 'ID Stok Masuk'),
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
                initialValue: _tanggalMasuk.toString(),
                decoration: InputDecoration(labelText: 'Tanggal Masuk'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan tanggal masuk';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tanggalMasuk = DateTime.parse(value!);
                },
              ),
              DropdownButtonFormField<Supplier>(
                value: _supplier,
                decoration: InputDecoration(labelText: 'Supplier'),
                items: Hive.box<Supplier>('supplierBox')
                    .values
                    .map((supplier) => DropdownMenuItem(
                          value: supplier,
                          child: Text(supplier.nama),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _supplier = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Mohon pilih supplier';
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

      final newStockMasuk = StockMasuk(
        id: _id,
        barang: _barang,
        jumlah: _jumlah,
        tanggalMasuk: _tanggalMasuk,
        supplier: _supplier,
      );

      if (widget.stockMasuk == null) {
        _stockMasukService.addStockMasuk(newStockMasuk);
      } else {
        _stockMasukService.updateStockMasuk(newStockMasuk);
      }

      Navigator.pop(context);
    }
  }
}
