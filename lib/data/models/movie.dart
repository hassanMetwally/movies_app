class Movie{
  late int movieId;
  late String name;
  late String status;
  late String type;
  late String gender;
  late String address;
  late String image;

  Movie.fromJson(Map<String, dynamic> json){
    movieId = json['id'];
    name = json['name'];
    status = json['status'];
    type = json['type'];
    gender = json['gender'];
    address = json['location']['name'];
    image = json['image'];
  }

}