class DueSupplierResponse {
  final List<DueSupplier> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  DueSupplierResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory DueSupplierResponse.fromJson(Map<String, dynamic> json) {
    return DueSupplierResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => DueSupplier.fromJson(item as Map<String, dynamic>))
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

class DueSupplier {
  final String mobile;
  final String password;
  final String accountName;
  final String accountNo;
  final int schoolCode;

  DueSupplier({
    required this.mobile,
    required this.password,
    required this.accountName,
    required this.accountNo,
    required this.schoolCode,
  });

  factory DueSupplier.fromJson(Map<String, dynamic> json) {
    return DueSupplier(
      mobile: json['mobile'] as String,
      password: json['password'] as String,
      accountName: json['account_name'] as String,
      accountNo: json['account_no'] as String,
      schoolCode: json['school_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'password': password,
      'account_name': accountName,
      'account_no': accountNo,
      'school_code': schoolCode,
    };
  }
}