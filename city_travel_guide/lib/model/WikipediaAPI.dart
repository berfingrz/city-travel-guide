import 'package:flutter/material.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String extract;
  final Content content;

  Post(
      {@required this.userId,
      @required this.id,
      @required this.title,
      @required this.extract,
      @required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        extract: json['extract'],
        content: Content.fromJson(json['content_urls']));
  }
}

class Mobile {
  final String page;
  Mobile({this.page});

  factory Mobile.fromJson(Map<String, dynamic> json) {
    return Mobile(
      page: json['page'],
    );
  }
}

class Content {
  Mobile mobile;
  Content({this.mobile});
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(mobile: Mobile.fromJson(json['mobile']));
  }
}
