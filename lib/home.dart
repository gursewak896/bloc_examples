import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';
import 'package:task2/notification_helper.dart';
import 'package:task2/pdf/pdf_home_screen.dart';
import 'package:task2/youtube_videos.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _minutesController = TextEditingController();
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _scheduleNotification() {
    if (_selectedTime != null) {
      final now = TimeOfDay.now();
      int totalMinutes = (_selectedTime!.hour * 60 + _selectedTime!.minute) -
          (now.hour * 60 + now.minute);
      if (totalMinutes < 0) {
        totalMinutes += 1440; // Schedule for next day if time has passed today
      }
      scheduleNotification(totalMinutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showNotification();
                  },
                  child: Text("Immediate Notify")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time'),
              ),
              if (_selectedTime != null)
                Text(
                  'Selected Time: ${_selectedTime!.format(context)}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _scheduleNotification,
                child: Text('Schedule Notification'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _minutesController,
                decoration: const InputDecoration(
                  labelText: 'Enter minutes',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final minutes = int.tryParse(_minutesController.text);
                  if (minutes != null) {
                    scheduleNotification(minutes);
                  }
                },
                child: const Text('Schedule Notification'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => YoutubeScreen()));
                  },
                  child: Text("Youtube Videos")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => pdfScreen()));
                  },
                  child: Text("PDF Page")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    // ZoomService.startMeeting();
                  }, child: Text("Start Zoom Meeting")),
            ],
          ),
        ),
      ),
    );
  }
}
