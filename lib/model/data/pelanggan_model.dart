import 'package:hive/hive.dart';

part 'pelanggan_model.g.dart';

@HiveType(typeId: 5)
class Pelanggan extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String alamat;

  @HiveField(3)
  String nomorTelepon;

  @HiveField(4)
  String email;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.nomorTelepon,
    required this.email,
  });
}
