
 class MessageModel{
   int id;
   String createdBy;
   String createdAt;
   String createdFrom;
   String message;
   String recipient;
   bool isRead;

   MessageModel(
       {this.id,
         this.createdBy,
         this.createdAt,
         this.createdFrom,
         this.message,
         this.recipient,
         this.isRead});

   MessageModel.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     createdBy = json['created_by'];
     createdAt = json['created_at'];
     createdFrom = json['created_from'];
     message = json['message'];
     recipient = json['recipient'];
     isRead = json['is_read'];
   }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['created_by'] = this.createdBy;
//    data['created_at'] = this.createdAt;
//    data['created_from'] = this.createdFrom;
//    data['message'] = this.message;
//    data['recipient'] = this.recipient;
//    data['is_read'] = this.isRead;
//    return data;
//  }
 }