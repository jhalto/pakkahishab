class AdvanceAmountResponse {
  final List<AdvanceItem>? items;
  final bool? hasMore;
  final int? limit;
  final int? offset;
  final int? count;

  AdvanceAmountResponse({
    this.items,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
  });

  factory AdvanceAmountResponse.fromJson(Map<String, dynamic> json) {
    return AdvanceAmountResponse(
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((e) => AdvanceItem.fromJson(e))
              .toList()
          : null,
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items?.map((e) => e.toJson()).toList(),
      "hasMore": hasMore,
      "limit": limit,
      "offset": offset,
      "count": count,
    };
  }
}

class AdvanceItem {
  final String? accountName;
  final int? amount;
  final String? accountNo;
  final String? loanPay;
  final String? mobile;
  final String? password;

  AdvanceItem({
    this.accountName,
    this.amount,
    this.accountNo,
    this.loanPay,
    this.mobile,
    this.password,
  });

  factory AdvanceItem.fromJson(Map<String, dynamic> json) {
    return AdvanceItem(
      accountName: json['account_name'],
      amount: json['amount'],
      accountNo: json['account_no'],
      loanPay: json['loan_pay'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account_name": accountName,
      "amount": amount,
      "account_no": accountNo,
      "loan_pay": loanPay,
      "mobile": mobile,
      "password": password,
    };
  }
}