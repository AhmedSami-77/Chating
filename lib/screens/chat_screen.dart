import 'package:chat_application/constant/coloers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStor = FirebaseFirestore.instance;
  TextEditingController _textController = TextEditingController();
  late User _signedInUser;
  String? textMessage;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _signedInUser = user;
        print(_signedInUser);
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstanColoers.primary,
          title: Row(
            children: [
              Icon(Icons.chat_outlined),
              SizedBox(
                width: 10,
              ),
              Text('Chating'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // add here logout function
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _fireStor
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  List<CostumMessage> messageWidgets = [];
                  if (!dataSnapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final messages = dataSnapshot.data!.docs.reversed;
                  for (var message in messages) {
                    final messageText = message.get('text');
                    final messageEmail = message.get('email');
                    final currentUser = _signedInUser.email;
                    if (currentUser == messageEmail) {
                      final messageWidget = CostumMessage(
                          color: Colors.blue[900]!,
                          messageText: messageText,
                          messageEmail: messageEmail);
                      messageWidgets.add(messageWidget);
                    } else {
                      final messageWidget = CostumMessage(
                          color: Colors.green,
                          messageText: messageText,
                          messageEmail: messageEmail);
                      messageWidgets.add(messageWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: messageWidgets,
                    ),
                  );
                },
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: TextField(
                          onChanged: (value) {
                            textMessage = value;
                          },
                          controller: _textController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _fireStor.collection('messages').add({
                                    'text': _textController.text,
                                    'email': _signedInUser.email,
                                    'time': FieldValue.serverTimestamp()
                                  });
                                  _textController.clear();
                                },
                                icon: Icon(Icons.send_rounded)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ConstanColoers.primary300,
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_voice_rounded,
                              color: Colors.black,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CostumMessage extends StatelessWidget {
  const CostumMessage({
    Key? key,
    required this.messageText,
    required this.messageEmail,
    required this.color,
  }) : super(key: key);

  final String? messageText;
  final String? messageEmail;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: color != Colors.green
              ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageText!,
              style: TextStyle(color: Colors.white),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                messageEmail!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
