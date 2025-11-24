class IncomeCategoryResponse {
  List<IncomeCategory> items;
  bool hasMore;
  int limit;
  int offset;
  int count;

  IncomeCategoryResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory IncomeCategoryResponse.fromJson(Map<String, dynamic> json) {
    return IncomeCategoryResponse(
      items: (json['items'] as List)
          .map((e) => IncomeCategory.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'hasMore': hasMore,
        'limit': limit,
        'offset': offset,
        'count': count,
      };
}

class IncomeCategory {
  String mobile;
  String password;
  String accountName;
  String accountNo;
  int schoolCode;

  IncomeCategory({
    required this.mobile,
    required this.password,
    required this.accountName,
    required this.accountNo,
    required this.schoolCode,
  });

  factory IncomeCategory.fromJson(Map<String, dynamic> json) {
    return IncomeCategory(
      mobile: json['mobile'],
      password: json['password'],
      accountName: json['account_name'],
      accountNo: json['account_no'],
      schoolCode: json['school_code'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'password': password,
        'account_name': accountName,
        'account_no': accountNo,
        'school_code': schoolCode,
      };
}
