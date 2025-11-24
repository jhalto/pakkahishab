class CustomerResponse {
  final List<Customer>? items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  CustomerResponse({
   this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  /// Factory constructor to parse JSON safely
  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'];

    // Safely parse supplier list or return an empty list
    final suppliers = (itemsJson is List)
        ? itemsJson.map((e) => Customer.fromJson(e)).toList()
        : <Customer>[];

    return CustomerResponse(
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

class Customer {
  final String customerId;
  final String customerName;
  final int schoolCode;
  final String password;
  final String mobile;

  Customer({
    required this.customerId,
    required this.customerName,
    required this.schoolCode,
    required this.password,
    required this.mobile,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      schoolCode: json['school_code'] ?? 0,
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'school_code': schoolCode,
      'password': password,
      'mobile': mobile,
    };
  }
}