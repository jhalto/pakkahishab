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
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => AllProduct.fromJson(item))
          .toList(),
      hasMore: json['hasMore'] == true,
      limit: json['limit'] is int
          ? json['limit']
          : int.tryParse(json['limit']?.toString() ?? '0') ?? 0,
      offset: json['offset'] is int
          ? json['offset']
          : int.tryParse(json['offset']?.toString() ?? '0') ?? 0,
      count: json['count'] is int
          ? json['count']
          : int.tryParse(json['count']?.toString() ?? '0') ?? 0,
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
  final double? purchasePrice;
  final double? sellPrice;
  final DateTime? manufacturingDate;
  final DateTime? expiredDate;
  final int? schoolCode;
  final int? productCode;
  final int? productStock;
  final int? projectCode;
  final String? password;
  final String? mobile;

  AllProduct({
    required this.productId,
    required this.productName,
    this.purchasePrice,
    this.sellPrice,
    this.manufacturingDate,
    this.expiredDate,
    this.schoolCode,
    this.productCode,
    this.productStock,
    this.projectCode,
    this.password,
    this.mobile,
  });

  factory AllProduct.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Product JSON cannot be null');
    }

    return AllProduct(
      productId: json['product_id'] is int
          ? json['product_id']
          : int.tryParse(json['product_id']?.toString() ?? '') ??
                (throw Exception('product_id is required')),
      productName:
          json['product_name']?.toString() ??
          (throw Exception('product_name is required')),
      purchasePrice: json['purchase_price'] != null
          ? (json['purchase_price'] is double
                ? json['purchase_price']
                : double.tryParse(json['purchase_price'].toString()))
          : null,
      sellPrice: json['sell_price'] != null
          ? (json['sell_price'] is double
                ? json['sell_price']
                : double.tryParse(json['sell_price'].toString()))
          : null,
      manufacturingDate: json['manufacturing_date'] != null
          ? DateTime.tryParse(json['manufacturing_date'].toString())
          : null,
      expiredDate: json['expired_date'] != null
          ? DateTime.tryParse(json['expired_date'].toString())
          : null,
      schoolCode: json['school_code'] != null
          ? (json['school_code'] is int
                ? json['school_code']
                : int.tryParse(json['school_code'].toString()))
          : null,
      productCode: json['product_code'] != null
          ? (json['product_code'] is int
                ? json['product_code']
                : int.tryParse(json['product_code'].toString()))
          : null,
      productStock: json['product_stock'] != null
          ? (json['product_stock'] is int
                ? json['product_stock']
                : int.tryParse(json['product_stock'].toString()))
          : null,
      projectCode: json['project_code'] != null
          ? (json['project_code'] is int
                ? json['project_code']
                : int.tryParse(json['project_code'].toString()))
          : null,
      password: json['password']?.toString(),
      mobile: json['mobile']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'purchase_price': purchasePrice,
      'sell_price': sellPrice,
      'manufacturing_date': manufacturingDate?.toIso8601String(),
      'expired_date': expiredDate?.toIso8601String(),
      'school_code': schoolCode,
      'product_code': productCode,
      'product_stock': productStock,
      'project_code': projectCode,
      'password': password,
      'mobile': mobile,
    };
  }
}
class SaleDetailsProduct {
  String productName;
  String productId;
  int quantity;
  double unitPrice;

  SaleDetailsProduct({
    required this.productName,
    required this.productId,
    this.quantity = 1,
    required this.unitPrice,
  });


  Map<String, dynamic> toJson(){
    return {
      "product_name": productName,
      "product_id": productId,
      "quantity":  quantity,
      "unit_price": unitPrice,
    };
  }
}
class AddProductItem {
  final String name;
  final double? purchasePrice;
  final double? sellPrice;
  final String? manufacturingDate;
  final String? expiredDate;
 
  final int? productStock;

  AddProductItem({
    required this.name,
    this.purchasePrice,
    this.sellPrice,
    this.manufacturingDate,
    this.expiredDate,
    this.productStock,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_name": name,
      "purchase_price": purchasePrice ?? 0.0,
      "sell_price": sellPrice ?? 0.0,
      "manufacturing_date": manufacturingDate ?? "",
      "expired_date": expiredDate ?? "",
      "product_stock": productStock ?? 0,
    };
  }
}