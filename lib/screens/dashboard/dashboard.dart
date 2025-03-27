import 'package:flutter/material.dart';
import 'package:flutter_rn_app/screens/home/home_screen.dart';
import 'package:lottie/lottie.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<AnimationController> _animationControllers;

  final List<Widget> _pages = [
    const HomeScreen(),
    const DashboardHomePage(),
    const Placeholder(fallbackHeight: 200),
    const Placeholder(fallbackHeight: 200),
  ];

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(
      4,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 1.0,
        upperBound: 1.2,
      ),
    );
    _animationControllers[_selectedIndex].forward();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    _animationControllers[_selectedIndex].reverse();
    _animationControllers[index].forward();

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 6,
        child: Lottie.asset(
          'assets/lottie/discover.json',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
              _buildNavItem(icon: Icons.pie_chart, label: 'Portfolio', index: 1),
              const SizedBox(width: 48), // space for FAB
              _buildNavItem(icon: Icons.show_chart, label: 'Market', index: 2),
              _buildNavItem(icon: Icons.card_giftcard, label: 'Refer', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8), // reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animationControllers[index],
                child: Icon(icon, color: isSelected ? Colors.green : Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 16),
            const IndexSection(),
            const SizedBox(height: 16),
            const HoldingsCard(),
            const SizedBox(height: 24),
            const MenuSection(),
            const SizedBox(height: 24),
            const WatchlistSection(),
            const SizedBox(height: 24),
            const AnalystPickSection(),
            const SizedBox(height: 24),
            const HighlightsSection(),
            const SizedBox(height: 24),
            const PlayToLearnCard(),
            const SizedBox(height: 24),
            const ReferCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search for 'Stocks'",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}

class IndexSection extends StatelessWidget {
  const IndexSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        IndexCard(title: "NIFTY 50", value: "23,539.05", change: "+43.85 (0.19%)"),
        IndexCard(title: "BANKNIFTY", value: "51,663.15", change: "+252.89 (0.05%)"),
      ],
    );
  }
}

class IndexCard extends StatelessWidget {
  final String title, value, change;
  const IndexCard({super.key, required this.title, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(change, style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}

class HoldingsCard extends StatelessWidget {
  const HoldingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Current Holdings", style: TextStyle(fontSize: 12, color: Colors.black54)),
          SizedBox(height: 4),
          Text("₹15,000.25", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text("+16.43%  ₹99.86", style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 80);
}

class WatchlistSection extends StatelessWidget {
  const WatchlistSection({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 100);
}

class AnalystPickSection extends StatelessWidget {
  const AnalystPickSection({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 100);
}

class HighlightsSection extends StatelessWidget {
  const HighlightsSection({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 100);
}

class PlayToLearnCard extends StatelessWidget {
  const PlayToLearnCard({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 150);
}

class ReferCard extends StatelessWidget {
  const ReferCard({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder(fallbackHeight: 100);
}
