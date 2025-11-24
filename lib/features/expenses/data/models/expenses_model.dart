class ExpenseResponse {
  final List<ExpenseItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  ExpenseResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
      items: (json['items'] as List)
          .map((item) => ExpenseItem.fromJson(item))
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

class ExpenseItem {
  final String voucher;
  final String voucherDate;
  final int schoolCode;
  final String projectCode;
  final String debitCredit;
  final String accountNo;
  final String status;
  final String? particulars;
  final String accountName;
  final int amount;
  final String voucherStatus;
  final String? chequeNo;
  final String? transectionId;
  final dynamic paymentPhoneNo;
  final String? createdBy;
  final String password;
  final String mobile;
  final int totalExpenses;

  ExpenseItem({
    required this.voucher,
    required this.voucherDate,
    required this.schoolCode,
    required this.projectCode,
    required this.debitCredit,
    required this.accountNo,
    required this.status,
    this.particulars,
    required this.accountName,
    required this.amount,
    required this.voucherStatus,
    this.chequeNo,
    this.transectionId,
    this.paymentPhoneNo,
    this.createdBy,
    required this.password,
    required this.mobile,
    required this.totalExpenses
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      voucher: json['voucher'] ?? "",
      voucherDate: json['voucher_date'] ?? "",
      schoolCode: json['school_code'] ?? 0,
      projectCode: json['project_code'] ?? "",
      debitCredit: json['debit_credit'] ?? "",
      accountNo: json['account_no'] ?? "",
      status: json['status'] ?? "",
      particulars: json['particulars'],
      accountName: json['account_name'] ?? "",
      amount: json['amount'] ?? 0,
      voucherStatus: json['voucher_status'] ?? "",
      chequeNo: json['cheque_no'],
      transectionId: json['transection_id'],
      paymentPhoneNo: json['payment_phoneno'],
      createdBy: json['created_by'],
      password: json['password'] ?? "",
      mobile: json['mobile'] ?? "",
      totalExpenses: json['total_expense'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher': voucher,
      'voucher_date': voucherDate,
      'school_code': schoolCode,
      'project_code': projectCode,
      'debit_credit': debitCredit,
      'account_no': accountNo,
      'status': status,
      'particulars': particulars,
      'account_name': accountName,
      'amount': amount,
      'voucher_status': voucherStatus,
      'cheque_no': chequeNo,
      'transection_id': transectionId,
      'payment_phoneno': paymentPhoneNo,
      'created_by': createdBy,
      'password': password,
      'mobile': mobile,
      'total_expense': totalExpenses,
    };
  }
}
