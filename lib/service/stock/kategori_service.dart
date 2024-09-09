import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/kategori_model.dart';

class KategoriService {
  final Box<Kategori> kategoriBox;

  KategoriService(this.kategoriBox);

  Future<void> addKategori(Kategori kategori) async {
    await kategoriBox.put(kategori.id, kategori);
  }

  Kategori? getKategori(String id) {
    return kategoriBox.get(id);
  }

  Future<void> updateKategori(Kategori kategori) async {
    await kategori.save();
  }

  Future<void> deleteKategori(String id) async {
    await kategoriBox.delete(id);
  }

  List<Kategori> getAllKategori() {
    return kategoriBox.values.toList();
  }
}
