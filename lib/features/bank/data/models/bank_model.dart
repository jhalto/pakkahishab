class BankAmountResponse {
  final List<BankAmountItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  BankAmountResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory BankAmountResponse.fromJson(Map<String, dynamic> json) {
    return BankAmountResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => BankAmountItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
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

class BankAmountItem {
  final String mobile;
  final String password;
  final String vDate;
  final String voucher;
  final String? particulars;
  final int debit;
  final int credit;
  final int balance;

  BankAmountItem({
    required this.mobile,
    required this.password,
    required this.vDate,
    required this.voucher,
    required this.particulars,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  factory BankAmountItem.fromJson(Map<String, dynamic> json) {
    return BankAmountItem(
      mobile: json['mobile'],
      password: json['password'],
      vDate: json['v_date'],
      voucher: json['voucher'],
      particulars: json['particulars'],
      debit: json['debit'],
      credit: json['credit'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'password': password,
      'v_date': vDate,
      'voucher': voucher,
      'particulars': particulars,
      'debit': debit,
      'credit': credit,
      'balance': balance,
    };
  }
}