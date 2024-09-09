import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/stock_masuk_model.dart';

class StockMasukService {
  final Box<StockMasuk> stockMasukBox;

  StockMasukService(this.stockMasukBox);

  Future<void> addStockMasuk(StockMasuk stockMasuk) async {
    await stockMasukBox.put(stockMasuk.id, stockMasuk);
  }

  StockMasuk? getStockMasuk(String id) {
    return stockMasukBox.get(id);
  }

  Future<void> updateStockMasuk(StockMasuk stockMasuk) async {
    await stockMasuk.save();
  }

  Future<void> deleteStockMasuk(String id) async {
    await stockMasukBox.delete(id);
  }

  List<StockMasuk> getAllStockMasuk() {
    return stockMasukBox.values.toList();
  }
}
