import 'package:chattingapp/themes/dark_mode.dart';
import 'package:chattingapp/themes/theme_mode_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPageView extends StatelessWidget {
  const SettingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Consumer<ThemeModeProvider>(builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                CupertinoSwitch(
                  value: value.themeData == darkMode,
                  onChanged: (_) {
                    value.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
