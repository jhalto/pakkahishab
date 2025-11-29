class StockProductNameResponse {
  final List<StockProductItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  StockProductNameResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory StockProductNameResponse.fromJson(Map<String, dynamic> json) {
    return StockProductNameResponse(
      items: (json['items'] as List)
          .map((e) => StockProductItem.fromJson(e))
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

class StockProductItem {
  final String productName;
  final int productId;
  final String mobile;
  final String password;

  StockProductItem({
    required this.productName,
    required this.productId,
    required this.mobile,
    required this.password,
  });

  factory StockProductItem.fromJson(Map<String, dynamic> json) {
    return StockProductItem(
      productName: json['product_name'],
      productId: json['product_id'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'product_name': productName,
        'product_id': productId,
        'mobile': mobile,
        'password': password,
      };
}
