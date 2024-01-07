import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? senderID;
  String? senderEmail;
  String? receiverID;
  Timestamp? timeStamp;
  String? message;

  Message(
      {this.senderID,
      this.senderEmail,
      this.receiverID,
      this.timeStamp,
      this.message});

  Message.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    senderEmail = json['senderEmail'];
    receiverID = json['receiverID'];
    timeStamp = json['timeStamp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderID'] = this.senderID;
    data['senderEmail'] = this.senderEmail;
    data['receiverID'] = this.receiverID;
    data['timeStamp'] = this.timeStamp;
    data['message'] = this.message;
    return data;
  }
}
