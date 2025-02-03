

class UserModel {
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });

  // Convert JSON to SavedDetailsModel
 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(name: json["name"]??"User",
      email:json["email"]??"", 
    );
  }
}
