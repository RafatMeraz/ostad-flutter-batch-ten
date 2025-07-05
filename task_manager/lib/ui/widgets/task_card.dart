import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title will be here',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Description', style: TextStyle(color: Colors.black54)),
            Text('Date: 12/12/12'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text('New', style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
