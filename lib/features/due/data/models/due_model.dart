class SupplierDueModel {
  final List<DueItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SupplierDueModel({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory SupplierDueModel.fromJson(Map<String, dynamic> json) {
    return SupplierDueModel(
      items: (json['items'] as List)
          .map((item) => DueItem.fromJson(item))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
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

class DueItem {
  final String accountName;
  final int amount;
  final String accountNo;
  final String payDue;
  final String phoneNo;
  final String password;
  final String mobile;

  DueItem({
    required this.accountName,
    required this.amount,
    required this.accountNo,
    required this.payDue,
    required this.phoneNo,
    required this.password,
    required this.mobile,
  });

  factory DueItem.fromJson(Map<String, dynamic> json) {
    return DueItem(
      accountName: json['account_name'] ?? '',
      amount: json['amount'] ?? 0,
      accountNo: json['account_no'] ?? '',
      payDue: json['pay_due'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_name': accountName,
      'amount': amount,
      'account_no': accountNo,
      'pay_due': payDue,
      'phone_no': phoneNo,
      'password': password,
      'mobile': mobile,
    };
  }
}
