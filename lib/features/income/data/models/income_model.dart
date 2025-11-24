class IncomeResponse {
  final List<IncomeItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  IncomeResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory IncomeResponse.fromJson(Map<String, dynamic> json) {
    return IncomeResponse(
      items: (json['items'] as List)
          .map((e) => IncomeItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
    );
  }
}

class IncomeItem {
  final String voucher;
  final String voucherDate;
  final int schoolCode;
  final String projectCode;
  final String debitCredit;
  final String accountNo;
  final String status;
  final String? particulars;
  final String? accountName;
  final double amount;
  final String voucherStatus;
  final String? chequeNo;
  final String? transectionId;
  final int? paymentPhoneNo;
  final String? createdBy;
  final String password;
  final String mobile;
  final int totalIncome;

  IncomeItem({
    required this.voucher,
    required this.voucherDate,
    required this.schoolCode,
    required this.projectCode,
    required this.debitCredit,
    required this.accountNo,
    required this.status,
    required this.particulars,
    required this.accountName,
    required this.amount,
    required this.voucherStatus,
    required this.chequeNo,
    required this.transectionId,
    required this.paymentPhoneNo,
    required this.createdBy,
    required this.password,
    required this.mobile,
    required this.totalIncome,
  });

  factory IncomeItem.fromJson(Map<String, dynamic> json) {
    return IncomeItem(
      voucher: json['voucher'],
      voucherDate: json['voucher_date'],
      schoolCode: json['school_code'],
      projectCode: json['project_code'],
      debitCredit: json['debit_credit'],
      accountNo: json['account_no'],
      status: json['status'],
      particulars: json['particulars'],
      accountName: json['account_name'],
      amount: (json['amount'] as num).toDouble(),
      voucherStatus: json['voucher_status'],
      chequeNo: json['cheque_no'],
      transectionId: json['transection_id'],
      paymentPhoneNo: json['payment_phoneno'],
      createdBy: json['created_by'],
      password: json['password'],
      mobile: json['mobile'],
      totalIncome: json['total_income'],
    );
  }
}