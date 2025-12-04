class AdvanceHeadResponse {
  final List<AdvanceHeadItem>? items;
  final bool? hasMore;
  final int? limit;
  final int? offset;
  final int? count;

  AdvanceHeadResponse({
    this.items,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
  });

  factory AdvanceHeadResponse.fromJson(Map<String, dynamic> json) {
    return AdvanceHeadResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdvanceHeadItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'] as bool?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      count: json['count'] as int?,
    );
  }

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

class AdvanceHeadItem {
  final String? mobile;
  final String? password;
  final String? accountName;
  final String? accountNo;
  final int? schoolCode;

  AdvanceHeadItem({
    this.mobile,
    this.password,
    this.accountName,
    this.accountNo,
    this.schoolCode,
  });

  factory AdvanceHeadItem.fromJson(Map<String, dynamic> json) {
    return AdvanceHeadItem(
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
      accountName: json['account_name'] as String?,
      accountNo: json['account_no'] as String?,
      schoolCode: json['school_code'] as int?,
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