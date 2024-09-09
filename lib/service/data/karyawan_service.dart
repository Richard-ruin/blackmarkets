import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/karyawan_model.dart';

class KaryawanService {
  final Box<Karyawan> karyawanBox;

  KaryawanService(this.karyawanBox);

  Future<void> addKaryawan(Karyawan karyawan) async {
    await karyawanBox.put(karyawan.id, karyawan);
  }

  Karyawan? getKaryawan(String id) {
    return karyawanBox.get(id);
  }

  Future<void> updateKaryawan(Karyawan karyawan) async {
    await karyawan.save();
  }

  Future<void> deleteKaryawan(String id) async {
    await karyawanBox.delete(id);
  }

  List<Karyawan> getAllKaryawan() {
    return karyawanBox.values.toList();
  }
}
