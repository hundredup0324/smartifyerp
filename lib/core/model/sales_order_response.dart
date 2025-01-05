import 'package:attendance/core/model/request_data_response.dart';

class SalesOrderResponse {
  int? status;
  Data? data;
  String? message;

  SalesOrderResponse({this.status, this.data});

  SalesOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<SalesOrderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SalesOrderData>[];
      json['data'].forEach((v) {
        data!.add(new SalesOrderData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class SalesOrderData {
  int? id;
  String? orderNumber;
  String? name;
  String? quote;
  String? opportunity;
  String? status;
  String? account;
  String? amount;
  String? dateQuoted;
  int? quoteNumber;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? billingCountry;
  int? billingPostalcode;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingCountry;
  int? shippingPostalcode;
  String? billingContact;
  String? shippingContact;
  String? shippingProvider;
  DropdownModel? tax;
  String? assignedUser;
  String? description;
  int? assignUserId;
  int? billingContactId;
  int? shippingContactId;
  int? opportunityId;
  int? quoteId;
  int? shippingProviderId;

  SalesOrderData(
      {this.id,
      this.orderNumber,
      this.name,
      this.quote,
      this.opportunity,
      this.status,
      this.account,
      this.amount,
      this.dateQuoted,
      this.quoteNumber,
      this.billingAddress,
      this.billingCity,
      this.billingState,
      this.billingCountry,
      this.billingPostalcode,
      this.shippingAddress,
      this.shippingCity,
      this.shippingState,
      this.shippingCountry,
      this.shippingPostalcode,
      this.billingContact,
      this.shippingContact,
      this.shippingProvider,
      this.tax,
      this.assignedUser,
      this.description,
      this.assignUserId,
      this.billingContactId,
      this.shippingContactId,
      this.opportunityId,
        this.quoteId,
      this.shippingProviderId});

  SalesOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    name = json['name'];
    quote = json['quote'];
    opportunity = json['opportunity'];
    status = json['status'];
    account = json['account'];
    amount = json['amount'];
    dateQuoted = json['date_quoted'];
    quoteNumber = json['quote_number'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingCountry = json['billing_country'];
    billingPostalcode = json['billing_postalcode'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingCountry = json['shipping_country'];
    shippingPostalcode = json['shipping_postalcode'];
    billingContact = json['billing_contact'];
    shippingContact = json['shipping_contact'];
    shippingProvider = json['shipping_provider'];
    quoteId = json['quote_id'];
    tax = json['tax'] != null ? DropdownModel.fromJson(json['tax']) : null;

    assignedUser = json['assigned_user'];
    description = json['description'];
    assignUserId = json['assign_user_id'];
    billingContactId = json['billing_contact_id'];
    shippingContactId = json['shipping_contact_id'];
    opportunityId = json['opportunity_id'];
    shippingProviderId = json['shipping_provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['name'] = this.name;
    data['quote'] = this.quote;
    data['opportunity'] = this.opportunity;
    data['status'] = this.status;
    data['account'] = this.account;
    data['amount'] = this.amount;
    data['date_quoted'] = this.dateQuoted;
    data['quote_number'] = this.quoteNumber;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_country'] = this.billingCountry;
    data['billing_postalcode'] = this.billingPostalcode;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_postalcode'] = this.shippingPostalcode;
    data['billing_contact'] = this.billingContact;
    data['shipping_contact'] = this.shippingContact;
    data['quote_id'] = this.quoteId;
    data['shipping_provider'] = this.shippingProvider;
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    data['assigned_user'] = this.assignedUser;
    data['description'] = this.description;
    data['assign_user_id'] = this.assignUserId;
    data['billing_contact_id'] = this.billingContactId;
    data['shipping_contact_id'] = this.shippingContactId;
    data['opportunity_id'] = this.opportunityId;
    data['shipping_provider_id'] = this.shippingProviderId;
    return data;
  }
}

class Tax {
  int? id;
  String? name;

  Tax({this.id, this.name});

  Tax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
