import 'package:hive/hive.dart';
import 'package:blackmarket/model/laporan/laporan_penjualan_model.dart';

class LaporanPenjualanService {
  static const String _laporanPenjualanBoxName = 'laporanPenjualanBox';

  Future<void> addLaporanPenjualan(LaporanPenjualan laporanPenjualan) async {
    final box = await Hive.openBox<LaporanPenjualan>(_laporanPenjualanBoxName);
    await box.add(laporanPenjualan);
  }

  List<LaporanPenjualan> getAllLaporanPenjualan() {
    final box = Hive.box<LaporanPenjualan>(_laporanPenjualanBoxName);
    return box.values.toList();
  }
}
