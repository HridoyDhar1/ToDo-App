class TaskModel {
  String?sId;
  String?title;
  String?description;
  String?status;
  String?email;
  String?createDate;
  TaskModel({
this.createDate,this.description,this.email,this.sId,this.status,this.title
  });
  TaskModel.formJson(Map<String,dynamic>json){
    sId=json['_id'];
    title=json['title'];
    description=json['desciription'];
    status=json['status'];
    email=json['email'];
    createDate=json['createDate'];
  }
}