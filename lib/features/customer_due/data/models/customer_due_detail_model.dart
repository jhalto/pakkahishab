class CustomerDueDetailsResponse {
  final List<CustomerDueDetailsItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  CustomerDueDetailsResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory CustomerDueDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CustomerDueDetailsResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CustomerDueDetailsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
    };
  }
}

class CustomerDueDetailsItem {
  final String accountName;
  final double amount;
  final String accountNo;
  final String phoneNo;
  final String salesNo;
  final DateTime? salesDate;
  final String customerId;
  final String password;
  final String mobile;

  CustomerDueDetailsItem({
    required this.accountName,
    required this.amount,
    required this.accountNo,
    required this.phoneNo,
    required this.salesNo,
    required this.salesDate,
    required this.customerId,
    required this.password,
    required this.mobile,
  });

  factory CustomerDueDetailsItem.fromJson(Map<String, dynamic> json) {
    return CustomerDueDetailsItem(
      accountName: json['account_name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      accountNo: json['account_no'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      salesNo: json['sales_no'] ?? '',
      salesDate: json['sales_date'] != null
          ? DateTime.tryParse(json['sales_date'])
          : null,
      customerId: json['customer_id'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_name': accountName,
      'amount': amount,
      'account_no': accountNo,
      'phone_no': phoneNo,
      'sales_no': salesNo,
      'sales_date': salesDate?.toIso8601String(),
      'customer_id': customerId,
      'password': password,
      'mobile': mobile,
    };
  }
}