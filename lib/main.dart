import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isRunning = false;
  late DateTime _startTime;
  late Duration _elapsedTime;
  late String _timerText;

  @override
  void initState() {
    super.initState();
    _elapsedTime = Duration.zero;
    _timerText = _formatDuration(_elapsedTime);
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _elapsedTime = DateTime.now().difference(_startTime);
      } else {
        _startTime = DateTime.now().subtract(_elapsedTime);
      }
      _isRunning = !_isRunning;

      // Iniciar o loop de atualização do cronômetro
      _updateTimer();
    });
  }

  void _resetTimer() {
    setState(() {
      _elapsedTime = Duration.zero;
      _timerText = _formatDuration(_elapsedTime);
    });
  }

  void _updateTimer() {
    if (_isRunning) {
      setState(() {
        _timerText = _formatDuration(DateTime.now().difference(_startTime));
      });

      Future.delayed(const Duration(seconds: 1), _updateTimer);
    }
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cronômetro:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _timerText,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (!_isRunning)
              ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 41, 13, 145), // Definir a cor vermelha
                ),
                child: Text(
                  'Zerar',
                  style: TextStyle(
                      color: Colors.white), // Definir cor do texto como branco
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleTimer();
        },
        tooltip: 'Toggle Timer',
        child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
