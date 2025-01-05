import 'package:attendance/core/model/request_data_response.dart';

class MeetingRequestData {
  int? status;
  Data? data;
  String? message;

  MeetingRequestData({this.status, this.data});

  MeetingRequestData.fromJson(Map<String, dynamic> json) {
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
  List<String>? parent;
  List<DropdownModel>? account;
  List<DropdownModel>? lead;
  List<DropdownModel>? contact;
  List<DropdownModel>? users;
  List<DropdownModel>? opportunities;
  List<DropdownModel>? caseList;

  Data(
      {this.parent,
      this.account,
      this.lead,
      this.users,
      this.contact,
      this.opportunities,
      this.caseList});

  Data.fromJson(Map<String, dynamic> json) {
    parent = json['parent'].cast<String>();
    if (json['account'] != null) {
      account = <DropdownModel>[];
      json['account'].forEach((v) {
        account!.add(DropdownModel.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <DropdownModel>[];
      json['users'].forEach((v) {
        users!.add(DropdownModel.fromJson(v));
      });
    }
    if (json['lead'] != null) {
      lead = <DropdownModel>[];
      json['lead'].forEach((v) {
        lead!.add(DropdownModel.fromJson(v));
      });
    }
    if (json['contact'] != null) {
      contact = <DropdownModel>[];
      json['contact'].forEach((v) {
        contact!.add(DropdownModel.fromJson(v));
      });
    }
    if (json['opportunities'] != null) {
      opportunities = <DropdownModel>[];
      json['opportunities'].forEach((v) {
        opportunities!.add(DropdownModel.fromJson(v));
      });
    }
    if (json['case'] != null) {
      caseList = <DropdownModel>[];
      json['case'].forEach((v) {
        caseList!.add(DropdownModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent'] = parent;
    if (account != null) {
      data['account'] = account!.map((v) => v.toJson()).toList();
    }
    if (lead != null) {
      data['lead'] = lead!.map((v) => v.toJson()).toList();
    }
    if (contact != null) {
      data['contact'] = contact!.map((v) => v.toJson()).toList();
    }
    if (opportunities != null) {
      data['opportunities'] =
          opportunities!.map((v) => v.toJson()).toList();
    }
    if (caseList != null) {
      data['case'] = caseList!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['case'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
