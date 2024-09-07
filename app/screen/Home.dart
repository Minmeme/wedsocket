import 'dart:convert'; // Import this to use json.decode
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('ws://0.0.0.0:8765'), // Replace with your server's address
  );

  int _heartRate = 0;
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    _channel.stream.listen((data) {
      final jsonData = json.decode(data);
      setState(() {
        _heartRate = jsonData['HeartRate'];
        _steps = jsonData['Step'];
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tracker'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHealthCard(
              icon: Icons.favorite,
              iconColor: Colors.red,
              title: 'Heart Rate',
              value: '$_heartRate BPM',
              // value: '75 BPM',
            ),
            const SizedBox(height: 20),
            _buildHealthCard(
              icon: Icons.directions_walk,
              iconColor: Colors.green,
              title: 'Steps',
              value: '$_steps steps',
              // value: '140 steps',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              child: const Text('View History', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Card(
      color: Colors.blue.shade100,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        leading: Icon(icon, color: iconColor, size: 40),
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
