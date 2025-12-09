class StockResponse {
  final List<StockItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  StockResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      items: (json['items'] as List)
          .map((e) => StockItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'hasMore': hasMore,
        'limit': limit,
        'offset': offset,
        'count': count,
      };
}

class StockItem {
  final int productId;
  final String productName;
  final double purchasePrice;
  final double balance;
  final double totalAmount;
  final String password;
  final String mobile;
  final double totalStockAmount;

  StockItem({
    required this.productId,
    required this.productName,
    required this.purchasePrice,
    required this.balance,
    required this.totalAmount,
    required this.password,
    required this.mobile,
    required this.totalStockAmount,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      productId: json['product_id'],
      productName: json['product_name'],
      purchasePrice: json['purchase_price'].toDouble(),
      balance: json['balance'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      password: json['password'],
      mobile: json['mobile'],
      totalStockAmount: json['total_stock_amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'purchase_price': purchasePrice,
        'balance': balance,
        'total_amount': totalAmount,
        'password': password,
        'mobile': mobile,
        'total_stock_amount': totalStockAmount,
      };
}