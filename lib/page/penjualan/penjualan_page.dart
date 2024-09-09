import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:blackmarket/model/stock/barang_model.dart';
import 'package:blackmarket/model/penjualan/penjualan_model.dart';
import 'package:blackmarket/page/penjualan/print_page.dart';
import 'package:blackmarket/main.dart';
import 'package:blackmarket/splash_screen.dart';

class PenjualanPage extends StatefulWidget {
  @override
  _PenjualanPageState createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  late Box<Barang> _barangBox;
  late Box<Penjualan> _penjualanBox;
  late Box<Penjualan> _LaporanLabaRugiBox;

  String _namaPembeli = '';
  double _pembayaran = 0;
  List<Penjualan> _listPenjualan = [];
  List<Barang> _filteredBarangList = [];

  @override
  void initState() {
    super.initState();
    _barangBox = Hive.box<Barang>('barangBox');
    _penjualanBox = Hive.box<Penjualan>('penjualanBox');

    _filteredBarangList = [];
  }

  void _filterBarang(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBarangList = [];
      });
    } else {
      setState(() {
        _filteredBarangList = _barangBox.values
            .where((barang) =>
                barang.nama.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  double _calculateTotal() {
    return _listPenjualan.fold(
        0, (sum, item) => sum + (item.barang.harga * item.jumlah));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nama Pembeli',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _namaPembeli = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Barang',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filterBarang(value);
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                if (_filteredBarangList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredBarangList.length,
                      itemBuilder: (context, index) {
                        final barang = _filteredBarangList[index];
                        return ListTile(
                          title: Text(barang.nama),
                          subtitle: Text(
                              NumberFormat.currency(locale: 'id', symbol: 'Rp')
                                  .format(barang.harga)),
                          onTap: () {
                            _showJumlahBarangDialog(barang);
                          },
                        );
                      },
                    ),
                  ),
                if (_listPenjualan.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _listPenjualan.length,
                      itemBuilder: (context, index) {
                        final penjualan = _listPenjualan[index];
                        return ListTile(
                          title: Text(penjualan.barang.nama),
                          subtitle: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (penjualan.jumlah > 1) {
                                      penjualan.jumlah--;
                                    }
                                  });
                                },
                              ),
                              Text(penjualan.jumlah.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    penjualan.jumlah++;
                                  });
                                },
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _listPenjualan.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                          trailing: Text(
                            NumberFormat.currency(locale: 'id', symbol: 'Rp')
                                .format(
                                    penjualan.barang.harga * penjualan.jumlah),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: ${NumberFormat.currency(locale: 'id', symbol: 'Rp').format(_calculateTotal())}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Pembayaran',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'print',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrintPage(
                    listPenjualan: _listPenjualan,
                    namaPembeli: _namaPembeli,
                    pembayaran: _pembayaran,
                  ),
                ),
              );
            },
            child: Icon(Icons.print),
          ),
        ],
      ),
    );
  }

  void _showJumlahBarangDialog(Barang barang) {
    int jumlah = 1;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Jumlah ${barang.nama}'),
          content: Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (jumlah > 1) {
                      jumlah--;
                    }
                  });
                },
              ),
              Text(jumlah.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    jumlah++;
                  });
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
                setState(() {
                  _listPenjualan.add(
                    Penjualan(
                      id: DateTime.now().toString(),
                      barang: barang,
                      jumlah: jumlah,
                      tanggalPenjualan: DateTime.now(),
                    ),
                  );
                  _filteredBarangList = [];
                });
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _simpanPenjualanKeLabaRugi() {
    for (final penjualan in _listPenjualan) {
      _LaporanLabaRugiBox.add(penjualan);
    }
    setState(() {
      _listPenjualan.clear();
    });
  }

  void _refreshPage() {
    setState(() {
      _namaPembeli = '';
      _listPenjualan = [];
      _filteredBarangList = [];
    });
  }
}
