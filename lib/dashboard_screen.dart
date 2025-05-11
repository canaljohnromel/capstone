import 'package:capstone/menu.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarMenu(), // Sidebar Integration
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pages / Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTopCards(),
                  const SizedBox(height: 16),
                  _buildMiddleAndBottomContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCards() {
    final cardData = [
      {'title': 'Total Rent Collected', 'value': '12,045'},
      {'title': 'Total Rent Remaining', 'value': '12,045'},
      {'title': 'Total Paid Tenants', 'value': '5'},
      {'title': 'Total Pending Tenants', 'value': '6'},
      {'title': 'Tenants', 'value': '16'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cardData.map((data) {
        return _InfoCard(title: data['title']!, value: data['value']!);
      }).toList(),
    );
  }

  Widget _buildMiddleAndBottomContent() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 2, child: _AnnouncementsSection()),
              const SizedBox(width: 16),
              Expanded(child: _PlaceholderCard(title: "Pie Chart")),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _PlaceholderCard(title: "Line Chart")),
              const SizedBox(width: 16),
              Expanded(child: _PlaceholderCard(title: "Bar Chart")),
              const SizedBox(width: 16),
              Expanded(child: _TenantsListCard()),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(height: 200, child: _ReportsSection()),
      ],
    );
  }
}

// Reusable components below

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.orange, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final String title;

  const _PlaceholderCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(title, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

class _AnnouncementsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlaceholderCard(title: "Announcements");
  }
}

class _TenantsListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlaceholderCard(title: "Tenants");
  }
}

class _ReportsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _PlaceholderCard(title: "Tenants Reports");
  }
}
