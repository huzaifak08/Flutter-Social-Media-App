import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    // Recieve data in map:

                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.secondaryTextColor,
                                  width: 5,
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),

                              // If profile pic is null then show this icon

                              child: map['profile'].toString() == ''
                                  ? const Icon(Icons.image)
                                  : Image(
                                      image: NetworkImage(
                                          map['profile'].toString()),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        // Must use this line:
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: AppColors.alertColor,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ReuseableRow(
                          title: 'Username',
                          value: map['userName'],
                          iconData: Icons.person,
                        ),
                        ReuseableRow(
                          title: 'Phone',
                          value:
                              map['phone'] == '' ? 'xxx-xxx-xxx' : map['phone'],
                          iconData: Icons.phone,
                        ),
                        ReuseableRow(
                          title: 'Email',
                          value: map['email'],
                          iconData: Icons.email,
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      'No Data',
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReuseableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          trailing: Text(value),
        ),
      ],
    );
  }
}
