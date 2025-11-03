class PurchaseDetailsResponse {
  final List<PurchaseDetailsItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  PurchaseDetailsResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory PurchaseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsResponse(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => PurchaseDetailsItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
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

class PurchaseDetailsItem {
  final String purchaseNo;
  final DateTime? purchaseDate;
  final String supplierName;
  final String product;
  final int quantity;
  final int unitPrice;
  final int subTotal;
  final String password;
  final String mobile;

  PurchaseDetailsItem({
    required this.purchaseNo,
    required this.purchaseDate,
    required this.supplierName,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
    required this.password,
    required this.mobile,
  });

  factory PurchaseDetailsItem.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsItem(
      purchaseNo: json['purchase_no'] ?? '',
      purchaseDate: json['purchase_date'] != null
          ? DateTime.tryParse(json['purchase_date'])
          : null,
      supplierName: json['supplier_name'] ?? '',
      product: json['product'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: (json['unit_price'] ?? 0),
        
      subTotal: (json['sub_total'] ?? 0),
         
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchase_no': purchaseNo,
      'purchase_date': purchaseDate?.toIso8601String(),
      'supplier_name': supplierName,
      'product': product,
      'quantity': quantity,
      'unit_price': unitPrice,
      'sub_total': subTotal,
      'password': password,
      'mobile': mobile,
    };
  }
}