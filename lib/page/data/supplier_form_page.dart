import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:blackmarket/model/data/supplier_model.dart';

class SupplierFormPage extends StatefulWidget {
  final Supplier? supplier;

  SupplierFormPage({this.supplier});

  @override
  _SupplierFormPageState createState() => _SupplierFormPageState();
}

class _SupplierFormPageState extends State<SupplierFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.supplier != null) {
      _namaController.text = widget.supplier!.nama;
      _alamatController.text = widget.supplier!.alamat;
      _nomorTeleponController.text = widget.supplier!.nomorTelepon;
      _emailController.text = widget.supplier!.email;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _nomorTeleponController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveSupplier() {
    if (_formKey.currentState!.validate()) {
      final newSupplier = Supplier(
        id: widget.supplier?.id ?? Uuid().v4(),
        nama: _namaController.text,
        alamat: _alamatController.text,
        nomorTelepon: _nomorTeleponController.text,
        email: _emailController.text,
      );
      final supplierBox = Hive.box<Supplier>('supplierBox');
      if (widget.supplier == null) {
        supplierBox.add(newSupplier);
      } else {
        final index = supplierBox.values.toList().indexOf(widget.supplier!);
        supplierBox.putAt(index, newSupplier);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.supplier == null ? 'Tambah Supplier' : 'Edit Supplier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Supplier'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSupplier,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
