class PostModel{
  String name;
  String image;
  String text;
  String postImage;
  String date;
  String uId;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.date,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    text = json['text'];
    name = json['name'];
    uId = json['uId'];
    postImage = json['postImage'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic>toMap(){
    return{
      'name':name,
      'date':date,
      'postImage':postImage,
      'uId': uId,
      'image' : image,
      'text' : text,
    };
  }

}