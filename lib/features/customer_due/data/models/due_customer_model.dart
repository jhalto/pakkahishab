class DueCustomerResponse {
  final List<DueCustomer> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  DueCustomerResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory DueCustomerResponse.fromJson(Map<String, dynamic> json) {
    return DueCustomerResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => DueCustomer.fromJson(item as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
    };
  }
}

class DueCustomer {
  final String customerId;
  final String customerName;
  final int schoolCode;
  final String password;
  final String mobile;

  DueCustomer({
    required this.customerId,
    required this.customerName,
    required this.schoolCode,
    required this.password,
    required this.mobile,
  });

  factory DueCustomer.fromJson(Map<String, dynamic> json) {
    return DueCustomer(
      customerId: json['customer_id'] as String,
      customerName: json['customer_name'] as String,
      schoolCode: json['school_code'] as int,
      password: json['password'] as String,
      mobile: json['mobile'] as String,
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