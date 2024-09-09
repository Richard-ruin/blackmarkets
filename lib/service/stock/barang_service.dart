import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/barang_model.dart';

class BarangService {
  final Box<Barang> barangBox;

  BarangService(this.barangBox);

  Future<void> addBarang(Barang barang) async {
    await barangBox.put(barang.id, barang);
  }

  Barang? getBarang(String id) {
    return barangBox.get(id);
  }

  Future<void> updateBarang(Barang barang) async {
    await barangBox.put(
        barang.id, barang); // Menggunakan metode put untuk memperbarui
  }

  Future<void> deleteBarang(String id) async {
    await barangBox.delete(id);
  }

  List<Barang> getAllBarang() {
    return barangBox.values.toList();
  }
}
