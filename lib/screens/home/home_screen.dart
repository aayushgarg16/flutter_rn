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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0, // Left padding
              top: 24.0,
              bottom: 16.0,
            ),
            child: const Text(
              'I am Flutter. This whole page including dashboard is built using Flutter.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const KYCScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48), // Full width
              ),
              child: const Text('Open React Native KYC Page'),
            ),
          ),
          const SizedBox(height: 16), // Additional spacing
        ],
      ),
    );
  }
}