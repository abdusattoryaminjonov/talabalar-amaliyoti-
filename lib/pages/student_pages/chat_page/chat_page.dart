import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constands/appcolors.dart';
import '../../../controllers/student_controllers/chat_page_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatPageController = Get.find<ChatPageController>();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatPageController>(
      builder: (_){
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.appActiveBlue,
            title: Text('Chat',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back_outlined,color: AppColors.white,),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatPageController.scrollController,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    itemCount: chatPageController.messages.length,
                    itemBuilder: (context, index) {
                      final msg = chatPageController.messages[index];
                      return chatPageController.buildMessage(msg);
                    },
                  ),
                ),
                const Divider(height: 1),
                chatPageController.buildInput(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}
