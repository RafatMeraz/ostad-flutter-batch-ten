import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const LiveScoreApp());
}

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

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
  List<LiveScore> _listOfScore = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _getLiveScoreData() async {
    _listOfScore.clear();
    final QuerySnapshot<Map<String, dynamic>> snapshots = await db
        .collection('football')
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      LiveScore liveScore = LiveScore(
        id: doc.id,
        team1Name: doc.get('team1_name'),
        team2Name: doc.get('team2_name'),
        team1Score: doc.get('team1_score'),
        team2Score: doc.get('team2_score'),
        isRunning: doc.get('is_running'),
        winnerTeam: doc.get('winner_team'),
      );
      _listOfScore.add(liveScore);
    }
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _getLiveScoreData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: StreamBuilder(
        stream: db.collection('football').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {

          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshots.hasError) {
            return Center(child: Text(snapshots.error.toString()));
          }

          if (snapshots.hasData) {
            _listOfScore.clear();
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.data!.docs) {
              LiveScore liveScore = LiveScore(
                id: doc.id,
                team1Name: doc.get('team1_name'),
                team2Name: doc.get('team2_name'),
                team1Score: doc.get('team1_score'),
                team2Score: doc.get('team2_score'),
                isRunning: doc.get('is_running'),
                winnerTeam: doc.get('winner_team'),
              );
              _listOfScore.add(liveScore);
            }
          }

          return ListView.builder(
            itemCount: _listOfScore.length,
            itemBuilder: (context, index) {
              LiveScore liveScore = _listOfScore[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 8,
                  backgroundColor: liveScore.isRunning ? Colors.green : Colors.grey,
                ),
                title: Text(liveScore.id),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(liveScore.team1Name),
                        Text('  vs  '),
                        Text(liveScore.team2Name),
                      ],
                    ),
                    Text('Is Running: ${liveScore.isRunning}'),
                    Text('Winner Team: ${liveScore.winnerTeam}'),
                  ],
                ),
                trailing: Text(
                  '${liveScore.team1Score} : ${liveScore.team2Score}',
                  style: TextStyle(fontSize: 24),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

class LiveScore {
  final String id;
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;
  final bool isRunning;
  final String winnerTeam;

  LiveScore({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
    required this.isRunning,
    required this.winnerTeam,
  });
}
