part of chatbot;

class ChatBotPage extends StatefulWidget {
  static const String route = "/chatbot";

  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  ValueNotifier<bool> canSendNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        canSendNotifier.value = true;
      } else {
        canSendNotifier.value = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        focusedErrorBorder: AppStyle.outlineInputBorderDefault,
                        errorBorder: AppStyle.outlineInputBorderDefault,
                        enabledBorder: AppStyle.outlineInputBorderDefault,
                        focusedBorder: AppStyle.outlineInputBorderPrimary,
                        disabledBorder: AppStyle.outlineInputBorderDefault,
                        hintText: "Aa",
                        hintStyle: TextStyle(color: Colors.grey)),
                  )),
                  ValueListenableBuilder(
                    valueListenable: canSendNotifier,
                    builder:
                        (BuildContext context, bool canSend, Widget? child) {
                      return IconButton(
                          onPressed: canSend
                              ? () {
                                  sendMessage(_controller.text);
                                  _controller.clear();
                                }
                              : null,
                          icon: Icon(
                            Icons.send,
                            color: canSend
                                ? AppColor.primaryColor
                                : AppColor.nonactiveColor,
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
