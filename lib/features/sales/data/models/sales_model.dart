import 'dart:convert';

SalesResponse salesResponseFromJson(String str) =>
    SalesResponse.fromJson(json.decode(str));

String salesResponseToJson(SalesResponse data) => json.encode(data.toJson());

class SalesResponse {
  final List<SalesItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SalesResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory SalesResponse.fromJson(Map<String, dynamic> json) => SalesResponse(
        items: List<SalesItem>.from(
          (json["items"] ?? []).map((x) => SalesItem.fromJson(x)),
        ),
        hasMore: json["hasMore"] ?? false,
        limit: json["limit"] ?? 0,
        offset: json["offset"] ?? 0,
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
      };
}

class SalesItem {
  final String salesNo;
  final DateTime salesDate;
  final String customerName;
  final String customerPhone;
  final int netAmount;
  final int paidPrice;
  final int due;
  final String? description; // ✅ null safety here
  final int totalCount;
  final int totalNetAmount;

  SalesItem({
    required this.salesNo,
    required this.salesDate,
    required this.customerName,
    required this.customerPhone,
    required this.netAmount,
    required this.paidPrice,
    required this.due,
    this.description,
    required this.totalCount,
    required this.totalNetAmount,
  });

  factory SalesItem.fromJson(Map<String, dynamic> json) => SalesItem(
        salesNo: json["sales_no"] ?? "",
        salesDate: DateTime.tryParse(json["sales_date"] ?? "") ?? DateTime.now(),
        customerName: json["customer_name"] ?? "",
        customerPhone: json["customer_phoneno"] ?? "",
        netAmount: json["net_amount"] ?? 0,
        paidPrice: json["paid_price"] ?? 0,
        due: json["due"] ?? 0,
        description: json["description"], // can be null
        totalCount: json["total_count"] ?? 0,
        totalNetAmount: json["total_net_amount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "sales_no": salesNo,
        "sales_date": salesDate.toIso8601String(),
        "customer_name": customerName,
        "customer_phoneno": customerPhone,
        "net_amount": netAmount,
        "paid_price": paidPrice,
        "due": due,
        "description": description,
        "total_count": totalCount,
        "total_net_amount": totalNetAmount,
      };
}