class SupplierResponse {
  final List<Supplier>? items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SupplierResponse({
   this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  /// Factory constructor to parse JSON safely
  factory SupplierResponse.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];

    // Safely parse supplier list or return an empty list
    final suppliers = (itemsJson is List)
        ? itemsJson.map((e) => Supplier.fromJson(e)).toList()
        : <Supplier>[];

    return SupplierResponse(
      items: suppliers,
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  /// Converts this response back to JSON
  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((e) => e.toJson()).toList(),
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
    };
  }
}

class Supplier {
  final String supplierId;
  final String supplierName;
  final int schoolCode;
  final String password;
  final String mobile;

  Supplier({
    required this.supplierId,
    required this.supplierName,
    required this.schoolCode,
    required this.password,
    required this.mobile,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      supplierId: json['supplier_id'] ?? '',
      supplierName: json['supplier_name'] ?? '',
      schoolCode: json['school_code'] ?? 0,
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'school_code': schoolCode,
      'password': password,
      'mobile': mobile,
    };
  }
}