import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/pelanggan_model.dart';

class PelangganService {
  final Box<Pelanggan> pelangganBox;

  PelangganService(this.pelangganBox);

  Future<void> addPelanggan(Pelanggan pelanggan) async {
    await pelangganBox.put(pelanggan.id, pelanggan);
  }

  Pelanggan? getPelanggan(String id) {
    return pelangganBox.get(id);
  }

  Future<void> updatePelanggan(Pelanggan pelanggan) async {
    await pelanggan.save();
  }

  Future<void> deletePelanggan(String id) async {
    await pelangganBox.delete(id);
  }

  List<Pelanggan> getAllPelanggan() {
    return pelangganBox.values.toList();
  }
}
