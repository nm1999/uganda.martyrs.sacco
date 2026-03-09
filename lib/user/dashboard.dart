import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  // Mock data - Replace with real data from your backend
  final double totalSavings = 450000;
  final List<SavingsRecord> savingsRecords = [
    SavingsRecord(
      date: DateTime(2024, 3, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2024, 2, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2024, 1, 15),
      amount: 25000,
      type: 'Extra Contribution',
      description: 'Additional savings deposit',
    ),
    SavingsRecord(
      date: DateTime(2024, 1, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2023, 12, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2023, 11, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2023, 10, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
    SavingsRecord(
      date: DateTime(2023, 9, 1),
      amount: 50000,
      type: 'Monthly Contribution',
      description: 'Regular monthly savings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        elevation: 0,
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            _buildWelcomeSection(),
            const SizedBox(height: 24),

            // Total Savings Card - Prominent at the top
            _buildTotalSavingsCard(),
            const SizedBox(height: 24),

            // Savings Records Section
            Text(
              'Savings Records',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Savings records list
            _buildSavingsRecordsList(),
            const SizedBox(height: 24),

            // Quick actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            _buildQuickActionButton(
              label: 'Make a Deposit',
              icon: Icons.add_circle_outline,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Make a Deposit')),
                );
              },
            ),
            const SizedBox(height: 12),

            _buildQuickActionButton(
              label: 'Request Loan',
              icon: Icons.request_page,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request Loan')),
                );
              },
            ),
            const SizedBox(height: 12),

            _buildQuickActionButton(
              label: 'View Statements',
              icon: Icons.receipt_long,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View Statements')),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700]!, Colors.green[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your savings and manage your account',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSavingsCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[600]!, Colors.green[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Total Savings',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'UGX ${_formatCurrency(totalSavings)}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep saving to reach your goals!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsRecordsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: savingsRecords.length,
        itemBuilder: (context, index) {
          final record = savingsRecords[index];
          return _buildSavingsRecordItem(record);
        },
      ),
    );
  }

  Widget _buildSavingsRecordItem(SavingsRecord record) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.savings,
              color: Colors.green,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.type,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  record.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${record.date.day}/${record.date.month}/${record.date.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          ),
          Text(
            '+UGX ${_formatCurrency(record.amount)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    // Format large numbers with thousands separator
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        );
  }
}

class SavingsRecord {
  final DateTime date;
  final double amount;
  final String type;
  final String description;

  SavingsRecord({
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
  });
}
