import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class MessageScreen extends StatefulWidget {
  final String image, name, email, recieverId;
  const MessageScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.recieverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('chat');
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text(index.toString());
                },
              )),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: messageController,
                      cursorColor: AppColors.primaryTextTextColor,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 19),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.textFieldDefaultFocus,
                                width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.alertColor, width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.textFieldDefaultBorderColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: 'Type Here...',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.8),
                                  height: 0),
                          contentPadding: const EdgeInsets.all(15),
                          suffixIcon: InkWell(
                            onTap: () {
                              sendMessage();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(Icons.send),
                              ),
                            ),
                          )),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'message': messageController.text.toString(),
        'isSeen': false,
        'sender': SessionController().userId.toString(),
        'reciever': widget.recieverId,
        'type': 'text',
        'time': timeStamp,
      }).then((value) {
        messageController.clear();
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    }
  }
}
