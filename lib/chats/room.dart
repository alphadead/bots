import 'package:ar_core_intro/operation/handle._inp.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Divyam", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Adarsh, I am doing fine dude. wbu?",
        messageType: "sender"),
  ];
  sendMsg(String val) {
    setState(() {
      messages.add(ChatMessage(messageContent: val, messageType: 'sender'));
    });
    print(messages.length);
  }

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String search = '';
    final _formKey = GlobalKey<FormState>();
    final Handle find = new Handle();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Adarsh",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: messages.length,
            padding: EdgeInsets.only(top: 10, bottom: 80),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextField(
                        autofocus: true,
                        controller: textEditingController,
                        // onChanged: (value) {
                        //   setState(() {
                        //     search = textEditingController.text;
                        //   });
                        // },
                        onSubmitted: (String val) {
                          setState(() {
                            search = textEditingController.text;
                            textEditingController.clear();
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (textEditingController.text.contains('/movies')) {
                        String search = textEditingController.text.substring(8);
                        var mess = find.movieList(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text
                          .contains('/github')) {
                        String search = textEditingController.text.substring(8);
                        var mess = find.github(search);

                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text
                          .contains('/meaning')) {
                        String search = textEditingController.text.substring(9);
                        var mess = find.getMeaning(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else if (textEditingController.text.contains("+") ||
                          textEditingController.text.contains("-") ||
                          textEditingController.text.contains("*") ||
                          textEditingController.text.contains("/") ||
                          textEditingController.text.contains("^")) {
                        var cal = find.calculate(textEditingController.text);
                        setState(() {
                          messages.add(ChatMessage(
                              messageContent:
                                  textEditingController.text + ' = $cal',
                              messageType: 'sender'));
                        });
                      } else if (textEditingController.text
                          .contains('/recommend')) {
                        String search =
                            textEditingController.text.substring(11);
                        var mess = find.recommendMovie(search);
                        setState(() {
                          mess.then((value) => {
                                messages.add(ChatMessage(
                                    messageContent: value.toString(),
                                    messageType: 'sender')),
                                print(value)
                              });
                        });
                      } else
                        sendMsg(textEditingController.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
