import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  String _inputText = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _controller.forward(from: 0);

      if (_counter == 10) {
        _showAchievementDialog();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }


  void _showAchievementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("おめでとう！"),
          content: const Text("10回達成しました！"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // カウント数に応じて背景色を変更
  Color _getBackgroundColor() {
    if (_counter >= 20) {
      return Colors.green;
    } else if (_counter >= 10) {
      return Colors.blueAccent;
    } else {
      return Colors.deepPurpleAccent;
    }
  }

  // カウント数に応じて表示するメッセージ
  String _getMessage() {
    return "押して";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'aaa',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search icon tapped');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 赤い背景のコンテナとテキスト
          Container(
            color: Colors.red,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('コンテナの中身だよ'),
                Text('どうも、弟です。'),
              ],
            ),
          ),

          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_getBackgroundColor(), Colors.indigo],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _getMessage(),
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ScaleTransition(
                      scale: _animation,
                      child: Text(
                        '$_counter',
                        style: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'コメント入力して',
                        ),
                        onChanged: (text) {
                          setState(() {
                            _inputText = text;
                          });
                        },
                      ),
                    ),

                    // 入力されたテキストを表示
                    Text(
                      'テキスト: $_inputText',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 30),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
