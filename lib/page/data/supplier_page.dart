import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/supplier_model.dart';
import 'package:blackmarket/service/data/supplier_service.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  late SupplierService _supplierService;

  @override
  void initState() {
    super.initState();
    _supplierService = SupplierService();
  }

  void _showAddSupplierDialog() {
    String id = '';
    String nama = '';
    String alamat = '';
    String nomorTelepon = '';
    String email = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Supplier'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'ID Supplier'),
                onChanged: (value) {
                  id = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nama Supplier'),
                onChanged: (value) {
                  nama = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Alamat'),
                onChanged: (value) {
                  alamat = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                onChanged: (value) {
                  nomorTelepon = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final supplier = Supplier(
                  id: id,
                  nama: nama,
                  alamat: alamat,
                  nomorTelepon: nomorTelepon,
                  email: email,
                );
                _supplierService.addSupplier(supplier);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final supplierList = _supplierService.getAllSuppliers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier'),
      ),
      body: ListView.builder(
        itemCount: supplierList.length,
        itemBuilder: (context, index) {
          final supplier = supplierList[index];
          return ListTile(
            title: Text(supplier.nama),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alamat: ${supplier.alamat}'),
                Text('Nomor Telepon: ${supplier.nomorTelepon}'),
                Text('Email: ${supplier.email}'),
              ],
            ),
            onLongPress: () {
              _supplierService.deleteSupplier(index);
              setState(() {});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSupplierDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
