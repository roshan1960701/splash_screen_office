import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:splash_screen/second.dart';
import 'package:splash_screen/third.dart';

class fourth extends StatefulWidget {
  @override
  _fourthState createState() => _fourthState();
}

class _fourthState extends State<fourth> {
  Animation<double> animation;
  Animation<double> secondaryAnimation;
  int _selectedIndex = 0;
  final List<Color> _colors = [Colors.white, Colors.red, Colors.yellow];
  @override
  void initState() {
    print("THIS is initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PageTransitionSwitcher(
              // reverse: true, // uncomment to see transition in reverse
              transitionBuilder: (
                Widget child,
                Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child);
              },
              child: Container(
                  key: ValueKey<int>(_selectedIndex),
                  color: _colors[_selectedIndex],
                  child: Center(
                    child: FlutterLogo(size: 300),
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('White'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Red'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Yellow'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class _TransitionListTile extends StatelessWidget {
  const _TransitionListTile({
    this.onTap,
    this.title,
    this.subtitle,
  });

  final GestureTapCallback onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 35,
        ),
      ),
      onTap: onTap,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
