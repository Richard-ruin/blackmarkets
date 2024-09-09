import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blackmarket/model/stock/stock_masuk_model.dart';
import 'package:blackmarket/service/stock/stock_masuk_service.dart';
import 'package:blackmarket/page/stock/stock_masuk_form_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StockMasukPage extends StatefulWidget {
  @override
  _StockMasukPageState createState() => _StockMasukPageState();
}

class _StockMasukPageState extends State<StockMasukPage> {
  late StockMasukService _stockMasukService;
  late Box<StockMasuk> _stockMasukBox;
  late Stream<BoxEvent> _stockMasukBoxStream;

  @override
  void initState() {
    super.initState();
    _stockMasukBox = Hive.box<StockMasuk>('stockMasukBox');
    _stockMasukService = StockMasukService(_stockMasukBox);
    _stockMasukBoxStream = _stockMasukBox.watch().distinct();
  }

  void _printStockMasukList() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: ['No', 'Barang', 'Jumlah', 'Tanggal Masuk', 'Supplier'],
            data: List.generate(_stockMasukBox.length, (index) {
              final stockMasuk = _stockMasukBox.getAt(index)!;
              return [
                '${index + 1}',
                stockMasuk.barang.nama,
                '${stockMasuk.jumlah}',
                DateFormat('d/M/yyyy').format(stockMasuk.tanggalMasuk),
                stockMasuk.supplier.nama,
              ];
            }),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Masuk'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _printStockMasukList,
          ),
        ],
      ),
      body: StreamBuilder<BoxEvent>(
        stream: _stockMasukBoxStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Tidak ada data stok masuk'),
            );
          }

          List<StockMasuk> stockMasukList = _stockMasukBox.values.toList();

          if (stockMasukList.isEmpty) {
            return Center(
              child: Text('Tidak ada data stok masuk'),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Barang')),
                DataColumn(label: Text('Jumlah')),
                DataColumn(label: Text('Tanggal Masuk')),
                DataColumn(label: Text('Supplier')),
              ],
              rows: stockMasukList
                  .map(
                    (stockMasuk) => DataRow(
                      cells: [
                        DataCell(
                            Text('${stockMasukList.indexOf(stockMasuk) + 1}')),
                        DataCell(Text(stockMasuk.barang.nama)),
                        DataCell(Text('${stockMasuk.jumlah}')),
                        DataCell(Text('${stockMasuk.tanggalMasuk}')),
                        DataCell(Text(stockMasuk.supplier.nama)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StockMasukFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
