import 'package:flutter/material.dart';
import 'package:flutter_rn_app/screens/kyc/kyc_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String layoutType = 'grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://files.coinswitch.co/genesis-static-assets/assets/lemonn.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              width: 36, // or any size you want
              height: 36,
              child: Image.network(
                'https://files.coinswitch.co/genesis-static-assets/assets/header_search.png',
                fit: BoxFit.contain,
              ),
            ),
            onPressed: () {
              // Handle search tap
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                // Handle profile tap
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const KYCScreen()),
          );
        },
        child: const Text('Open React Native Page'),
      ),
    );
  }
}