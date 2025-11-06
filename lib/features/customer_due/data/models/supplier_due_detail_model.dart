class SupplierDueDetailsResponse {
  final List<SupplierDueDetailsItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SupplierDueDetailsResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory SupplierDueDetailsResponse.fromJson(Map<String, dynamic> json) {
    return SupplierDueDetailsResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => SupplierDueDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
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

class SupplierDueDetailsItem {
  final String accountName;
  final double amount;
  final String accountNo;
  final String phoneNo;
  final String purchaseNo;
  final DateTime? purchaseDate;
  final String supplierId;
  final String password;
  final String mobile;

  SupplierDueDetailsItem({
    required this.accountName,
    required this.amount,
    required this.accountNo,
    required this.phoneNo,
    required this.purchaseNo,
    required this.purchaseDate,
    required this.supplierId,
    required this.password,
    required this.mobile,
  });

  factory SupplierDueDetailsItem.fromJson(Map<String, dynamic> json) {
    return SupplierDueDetailsItem(
      accountName: json['account_name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      accountNo: json['account_no'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      purchaseNo: json['purchase_no'] ?? '',
      purchaseDate: json['purchase_date'] != null
          ? DateTime.tryParse(json['purchase_date'])
          : null,
      supplierId: json['supplier_id'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_name': accountName,
      'amount': amount,
      'account_no': accountNo,
      'phone_no': phoneNo,
      'purchase_no': purchaseNo,
      'purchase_date': purchaseDate?.toIso8601String(),
      'supplier_id': supplierId,
      'password': password,
      'mobile': mobile,
    };
  }
}