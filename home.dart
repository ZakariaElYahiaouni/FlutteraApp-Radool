import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Teacher {
  final String name;
  final String subject;
  final String location;
  final String imageUrl;
  final String email;
  final String phone;

  Teacher({
    required this.name,
    required this.subject,
    required this.location,
    required this.imageUrl,
    required this.email,
    required this.phone,
  });
}

final List<Teacher> teachers = [
  Teacher(
    name: 'John Smith',
    subject: 'Mathematics',
    location: 'New York',
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/01/31/19/07/avatar-2026510_960_720.png',
    email: 'john.smith@example.com',
    phone: '123-456-7890',
  ),
  Teacher(
    name: 'Jane Doe',
    subject: 'English',
    location: 'San Francisco',
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
    email: 'jane.doe@example.com',
    phone: '555-555-5555',
  ),
  Teacher(
    name: 'David Lee',
    subject: 'Science',
    location: 'Los Angeles',
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/03/24/17/19/teacher-295387_960_720.png',
    email: 'david.lee@example.com',
    phone: '987-654-3210',
  ),
];

class TeacherMatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Match'),
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherProfilePage(
                        teacher: teachers[index],
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(teachers[index].imageUrl),
                        radius: 30,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teachers[index].name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          teachers[index].subject,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          teachers[index].location,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TeacherProfilePage extends StatelessWidget {
  final Teacher teacher;

  TeacherProfilePage({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teacher.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(teacher.imageUrl),
                radius: 60,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${teacher.name}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Subject: ${teacher.subject}',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Location: ${teacher.location}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${teacher.email}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10),
                Text(
                  teacher.phone,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                launch('mailto:${teacher.email}');
              },
              child: Text('Contact Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
