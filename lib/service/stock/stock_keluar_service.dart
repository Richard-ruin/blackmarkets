import 'package:hive/hive.dart';
import 'package:blackmarket/model/stock/stock_keluar_model.dart';

class StockKeluarService {
  final Box<StockKeluar> stockKeluarBox;

  StockKeluarService(this.stockKeluarBox);

  Future<void> addStockKeluar(StockKeluar stockKeluar) async {
    await stockKeluarBox.put(stockKeluar.id, stockKeluar);
  }

  StockKeluar? getStockKeluar(String id) {
    return stockKeluarBox.get(id);
  }

  Future<void> updateStockKeluar(StockKeluar stockKeluar) async {
    await stockKeluar.save();
  }

  Future<void> deleteStockKeluar(String id) async {
    await stockKeluarBox.delete(id);
  }

  List<StockKeluar> getAllStockKeluar() {
    return stockKeluarBox.values.toList();
  }
}
