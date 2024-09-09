import 'package:hive/hive.dart';

part 'karyawan_model.g.dart';

@HiveType(typeId: 4)
class Karyawan extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String nama;

  @HiveField(2)
  String posisi;

  @HiveField(3)
  double gaji;

  @HiveField(4)
  DateTime tanggalBergabung;

  Karyawan({
    required this.id,
    required this.nama,
    required this.posisi,
    required this.gaji,
    required this.tanggalBergabung,
  });
}
