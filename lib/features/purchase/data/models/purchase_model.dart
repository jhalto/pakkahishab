class PurchaseItem {
  final int purchaseId;
  final String purchaseNo;
  final DateTime purchaseDate;
  final int purchaseType;
  final String supplierId;
  final String? supplierName;
  final String? supplierPhone;
  final double netAmount;
  final double paidPrice;
  final double due;
  final int schoolCode;
  final String? created;
  final String password;
  final String mobile;
  final int totalCount;
  final int totalNetAmount;

  PurchaseItem({
    required this.purchaseId,
    required this.purchaseNo,
    required this.purchaseDate,
    required this.purchaseType,
    required this.supplierId,
    this.supplierName,
    this.supplierPhone,
    required this.netAmount,
    required this.paidPrice,
    required this.due,
    required this.schoolCode,
    this.created,
    required this.password,
    required this.mobile,
    required this.totalCount,
    required this.totalNetAmount,
  });

  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    return PurchaseItem(
      purchaseId: json['purchase_id'],
      purchaseNo: json['purchase_no'],
      purchaseDate: DateTime.parse(json['purchase_date']),
      purchaseType: json['purchase_type'],
      supplierId: json['supplier_id'],
      supplierName: json['supplier_name'],
      supplierPhone: json['supplier_phoneno'],
      netAmount: (json['net_amount'] as num).toDouble(),
      paidPrice: (json['paid_price'] as num).toDouble(),
      due: (json['due'] as num).toDouble(),
      schoolCode: json['school_code'],
      created: json['created'],
      password: json['password'],
      mobile: json['mobile'],
      totalCount: json['total_count'],
      totalNetAmount: json['total_net_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchase_id': purchaseId,
      'purchase_no': purchaseNo,
      'purchase_date': purchaseDate.toIso8601String(),
      'purchase_type': purchaseType,
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'supplier_phoneno': supplierPhone,
      'net_amount': netAmount,
      'paid_price': paidPrice,
      'due': due,
      'school_code': schoolCode,
      'created':created,
      'password': password,
      'mobile': mobile,
      'total_count': totalCount,
      'total_net_amount': totalNetAmount,
    };
  }
}

class PurchaseResponse {
  final List<PurchaseItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;


  PurchaseResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      items: (json['items'] as List)
          .map((e) => PurchaseItem.fromJson(e))
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