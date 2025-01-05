class HomeResponse {
  int? status;
  String? message;
  HomeData? data;

  HomeResponse({this.status, this.message, this.data});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData {
  int? totalSalesorder;
  int? totalOpportunities;
  int? totalInvoice;
  int? totalQuote;
  Invoice? invoice;
  Quote? quote;
  SalesOrder? salesOrder;
  List<LineChartData>? lineChartData;

  HomeData(
      {this.totalSalesorder,
        this.totalOpportunities,
        this.totalInvoice,
        this.totalQuote,
        this.invoice,
        this.quote,
        this.salesOrder,
        this.lineChartData});

  HomeData.fromJson(Map<String, dynamic> json) {
    totalSalesorder = json['totalSalesorder'];
    totalOpportunities = json['totalOpportunities'];
    totalInvoice = json['totalInvoice'];
    totalQuote = json['totalQuote'];
    invoice =
    json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    salesOrder = json['salesOrder'] != null
        ? new SalesOrder.fromJson(json['salesOrder'])
        : null;
    if (json['lineChartData'] != null) {
      lineChartData = <LineChartData>[];
      json['lineChartData'].forEach((v) {
        lineChartData!.add(new LineChartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSalesorder'] = this.totalSalesorder;
    data['totalOpportunities'] = this.totalOpportunities;
    data['totalInvoice'] = this.totalInvoice;
    data['totalQuote'] = this.totalQuote;
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    if (this.quote != null) {
      data['quote'] = this.quote!.toJson();
    }
    if (this.salesOrder != null) {
      data['salesOrder'] = this.salesOrder!.toJson();
    }
    if (this.lineChartData != null) {
      data['lineChartData'] =
          this.lineChartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  String? invoiceOpenPercentage;
  int? invoiceOpenCount;
  String? invoiceNotPaidPercentage;
  int? invoiceNotPaidCount;
  String? invoicePartialyPaidPercentage;
  int? invoicePartialyPaidCount;
  String? invoicePaidPercentage;
  int? invoicePaidCount;
  String? invoiceCancelledPercentage;
  int? invoiceCancelledCount;

  Invoice(
      {this.invoiceOpenPercentage,
        this.invoiceOpenCount,
        this.invoiceNotPaidPercentage,
        this.invoiceNotPaidCount,
        this.invoicePartialyPaidPercentage,
        this.invoicePartialyPaidCount,
        this.invoicePaidPercentage,
        this.invoicePaidCount,
        this.invoiceCancelledPercentage,
        this.invoiceCancelledCount});

  Invoice.fromJson(Map<String, dynamic> json) {
    invoiceOpenPercentage = json['invoice_Open_percentage'];
    invoiceOpenCount = json['invoice_Open_count'];
    invoiceNotPaidPercentage = json['invoice_Not Paid_percentage'];
    invoiceNotPaidCount = json['invoice_Not Paid_count'];
    invoicePartialyPaidPercentage = json['invoice_Partialy Paid_percentage'];
    invoicePartialyPaidCount = json['invoice_Partialy Paid_count'];
    invoicePaidPercentage = json['invoice_Paid_percentage'];
    invoicePaidCount = json['invoice_Paid_count'];
    invoiceCancelledPercentage = json['invoice_Cancelled_percentage'];
    invoiceCancelledCount = json['invoice_Cancelled_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_Open_percentage'] = this.invoiceOpenPercentage;
    data['invoice_Open_count'] = this.invoiceOpenCount;
    data['invoice_Not Paid_percentage'] = this.invoiceNotPaidPercentage;
    data['invoice_Not Paid_count'] = this.invoiceNotPaidCount;
    data['invoice_Partialy Paid_percentage'] =
        this.invoicePartialyPaidPercentage;
    data['invoice_Partialy Paid_count'] = this.invoicePartialyPaidCount;
    data['invoice_Paid_percentage'] = this.invoicePaidPercentage;
    data['invoice_Paid_count'] = this.invoicePaidCount;
    data['invoice_Cancelled_percentage'] = this.invoiceCancelledPercentage;
    data['invoice_Cancelled_count'] = this.invoiceCancelledCount;
    return data;
  }
}

class Quote {
  String? quoteOpenPercentage;
  int? quoteOpenCount;
  String? quoteCancelledPercentage;
  int? quoteCancelledCount;

  Quote(
      {this.quoteOpenPercentage,
        this.quoteOpenCount,
        this.quoteCancelledPercentage,
        this.quoteCancelledCount});

  Quote.fromJson(Map<String, dynamic> json) {
    quoteOpenPercentage = json['quote_Open_percentage'];
    quoteOpenCount = json['quote_Open_count'];
    quoteCancelledPercentage = json['quote_Cancelled_percentage'];
    quoteCancelledCount = json['quote_Cancelled_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_Open_percentage'] = this.quoteOpenPercentage;
    data['quote_Open_count'] = this.quoteOpenCount;
    data['quote_Cancelled_percentage'] = this.quoteCancelledPercentage;
    data['quote_Cancelled_count'] = this.quoteCancelledCount;
    return data;
  }
}

class SalesOrder {
  String? salesorderOpenPercentage;
  int? salesorderOpenCount;
  String? salesorderCancelledPercentage;
  int? salesorderCancelledCount;

  SalesOrder(
      {this.salesorderOpenPercentage,
        this.salesorderOpenCount,
        this.salesorderCancelledPercentage,
        this.salesorderCancelledCount});

  SalesOrder.fromJson(Map<String, dynamic> json) {
    salesorderOpenPercentage = json['salesorder_Open_percentage'];
    salesorderOpenCount = json['salesorder_Open_count'];
    salesorderCancelledPercentage = json['salesorder_Cancelled_percentage'];
    salesorderCancelledCount = json['salesorder_Cancelled_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesorder_Open_percentage'] = this.salesorderOpenPercentage;
    data['salesorder_Open_count'] = this.salesorderOpenCount;
    data['salesorder_Cancelled_percentage'] =
        this.salesorderCancelledPercentage;
    data['salesorder_Cancelled_count'] = this.salesorderCancelledCount;
    return data;
  }
}

class LineChartData {
  String? day;
  String? invoiceAmount;
  String? quoteAmount;
  String? salesorderAmount;

  LineChartData(
      {this.day, this.invoiceAmount, this.quoteAmount, this.salesorderAmount});

  LineChartData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    invoiceAmount = json['invoiceAmount'];
    quoteAmount = json['quoteAmount'];
    salesorderAmount = json['salesorderAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['invoiceAmount'] = this.invoiceAmount;
    data['quoteAmount'] = this.quoteAmount;
    data['salesorderAmount'] = this.salesorderAmount;
    return data;
  }
}
