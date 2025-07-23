import 'package:flutter/material.dart';
import 'package:get/get.dart';

CounterController controller = CounterController();

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          children: [
            GetBuilder(
              init: controller,
              builder: (ctl) {
                return Text(
                  '${ctl.count}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              }
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen();
              }));
            }, child: Text('Go to Profile'))
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.decrement();
            },
            child: Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              controller.increment();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: GetBuilder(
          init: controller,
          builder: (_) {
            return Text(
              controller.count.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          }
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.decrement();
            },
            child: Icon(Icons.remove),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              controller.increment();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class CounterController extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }
}
