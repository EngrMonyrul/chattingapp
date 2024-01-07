import 'package:chattingapp/services/auth/auth_services.dart';
import 'package:chattingapp/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPageView extends StatefulWidget {
  final String email;
  final String id;

  const ChatPageView({super.key, required this.email, required this.id});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  final TextEditingController _message = TextEditingController();
  final AuthServices _authServices = AuthServices();
  final ChatServices _chatServices = ChatServices();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  void sendMessage() async {
    if (_message.text.isNotEmpty) {
      await _chatServices.sendMessage(
          reciverId: widget.id, messageBody: _message.text);
    }

    _message.clear();
  }

  scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown);
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
    super.initState();
  }

  @override
  void dispose() {
    _message.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatServices.getMessages(receiverId: widget.id),
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
          children:
              snapshot.data!.docs.map((e) => _buildMessage(msg: e)).toList(),
        );
      },
    );
  }

  Widget _buildMessage({required DocumentSnapshot msg}) {
    Map<String, dynamic> data = msg.data() as Map<String, dynamic>;

    final isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser().uid;

    final alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Text(data['message']),
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _message,
            obscureText: false,
            decoration: const InputDecoration(
              hintText: 'Type your message',
            ),
            focusNode: focusNode,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: sendMessage,
        ),
      ],
    );
  }
}
