import 'package:flutter/material.dart';
import 'https/http_posts_repository.dart';
import 'repository/post_repository1.dart';
import 'package:provider/provider.dart';
import 'ui/providers/post_provider.dart';
import 'ui/screens/post_screen1.dart';

void main() {

  PostRepository1 postRepo = HttpPostsRepository() ;


  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider1(repository: postRepo),
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen()),
    ),
  );
}