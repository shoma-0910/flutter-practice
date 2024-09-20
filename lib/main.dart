import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Custom App'),
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
  List<String> _history = []; // カウンターの履歴を保持するリスト

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _controller.forward(from: 0);

      if (_counter == 10) {
        _showAchievementDialog();
      } else if (_counter == 20) {
        _showCustomMessageDialog("Amazing!", "20回達成！素晴らしい！");
      }

      // カウンターの履歴に追加
      _history.add("Incremented to $_counter");
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _history.add("Decremented to $_counter");
      } else {
        _showWarningDialog("警告", "カウントは0未満にできません！");
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _history.add("Reset to $_counter");
    });
  }

  // カウントが0以下になった時の警告ダイアログ
  void _showWarningDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

  // 成績達成のダイアログ
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

  // カスタムメッセージダイアログ
  void _showCustomMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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
      return Colors.greenAccent;
    } else if (_counter >= 10) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.deepPurpleAccent;
    }
  }

  // カウント数に応じたメッセージ
  String _getMessage() {
    if (_counter >= 20) {
      return "20回超え！すごい！";
    } else if (_counter >= 10) {
      return "10回達成！あと少し！";
    } else {
      return "押して続けて！";
    }
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
          'カスタマイズされたカウンター',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print('Settings tapped');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 赤い背景のコンテナとテキスト
          Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('コンテナの中身だよ', style: TextStyle(color: Colors.white)),
                Text('入力されたコメント: $_inputText', style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          // カウントアニメーションと背景変更
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
                        fontSize: 28,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ScaleTransition(
                      scale: _animation,
                      child: Text(
                        '$_counter',
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // テキストボックスを追加
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'コメント入力',
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
                        color: Colors.black,
                      ),
                    ),

                    // カウンターの履歴を表示
                    Expanded(
                      child: ListView.builder(
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_history[index], style: const TextStyle(color: Colors.white)),
                          );
                        },
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
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
