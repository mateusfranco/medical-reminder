import 'package:flutter/material.dart';
import 'package:medical_reminder/screens/today_screen.dart';
import 'package:medical_reminder/screens/tratment_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const ScreenWidget(
      index: 0,
      widget: TodayScreen(),
    ),
    const ScreenWidget(
      index: 1,
      widget: TratmentScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(color: Color.fromARGB(97, 103, 15, 185), width: 2.0),
          )),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: const Color.fromARGB(97, 103, 15, 185),
                ),
                label: 'Hoje',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _selectedIndex == 0 ? Icons.medication : Icons.medication_outlined,
                  color: const Color.fromARGB(97, 103, 15, 185),
                ),
                label: 'Tratamentos',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 81, 0, 100),
            onTap: _onItemTapped,
          ),
        ));
  }
}


class ScreenWidget extends StatelessWidget {
  final int index;
  final Widget widget;
  const ScreenWidget({super.key, required this.index, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget,
    );
  }
}
