class SupplierPurchaseResponse {
  final List<SupplierPurchaseItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SupplierPurchaseResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory SupplierPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseResponse(
      items: (json['items'] as List)
          .map((e) => SupplierPurchaseItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
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
class SupplierPurchaseItem {
  final String supplierId;
  final String supplierName;
  final int schoolCode;
  final String mobile;
  final String password;
  final int totalPurchaseCount;
  final double totalPurchaseAmount;

  SupplierPurchaseItem({
    required this.supplierId,
    required this.supplierName,
    required this.schoolCode,
    required this.mobile,
    required this.password,
    required this.totalPurchaseCount,
    required this.totalPurchaseAmount,
  });

  factory SupplierPurchaseItem.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseItem(
      supplierId: json['supplier_id'],
      supplierName: json['supplier_name'],
      schoolCode: json['school_code'],
      mobile: json['mobile'],
      password: json['password'],
      totalPurchaseCount: json['total_purchase_count'],
      totalPurchaseAmount:
          (json['total_purchase_amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'school_code': schoolCode,
      'mobile': mobile,
      'password': password,
      'total_purchase_count': totalPurchaseCount,
      'total_purchase_amount': totalPurchaseAmount,
    };
  }
}