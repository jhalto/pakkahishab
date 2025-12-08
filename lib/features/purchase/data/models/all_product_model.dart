class AllProductResponse {
  final List<AllProduct> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  AllProductResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory AllProductResponse.fromJson(Map<String, dynamic> json) {
    return AllProductResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => AllProduct.fromJson(item))
          .toList(),
      hasMore: json['hasMore'] as bool,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
    };
  }
}

class AllProduct {
  final int productId;
  final String productName;
  final int purchasePrice;
  final int sellPrice;
  final DateTime? manufacturingDate;
  final DateTime? expiredDate;
  final int schoolCode;
  final int productCode;
  final int productStock;
  final int projectCode;
  final String password;
  final String mobile;

  AllProduct({
    required this.productId,
    required this.productName,
    required this.purchasePrice,
    required this.sellPrice,
    this.manufacturingDate,
    this.expiredDate,
    required this.schoolCode,
    required this.productCode,
    required this.productStock,
    required this.projectCode,
    required this.password,
    required this.mobile,
  });

  factory AllProduct.fromJson(Map<String, dynamic> json) {
    return AllProduct(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      purchasePrice: json['purchase_price'] as int,
      sellPrice: json['sell_price'] as int,
      manufacturingDate: json['manufacturing_date'] != null
          ? DateTime.tryParse(json['manufacturing_date'] as String)
          : null,
      expiredDate: json['expired_date'] != null
          ? DateTime.tryParse(json['expired_date'] as String)
          : null,
      schoolCode: json['school_code'] as int,
      productCode: json['product_code'] as int,
      productStock: json['product_stock'] as int,
      projectCode: json['project_code'] as int,
      password: json['password'] as String,
      mobile: json['mobile'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'purchase_price': purchasePrice,
      'sell_price': sellPrice,
      'manufacturing_date':
          manufacturingDate?.toIso8601String(), // null-safe
      'expired_date': expiredDate?.toIso8601String(), // null-safe
      'school_code': schoolCode,
      'product_code': productCode,
      'product_stock': productStock,
      'project_code': projectCode,
      'password': password,
      'mobile': mobile,
    };
  }
}

class AddProductItem{
  final String name;
  final double? purchasePrice;
  final double? sellPrice;
  final String? manufacturingDate;
  final String? expiredDate;
  final String? productCode;
  final String? productStock;

  AddProductItem({
    required this.name,
    this.purchasePrice,
    this.sellPrice,
    this.manufacturingDate,
    this.expiredDate,
    this.productCode,
    this.productStock

  });
  
  Map<String, dynamic> toJson(){
    return {
      "product_name": name,
      "purchase_price": purchasePrice ?? "",
      "sell_price": sellPrice ?? 0.0,
      "manufacturing_date": manufacturingDate ?? "",
      "expired_date": expiredDate ?? "",
      "product_code": productCode ?? "",
      "product_stock": productStock ?? 0,

    };
  }
  

}