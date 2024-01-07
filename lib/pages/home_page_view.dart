// ignore_for_file: use_build_context_synchronously

import 'package:chattingapp/components/homepage_drawer.dart';
import 'package:chattingapp/components/usertile_widget.dart';
import 'package:chattingapp/pages/chat_page_view.dart';
import 'package:chattingapp/services/auth/auth_services.dart';
import 'package:chattingapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final AuthServices authServices = AuthServices();
  final ChatServices chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomePageDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatServices.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((e) => _buildUserListItem(userData: e))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem({required Map<String, dynamic> userData}) {
    if (userData['email'] != authServices.getCurrentUser()) {
      return UserTileDetails(
        text: userData['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPageView(
                      email: userData['email'], id: userData['uid'])));
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
