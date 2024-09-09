import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blackmarket/service/laporan/laporan_penjualan_service.dart';
import 'package:blackmarket/model/laporan/laporan_penjualan_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class LaporanPenjualanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final laporanPenjualanService = LaporanPenjualanService();
    final laporanPenjualanList =
        laporanPenjualanService.getAllLaporanPenjualan();

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Penjualan'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('No')),
            DataColumn(label: Text('Tanggal')),
            DataColumn(label: Text('Pembeli')),
            DataColumn(label: Text('Qty')),
            DataColumn(label: Text('Total Harga')),
          ],
          rows: List.generate(laporanPenjualanList.length, (index) {
            final laporan = laporanPenjualanList[index];
            return DataRow(cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(DateFormat('d/M/yyyy').format(laporan.tanggal))),
              DataCell(Text('${laporan.jumlahPembeli}')),
              DataCell(Text('${laporan.totalQty}')),
              DataCell(Text(NumberFormat.currency(locale: 'id', symbol: 'Rp')
                  .format(laporan.totalHarga))),
            ]);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Table.fromTextArray(
                  headers: ['No', 'Tanggal', 'Pembeli', 'Qty', 'Total Harga'],
                  data: List.generate(laporanPenjualanList.length, (index) {
                    final laporan = laporanPenjualanList[index];
                    return [
                      '${index + 1}',
                      DateFormat('d/M/yyyy').format(laporan.tanggal),
                      '${laporan.jumlahPembeli}',
                      '${laporan.totalQty}',
                      NumberFormat.currency(locale: 'id', symbol: 'Rp')
                          .format(laporan.totalHarga),
                    ];
                  }),
                );
              },
            ),
          );

          await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save(),
          );
        },
        child: Icon(Icons.save),
        tooltip: 'Save as PDF',
      ),
    );
  }
}
