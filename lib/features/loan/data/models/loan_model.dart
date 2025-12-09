class LoanResponse {
  final List<LoanItem>? items;
  final bool? hasMore;
  final int? limit;
  final int? offset;
  final int? count;

  LoanResponse({
    this.items,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
  });

  factory LoanResponse.fromJson(Map<String, dynamic> json) {
    return LoanResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => LoanItem.fromJson(e))
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

class LoanItem {
  final String? accountName;
  final int? amount;
  final String? accountNo;
  final String? loanPay;
  final String? mobile;
  final String? password;

  LoanItem({
    this.accountName,
    this.amount,
    this.accountNo,
    this.loanPay,
    this.mobile,
    this.password,
  });

  factory LoanItem.fromJson(Map<String, dynamic> json) {
    return LoanItem(
      accountName: json['account_name'] as String?,
      amount: json['amount'] as int?,
      accountNo: json['account_no'] as String?,
      loanPay: json['loan_pay'] as String?,
      mobile: json['mobile'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_name': accountName,
      'amount': amount,
      'account_no': accountNo,
      'loan_pay': loanPay,
      'mobile': mobile,
      'password': password,
    };
  }
}