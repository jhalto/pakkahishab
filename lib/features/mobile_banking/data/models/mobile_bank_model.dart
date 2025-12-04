class MobileBankingModel {
  final List<MobileBankingItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  const MobileBankingModel({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory MobileBankingModel.fromJson(Map<String, dynamic> json) {
    return MobileBankingModel(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => MobileBankingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] ?? false,
      limit: json['limit'] ?? 0,
      offset: json['offset'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((e) => e.toJson()).toList(),
      "hasMore": hasMore,
      "limit": limit,
      "offset": offset,
      "count": count,
    };
  }
}

class MobileBankingItem {
  final String mobile;
  final String password;
  final DateTime? vDate;
  final String voucher;
  final String? particulars;
  final num debit;
  final num credit;
  final num balance;

  const MobileBankingItem({
    required this.mobile,
    required this.password,
    required this.voucher,
    required this.debit,
    required this.credit,
    required this.balance,
    this.vDate,
    this.particulars,
  });

  factory MobileBankingItem.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value.toString());
      } catch (_) {
        return null;
      }
    }

    return MobileBankingItem(
      mobile: json['mobile'] ?? '',
      password: json['password'] ?? '',
      vDate: parseDate(json['v_date']),
      voucher: json['voucher'] ?? '',
      particulars: json['particulars'],
      debit: json['debit'] ?? 0,
      credit: json['credit'] ?? 0,
      balance: json['balance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "password": password,
      "v_date": vDate?.toIso8601String(),
      "voucher": voucher,
      "particulars": particulars,
      "debit": debit,
      "credit": credit,
      "balance": balance,
    };
  }
}