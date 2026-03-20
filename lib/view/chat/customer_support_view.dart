import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/customer_support_controller.dart';

class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '24/7 Customer Support',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.isLoading.value && controller.messages.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true, // Bottom to top scroll behavior
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return _buildMessageItem(
                        text: msg['text'] ?? '',
                        isMe: msg['isMe'] ?? false,
                        sender: msg['sender'] ?? '',
                      );
                    },
                  ),
          ),
          _buildBottomInput(controller),
        ],
      ),
    );
      },
    );
  }

  Widget _buildMessageItem({
    required String text,
    required bool isMe,
    required String sender,
  }) {
    final avatar = isMe
        ? Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("lib/assets/images/chatbot2.png"),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.shade800, width: 1.5),
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('lib/assets/images/chatbot.png'),
            ),
          );

    final bubbleBg = isMe ? const Color(0xFFF9E4E4) : Colors.white;
    final bubbleRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 40), child: avatar),
                const SizedBox(height: 4),
                Text(
                  sender,
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleBg,
                borderRadius: bubbleRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 12),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 16), child: avatar),
                const SizedBox(height: 4),
                Text(
                  sender,
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomInput(ChatController controller) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 0.8),
              ),
              child: TextField(
                controller: controller.messageController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: Icon(
                    Icons.image_outlined,
                    color: Colors.grey[500],
                    size: 22,
                  ),
                ),
                onSubmitted: (_) => controller.sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 44,
            width: 80,
            child: ElevatedButton(
              onPressed: () => controller.sendMessage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
