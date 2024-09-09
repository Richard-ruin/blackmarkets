import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/stock_keluar_model.dart';
import 'package:blackmarket/service/stock/stock_keluar_service.dart';
import 'package:blackmarket/page/stock/stock_keluar_form_page.dart';

class StockKeluarPage extends StatefulWidget {
  @override
  _StockKeluarPageState createState() => _StockKeluarPageState();
}

class _StockKeluarPageState extends State<StockKeluarPage> {
  late StockKeluarService _stockKeluarService;
  late Box<StockKeluar> _stockKeluarBox;
  late Stream<BoxEvent> _stockKeluarBoxStream;

  @override
  void initState() {
    super.initState();
    _stockKeluarBox = Hive.box<StockKeluar>('stockKeluarBox');
    _stockKeluarService = StockKeluarService(_stockKeluarBox);
    _stockKeluarBoxStream = _stockKeluarBox.watch().distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Keluar'),
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _stockKeluarBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data stok keluar'),
            );
          }

          List<StockKeluar> stockKeluarList = _stockKeluarBox.values.toList();

          if (stockKeluarList.isEmpty) {
            return Center(
              child: Text('Tidak ada data stok keluar'),
            );
          }

          return ListView.builder(
            itemCount: stockKeluarList.length,
            itemBuilder: (context, index) {
              StockKeluar stockKeluar = stockKeluarList[index];
              return ListTile(
                title: Text(stockKeluar.barang.nama),
                subtitle: Text(
                    'Jumlah: ${stockKeluar.jumlah}, Tanggal: ${stockKeluar.tanggalKeluar}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _stockKeluarService.deleteStockKeluar(stockKeluar.id);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StockKeluarFormPage(stockKeluar: stockKeluar),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StockKeluarFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
