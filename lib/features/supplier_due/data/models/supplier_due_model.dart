
class SupplierDueModel {
  final List<SupplierDueItem> items;
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
          .map((item) => SupplierDueItem.fromJson(item))
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

class SupplierDueItem {
  final String supplierId;
  final DateTime followUpDate;
  final String accountName;
  final int amount;
  final int totalSupplier;
  final int totalAmount;
  final String accountNo;
  final String payDue;
  final String phoneNo;
  final String password;
  final String mobile;

  SupplierDueItem({
    required this.supplierId,
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

  factory SupplierDueItem.fromJson(Map<String, dynamic> json) {
    return SupplierDueItem(
      supplierId: json['supplier_id'] ?? '',
      followUpDate:DateTime.parse(json['follow_up_date']),
      accountName: json['account_name'] ?? '',
      amount: json['amount'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      totalSupplier: json['total_suppliers']??0,
      accountNo: json['account_no'] ?? '',
      payDue: json['pay_due'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'follow_up_date': followUpDate,
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