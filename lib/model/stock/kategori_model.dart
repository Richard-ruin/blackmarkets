import 'package:hive/hive.dart';

part 'kategori_model.g.dart';

@HiveType(typeId: 7)
class Kategori extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String deskripsi;

  Kategori({
    required this.id,
    required this.nama,
    required this.deskripsi,
  });
}
