
class SalesDetailsResponse {
  final List<SalesDetailItem> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;

  SalesDetailsResponse({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory SalesDetailsResponse.fromJson(Map<String, dynamic> json) =>
      SalesDetailsResponse(
        items: List<SalesDetailItem>.from(
          (json["items"] ?? []).map((x) => SalesDetailItem.fromJson(x)),
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

class SalesDetailItem {
  final String salesNo;
  final DateTime salesDate;
  final String customerName;
  final String? product; // nullable
  final int? quantity;
  final int? unitPrice;
  final int? subTotal;
  final int netAmount;
  final int paidPrice;
  final int due;

  SalesDetailItem({
    required this.salesNo,
    required this.salesDate,
    required this.customerName,
    this.product,
    this.quantity,
    this.unitPrice,
    this.subTotal,
    required this.netAmount,
    required this.paidPrice,
    required this.due,
  });

  factory SalesDetailItem.fromJson(Map<String, dynamic> json) => SalesDetailItem(
        salesNo: json["sales_no"] ?? "",
        salesDate: DateTime.tryParse(json["sales_date"] ?? "") ?? DateTime.now(),
        customerName: json["customer_name"] ?? "",
        product: json["product"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        subTotal: json["sub_total"],
        netAmount: json["net_amount"] ?? 0,
        paidPrice: json["paid_price"] ?? 0,
        due: json["due"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "sales_no": salesNo,
        "sales_date": salesDate.toIso8601String(),
        "customer_name": customerName,
        "product": product,
        "quantity": quantity,
        "unit_price": unitPrice,
        "sub_total": subTotal,
        "net_amount": netAmount,
        "paid_price": paidPrice,
        "due": due,
      };
}