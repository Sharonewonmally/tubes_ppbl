import 'package:flutter/material.dart';

class ForumCard extends StatelessWidget {

  final Map<String, dynamic> forum;

  final VoidCallback onTap;

  final VoidCallback onLongPress;

  const ForumCard({
    super.key,
    required this.forum,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(16),
      ),

      child: ListTile(

        onTap: onTap,

        onLongPress: onLongPress,

        leading: const CircleAvatar(

          backgroundColor:
          Colors.blue,

          child: Icon(
            Icons.forum,
            color: Colors.white,
          ),
        ),

        title: Text(
          forum['judul'],
        ),

        subtitle: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              forum['genre'],
            ),

            Text(
              "Status : ${forum['status']}",
            ),
          ],
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}