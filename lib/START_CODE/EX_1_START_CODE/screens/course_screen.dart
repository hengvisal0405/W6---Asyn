import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});

  final String courseId; // Pass course ID

  void _addScore(BuildContext context) async {
    CourseScore? newScore = await Navigator.of(
      context,
    ).push<CourseScore>(MaterialPageRoute(builder: (ctx) => CourseScoreForm()));

    if (newScore != null) {
      Provider.of<CoursesProvider>(
        context,
        listen: false,
      ).addScore(courseId, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    print('Course screen was builded');
    // TODO - CONNECT TO THE PROVIDER TO GET THE SCORE FROM COURSE ID
    Course? course = Provider.of<CoursesProvider>(
      context,
      listen: true,
    ).getCourse(courseId);

    Widget content = const Center(child: Text('No Scores added yet.'));
    if (course != null) {
      content = ListView.builder(
        itemCount: course.scores.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(course.scores[index].studentName),
          trailing: Text(
            course.scores[index].studenScore.toString(),
            style: TextStyle(
              color: scoreColor(course.scores[index].studenScore),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(course!.name, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => _addScore(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
