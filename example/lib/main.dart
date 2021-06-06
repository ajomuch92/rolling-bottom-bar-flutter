import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Bottom Bar'),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          ColoredBox(color: Colors.blueGrey.shade100),
          ColoredBox(color: Colors.redAccent),
          ColoredBox(color: Colors.greenAccent),
          ColoredBox(color: Colors.yellowAccent),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        items: [
          RollingBottomBarItem(Icons.home, label: 'Page 1', activeColor: Colors.redAccent),
          RollingBottomBarItem(Icons.star, label: 'Page 2', activeColor: Colors.blueAccent),
          RollingBottomBarItem(Icons.person, label: 'Page 3', activeColor: Colors.yellowAccent),
          RollingBottomBarItem(Icons.access_alarm, label: 'Page 4', activeColor: Colors.orangeAccent),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
