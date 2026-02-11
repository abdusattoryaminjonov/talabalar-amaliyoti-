import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constands/appcolors.dart';
import '../../pages/student_pages/chat_page/chat_page.dart';
import '../../pages/student_pages/chat_page/notifications_page.dart';

class ChatPageController extends GetxController{
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<ChatMessage> messages = [
    ChatMessage(text: 'Assalomu Aleyum! Yordam kerak.', isMe: true, time: DateTime.now().subtract(const Duration(minutes: 3))),
    ChatMessage(text: 'Qanday yordam bera olaman?', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 5))),
  ];

  goToChatPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatPage()),
    );
  }

  goToNotificationPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
  }

  @override
  void onClose() {
    controller.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Widget buildCustomButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 30,color: AppColors.appActiveBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 6),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.redAccent,
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.attach_file),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Xabar yozing...',
                border: InputBorder.none,
              ),
              onSubmitted: (_){sendMessage();}
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    final msg = ChatMessage(text: text, isMe: true, time: DateTime.now());
    messages.add(msg);
    update();

    controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget buildMessage(ChatMessage msg) {
    final alignment = msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = msg.isMe
        ? const BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
    )
        : const BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!msg.isMe) avatar(),
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: msg.isMe ? Colors.blueAccent.shade700 : Colors.grey.shade200,
                    borderRadius: radius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.text,
                        style: TextStyle(
                          color: msg.isMe ? Colors.white : Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatTime(msg.time),
                        style: TextStyle(
                          color: (msg.isMe ? Colors.white70 : Colors.black54),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (msg.isMe) const SizedBox(width: 8),
          if (msg.isMe) avatar(me: true),
        ],
      ),
    );
  }

  Widget avatar({bool me = false}) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: me ? Colors.blueAccent : Colors.grey.shade400,
      child: Text(
        me ? 'S' : 'H',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

}