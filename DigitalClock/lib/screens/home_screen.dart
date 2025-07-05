// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  String _timeString = '';
  int _selectedTimeZoneOffset = 0;
  Color _clockColor = Colors.red;
  String _mode = 'Clock';

  @override
  void initState() {
    super.initState();
    _getTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    if (_mode == 'Clock') {
      final String formattedDateTime = DateFormat('HH:mm:ss').format(
        DateTime.now().toUtc().add(Duration(minutes: _selectedTimeZoneOffset)),
      );
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  void _openSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          offset: _selectedTimeZoneOffset,
          color: _clockColor,
          mode: _mode,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedTimeZoneOffset = result['offset'];
        _clockColor = result['color'];
        _mode = result['mode'];
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget modeWidget;

    switch (_mode) {
      case 'Stopwatch':
        modeWidget = _buildPlaceholder("Stopwatch ⏱ coming soon!");
        break;
      case 'Timer':
        modeWidget = _buildPlaceholder("Timer ⏲ coming soon!");
        break;
      case 'Alarm':
        modeWidget = _buildPlaceholder("Alarm ⏰ coming soon!");
        break;
      case 'Clock':
      default:
        modeWidget = _buildClock();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: modeWidget),
          Positioned(
            right: 20,
            top: 50,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: _openSettings,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildClock() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _timeString
            .split("")
            .map((char) => Text(
                  char,
                  style: TextStyle(
                    fontFamily: 'Digital',
                    fontSize: 140,
                    color: _clockColor,
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 28,
        fontFamily: 'Digital',
      ),
    );
  }
}
