import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final name;
  final review;
  ReviewCard({this.name, this.review});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text(name),
        subtitle: Text(review),
      ),
    );
  }
}