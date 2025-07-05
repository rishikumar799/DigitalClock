// screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final int offset;
  final Color color;
  final String mode;

  SettingsScreen({
    required this.offset,
    required this.color,
    required this.mode,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late int _currentOffset;
  late Color _currentColor;
  late String _selectedMode;

  final List<String> modes = ['Clock', 'Stopwatch', 'Timer', 'Alarm'];

  final List<Map<String, dynamic>> timeZones = [
    {'name': 'Baker Island (UTC−12:00)', 'offset': -720},
    {'name': 'Hawaii (UTC−10:00)', 'offset': -600},
    {'name': 'Alaska (UTC−9:00)', 'offset': -540},
    {'name': 'Los Angeles (UTC−8:00)', 'offset': -480},
    {'name': 'Denver (UTC−7:00)', 'offset': -420},
    {'name': 'Chicago (UTC−6:00)', 'offset': -360},
    {'name': 'New York (UTC−5:00)', 'offset': -300},
    {'name': 'Brazil (UTC−3:00)', 'offset': -180},
    {'name': 'London (UTC+0:00)', 'offset': 0},
    {'name': 'France (UTC+1:00)', 'offset': 60},
    {'name': 'South Africa (UTC+2:00)', 'offset': 120},
    {'name': 'Russia (UTC+3:00)', 'offset': 180},
    {'name': 'India (UTC+5:30)', 'offset': 330},
    {'name': 'Bangladesh (UTC+6:00)', 'offset': 360},
    {'name': 'Thailand (UTC+7:00)', 'offset': 420},
    {'name': 'China (UTC+8:00)', 'offset': 480},
    {'name': 'Japan (UTC+9:00)', 'offset': 540},
    {'name': 'Australia (UTC+10:00)', 'offset': 600},
    {'name': 'New Zealand (UTC+12:00)', 'offset': 720},
    {'name': 'Kiribati (UTC+14:00)', 'offset': 840},
  ];

  @override
  void initState() {
    super.initState();
    _currentOffset = widget.offset;
    _currentColor = widget.color;
    _selectedMode = widget.mode;

    bool validOffset = timeZones.any((tz) => tz['offset'] == _currentOffset);
    if (!validOffset) _currentOffset = 330;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Time Zone', style: TextStyle(color: Colors.white)),
              trailing: DropdownButton<int>(
                dropdownColor: Colors.black,
                value: _currentOffset,
                items: timeZones.map((tz) {
                  return DropdownMenuItem<int>(
                    value: tz['offset'],
                    child:
                        Text(tz['name'], style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentOffset = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Clock Mode', style: TextStyle(color: Colors.white)),
              trailing: DropdownButton<String>(
                dropdownColor: Colors.black,
                value: _selectedMode,
                items: modes.map((mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMode = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Clock Color', style: TextStyle(color: Colors.white)),
              subtitle: Row(
                children: [
                  _colorDot(Colors.red),
                  _colorDot(Color(0xFF001F3F)),
                  _colorDot(Color(0xFFFFD700)),
                  _colorDot(Color(0xFF8A2BE2)),
                  IconButton(
                    icon: Icon(Icons.color_lens, color: Colors.white),
                    onPressed: () => _showColorPickerDialog(context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _currentColor,
        child: Icon(Icons.save, color: Colors.black),
        onPressed: () => Navigator.pop(context, {
          'offset': _currentOffset,
          'color': _currentColor,
          'mode': _selectedMode,
        }),
      ),
    );
  }

  Widget _colorDot(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor = color;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _currentColor == color ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    Color previewColor = _currentColor;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Select or Enter Color',
              style: TextStyle(color: Colors.white)),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Color? picked = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.grey[900],
                          title: Text("Pick a Color",
                              style: TextStyle(color: Colors.white)),
                          content: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                Colors.red,
                                Colors.greenAccent,
                                Color(0xFF001F3F),
                                Color(0xFFFFD700),
                                Color(0xFF8A2BE2),
                                Color(0xFFFA8072),
                                Color(0xFF00FFFF),
                                Color(0xFFC0C0C0),
                                Colors.white,
                              ].map((color) {
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).pop(color),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: previewColor == color ? 2 : 0,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                      if (picked != null) {
                        setState(() {
                          previewColor = picked;
                        });
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: previewColor,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'e.g. #FF69B4 or 255,105,180',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (val) {
                      final input = val.trim();
                      Color? parsed;
                      if (input.startsWith('#')) {
                        try {
                          parsed = Color(
                              int.parse(input.substring(1), radix: 16) +
                                  0xFF000000);
                        } catch (_) {}
                      } else if (input.contains(',')) {
                        final parts = input
                            .split(',')
                            .map((e) => int.tryParse(e.trim()))
                            .toList();
                        if (parts.length == 3 &&
                            parts.every((e) => e != null)) {
                          parsed = Color.fromARGB(
                              255, parts[0]!, parts[1]!, parts[2]!);
                        }
                      }
                      if (parsed != null) {
                        setState(() {
                          previewColor = parsed!;
                        });
                      }
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text("Apply", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _currentColor = previewColor;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
