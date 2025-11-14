// ignore: camel_case_types
class user 
{
  final int id;
  final String name;
  final String email;
  bool isChecked;

  user({required this.id, required this.name, required this.email, this.isChecked = false});

  factory user.fromJson(Map<String, dynamic> json) 
  {
    return user(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

 Map<String, dynamic> toJson() 
 {
    return 
    {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}