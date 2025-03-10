import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/sample.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: [
          // Video Streaming Section (Static)
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black,
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Four Scrollable Sections (Placeholder for Charts)
                  for (int i = 0; i < 4; i++)
                    Container(
                      width: double.infinity,
                      height: 200,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Colors.primaries[i % Colors.primaries.length]),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey[800],
                      ),
                      child: Center(
                        child: Text(
                          "Map/Chart Section ${i + 1}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  SizedBox(height: 80), // Space for Footer
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Value ${index + 1}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
