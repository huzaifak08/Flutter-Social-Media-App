import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/message_screen.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
          elevation: 0,
        ),
        body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            // Not to show your own account use this condition:
            if (SessionController().userId.toString() ==
                snapshot.child('uid').value.toString()) {
              return Container();
            } else {
              return Card(
                child: ListTile(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: MessageScreen(
                              image: snapshot.child('profile').value.toString(),
                              email: snapshot.child('email').value.toString(),
                              name: snapshot.child('userName').value.toString(),
                              recieverId:
                                  snapshot.child('uid').value.toString()),
                          withNavBar: false);
                    },
                    title: Text(snapshot.child('userName').value.toString()),
                    subtitle: Text(snapshot.child('email').value.toString()),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: snapshot.child('profile').value.toString() == ''
                          ? const Icon(Icons.image)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image(
                                image: NetworkImage(
                                    snapshot.child('profile').value.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                    )),
              );
            }
          },
        ),
      ),
    );
  }
}
