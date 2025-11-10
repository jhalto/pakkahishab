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
  final String accountNo;
  final String accountName;
  final String mobile;
  final String password;
  final int schoolCode;

  DueCustomer({
    required this.accountNo,
    required this.accountName,
    required this.mobile,
    required this.password,
    required this.schoolCode,
  });

  factory DueCustomer.fromJson(Map<String, dynamic> json) {
    return DueCustomer(
      accountNo: json['account_no'] as String,
      accountName: json['account_name'] as String,
      mobile: json['mobile'] as String,
      password: json['password'] as String,
      schoolCode: json['school_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_no': accountNo,
      'account_name': accountName,
      'mobile': mobile,
      'password': password,
      'school_code': schoolCode,
    };
  }
}