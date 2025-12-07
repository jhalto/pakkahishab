class AllCustomerModel {
  final List<AllCustomer> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  AllCustomerModel({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory AllCustomerModel.fromJson(Map<String, dynamic> json) {
    return AllCustomerModel(
      items: json['items'] != null
          ? List<AllCustomer>.from(
              json['items'].map((x) => AllCustomer.fromJson(x)))
          : [],
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((x) => x.toJson()).toList(),
      'hasMore': hasMore,
      'limit': limit,
      'offset': offset,
      'count': count,
    };
  }
}

class AllCustomer {
  final String supplierId;
  final int schoolCode;
  final String supplierName;
  final String deliverReceiver;
  final String? address;
  final String? phone;
  final String? email;
  final DateTime? followUpDate;
  final String password;
  final String mobile;

  AllCustomer({
    required this.supplierId,
    required this.schoolCode,
    required this.supplierName,
    required this.deliverReceiver,
    this.address,
    this.phone,
    this.email,
    this.followUpDate,
    required this.password,
    required this.mobile,
  });

  factory AllCustomer.fromJson(Map<String, dynamic> json) {
    return AllCustomer(
      supplierId: json['supplier_id'] ?? '',
      schoolCode: json['school_code'] ?? 0,
      supplierName: json['supplier_name'] ?? '',
      deliverReceiver: json['deliver_receiver'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      followUpDate: json['follow_up_date'] != null
          ? DateTime.tryParse(json['follow_up_date'])
          : null,
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplierId,
      'school_code': schoolCode,
      'supplier_name': supplierName,
      'deliver_receiver': deliverReceiver,
      'address': address,
      'phone': phone,
      'email': email,
      'follow_up_date': followUpDate?.toIso8601String(),
      'password': password,
      'mobile': mobile,
    };
  }
}
