import 'package:hive/hive.dart';
import 'package:blackmarket/model/pembelian/pembelian_model.dart';

class PembelianService {
  final Box<Pembelian> _pembelianBox = Hive.box<Pembelian>('pembelianBox');

  Future<void> addPembelian(Pembelian pembelian) async {
    await _pembelianBox.add(pembelian);
  }

  Future<void> updatePembelian(Pembelian pembelian) async {
    await _pembelianBox.put(pembelian.key, pembelian);
  }

  Future<void> deletePembelian(String key) async {
    await _pembelianBox.delete(key);
  }

  List<Pembelian> get pembelianList => _pembelianBox.values.toList();
}
