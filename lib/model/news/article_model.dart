import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ArticleModel {
  ArticleModel({ 
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

   
  @HiveField(0)
  final String author;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? url;
  @HiveField(4)
  final String? urlToImage;
  @HiveField(5)
  final String? content;
  

  factory ArticleModel.fromJson(Map<String, dynamic> json){
    return ArticleModel( 
      author: json["author"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      content: json["content"] ?? "",
    );
  }

}

 