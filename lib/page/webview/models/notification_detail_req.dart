class NotificationDetailReq {
  String? sUserName;
  String? sPassword;
  String? sEnvironment;

  NotificationDetailReq({this.sUserName, this.sPassword, this.sEnvironment});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_Environment': this.sEnvironment
    };
  }
}