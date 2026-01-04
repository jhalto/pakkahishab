class CustomerWiseSalesModel {
  final List<CustomerWiseSalesItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  CustomerWiseSalesModel({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory CustomerWiseSalesModel.fromJson(Map<String, dynamic> json) {
    return CustomerWiseSalesModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CustomerWiseSalesItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
    );
  }
}

class CustomerWiseSalesItem {
  final String customerId;
  final String supplierName;
  final String? customerPhoneNo;
  final int schoolCode;
  final String mobile;
  final String password;
  final int totalSalesCount;
  final double totalSalesAmount;

  CustomerWiseSalesItem({
    required this.customerId,
    required this.supplierName,
    this.customerPhoneNo,
    required this.schoolCode,
    required this.mobile,
    required this.password,
    required this.totalSalesCount,
    required this.totalSalesAmount,
  });

  factory CustomerWiseSalesItem.fromJson(Map<String, dynamic> json) {
    return CustomerWiseSalesItem(
      customerId: json['customer_id'] ?? '',
      supplierName: json['supplier_name'] ?? '',
      customerPhoneNo: json['customer_phone_no'],
      schoolCode: json['school_code'] ?? 0,
      mobile: json['mobile'] ?? '',
      password: json['password'] ?? '',
      totalSalesCount: json['total_sales_count'] ?? 0,
      totalSalesAmount:
          (json['total_sales_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}