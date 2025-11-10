class CustomerDueModel {
  final List<CustomerDueItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  CustomerDueModel({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory CustomerDueModel.fromJson(Map<String, dynamic> json) {
    return CustomerDueModel(
      items: (json['items'] as List)
          .map((item) => CustomerDueItem.fromJson(item))
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

class CustomerDueItem {
  final String customerId;
  final DateTime? followUpDate;
  final String accountName;
  final int amount;
  final int totalSupplier;
  final int totalAmount;
  final String accountNo;
  final String payDue;
  final String? phoneNo;
  final String password;
  final String mobile;

  CustomerDueItem({
    required this.customerId,
    required this.followUpDate,
    required this.accountName,
    required this.amount,
    required this.totalAmount,
    required this.totalSupplier,
    required this.accountNo,
    required this.payDue,
    required this.phoneNo,
    required this.password,
    required this.mobile,
  });

  factory CustomerDueItem.fromJson(Map<String, dynamic> json) {
    return CustomerDueItem(
      customerId: json['customer_id'] ?? '',
      followUpDate: json['follow_up_date'] != null
          ? DateTime.tryParse(json['follow_up_date'])
          : null,
      accountName: json['account_name'] ?? '',
      amount: json['amount'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      totalSupplier: json['total_suppliers'] ?? 0,
      // ✅ Safely handle both int and string types for account_no
      accountNo: json['account_no']?.toString() ?? '',
      payDue: json['pay_due'] ?? '',
      phoneNo: json['phone_no']?.toString(),
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'follow_up_date': followUpDate?.toIso8601String(),
      'account_name': accountName,
      'amount': amount,
      'total_suppliers': totalSupplier,
      'total_amount': totalAmount,
      'account_no': accountNo,
      'pay_due': payDue,
      'phone_no': phoneNo,
      'password': password,
      'mobile': mobile,
    };
  }
}