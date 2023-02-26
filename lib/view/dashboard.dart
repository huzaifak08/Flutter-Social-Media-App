import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/Provider/login_providers.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: Consumer<LoginProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.logOut(context);
                  },
                  icon: const Icon(Icons.exit_to_app),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
