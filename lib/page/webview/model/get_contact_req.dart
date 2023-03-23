class GetContactReq {
  String? sUserName;
  String? sPassword;
  String? sType;
  String? sHpNumber;

  GetContactReq({this.sUserName, this.sPassword, this.sType, this.sHpNumber});

  GetContactReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
    sType = json['_Type'];
    sHpNumber = json['_HpNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    data['_Type'] = this.sType;
    data['_HpNumber'] = this.sHpNumber;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_Type': this.sType,
      '_HpNumber': this.sHpNumber,
    };
  }
}

class TwoFAReq {
  String? sUserName;
  String? sPassword;

  TwoFAReq({this.sUserName, this.sPassword});

  TwoFAReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
    };
  }
}