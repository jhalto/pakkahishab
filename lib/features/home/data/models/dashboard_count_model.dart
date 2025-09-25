class DashboardResponse {
  final List<DashboardItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;
  final List<Link> links;

  DashboardResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
    required this.links,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      items: (json['items'] as List)
          .map((e) => DashboardItem.fromJson(e))
          .toList(),
      hasMore: json['hasMore'],
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
      links: (json['links'] as List).map((e) => Link.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
        'hasMore': hasMore,
        'limit': limit,
        'offset': offset,
        'count': count,
        'links': links.map((e) => e.toJson()).toList(),
      };
}

class DashboardItem {
  final String metric;
  final double amount;
  final int schoolCode;
  final String? txnDate;

  DashboardItem({
    required this.metric,
    required this.amount,
    required this.schoolCode,
    this.txnDate,
  });

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
      metric: json['metric'],
      amount: (json['amount'] as num).toDouble(),
      schoolCode: json['school_code'],
      txnDate: json['txn_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'metric': metric,
        'amount': amount,
        'school_code': schoolCode,
        'txn_date': txnDate,
      };
}

class Link {
  final String rel;
  final String href;

  Link({required this.rel, required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      rel: json['rel'],
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() => {
        'rel': rel,
        'href': href,
      };
}