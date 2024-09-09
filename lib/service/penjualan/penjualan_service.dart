import 'package:hive/hive.dart';
import 'package:blackmarket/model/penjualan/penjualan_model.dart';
import 'package:blackmarket/model/stock/barang_model.dart';

class PenjualanService {
  static const String _penjualanBoxName = 'penjualanBox';
  static const String _labaRugiBoxName = 'labaRugiBox';
  static const String _barangBoxName = 'barangBox';

  Future<void> addPenjualan(Penjualan penjualan) async {
    final box = await Hive.openBox<Penjualan>(_penjualanBoxName);
    await box.add(penjualan);
  }

  Future<void> addLabaRugi(Penjualan penjualan) async {
    final labaRugiBox = await Hive.openBox<Penjualan>(_labaRugiBoxName);
    await labaRugiBox.add(penjualan);
  }

  List<Penjualan> getAllPenjualan() {
    final box = Hive.box<Penjualan>(_penjualanBoxName);
    return box.values.toList();
  }

  List<Penjualan> getAllLabaRugi() {
    final labaRugiBox = Hive.box<Penjualan>(_labaRugiBoxName);
    return labaRugiBox.values.toList();
  }

  Future<void> addBarang(Barang barang) async {
    final box = await Hive.openBox<Barang>(_barangBoxName);
    await box.put(barang.id, barang);
  }

  List<Barang> getBarang() {
    final box = Hive.box<Barang>(_barangBoxName);
    return box.values.toList();
  }

  Future<void> updateBarang(Barang barang) async {
    final box = await Hive.openBox<Barang>(_barangBoxName);
    await box.put(barang.id, barang);
  }

  Future<void> deleteBarang(String id) async {
    final box = await Hive.openBox<Barang>(_barangBoxName);
    await box.delete(id);
  }

  Future<void> addPenjualanToLabaRugiAll(List<Penjualan> penjualanList) async {
    final labaRugiBox = await Hive.openBox<Penjualan>(_labaRugiBoxName);
    for (final penjualan in penjualanList) {
      await labaRugiBox.add(penjualan);
    }
  }
}
