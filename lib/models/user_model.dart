class SocialUserModel{
   String name;
   String email;
   String uId;
   String phone;
   String image;
   String cover;
   String bio;
   bool isEmailVerified;

   SocialUserModel({
     this.name,
     this.email,
     this.uId,
     this.phone,
     this.isEmailVerified,
     this.image,
     this.cover,
     this.bio,
});

   SocialUserModel.fromJson(Map<String,dynamic> json){
     email = json['email'];
     name = json['name'];
     uId = json['uId'];
     phone = json['phone'];
     isEmailVerified = json['isEmailVerified'];
     image = json['image'];
     cover = json['cover'];
     bio = json['bio'];
   }

   Map<String, dynamic>toMap(){
     return{
       'name':name,
       'email':email,
       'isEmailVerified':isEmailVerified,
       'phone':phone,
       'uId': uId,
       'image' : image,
       'cover': cover,
       'bio' : bio,
     };
   }

}