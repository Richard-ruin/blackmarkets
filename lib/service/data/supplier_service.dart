import 'package:hive/hive.dart';
import 'package:blackmarket/model/data/supplier_model.dart';

class SupplierService {
  final Box<Supplier> _supplierBox = Hive.box<Supplier>('supplierBox');

  List<Supplier> getAllSuppliers() {
    return _supplierBox.values.toList();
  }

  void addSupplier(Supplier supplier) {
    _supplierBox.add(supplier);
  }

  void updateSupplier(int index, Supplier supplier) {
    _supplierBox.putAt(index, supplier);
  }

  void deleteSupplier(int index) {
    _supplierBox.deleteAt(index);
  }
}
