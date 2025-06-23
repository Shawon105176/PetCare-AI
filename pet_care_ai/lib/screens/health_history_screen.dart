import 'package:flutter/material.dart';

class HealthHistoryScreen extends StatefulWidget {
  const HealthHistoryScreen({super.key});

  @override
  State<HealthHistoryScreen> createState() => _HealthHistoryScreenState();
}

class _HealthHistoryScreenState extends State<HealthHistoryScreen> {
  String _selectedPet = 'Luna';
  String _selectedView = 'Timeline';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3), // Warm cream background
      appBar: AppBar(
        title: const Text(
          'Health History',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C2C2C),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF2C2C2C),
        actions: [
          IconButton(
            onPressed: () => _showFilterOptions(),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Pet Selector and View Toggle
          _buildControls(),

          // Content based on selected view
          Expanded(
            child:
                _selectedView == 'Timeline'
                    ? _buildTimelineView()
                    : _buildStatsView(),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Pet Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPet,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPet = newValue!;
                  });
                },
                items:
                    <String>[
                      'Luna',
                      'Max',
                      'Buddy',
                      'Charlie',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.pets,
                              size: 20,
                              color: Color(0xFF4A90E2),
                            ),
                            const SizedBox(width: 8),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // View Toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedView = 'Timeline'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _selectedView == 'Timeline'
                                ? const Color(0xFF4A90E2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Timeline',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _selectedView == 'Timeline'
                                  ? Colors.white
                                  : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedView = 'Stats'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _selectedView == 'Stats'
                                ? const Color(0xFF4A90E2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Health Stats',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _selectedView == 'Stats'
                                  ? Colors.white
                                  : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildTimelineItem(
          date: '20 June 2025',
          title: 'Blood Test Results',
          subtitle: 'Complete blood count analysis',
          type: 'Report',
          icon: Icons.bloodtype,
          color: const Color(0xFF4A90E2),
          details:
              'All values within normal range. Minor dehydration detected.',
        ),

        _buildTimelineItem(
          date: '18 June 2025',
          title: 'Parvovirus Treatment Started',
          subtitle: 'AI-generated prescription',
          type: 'Treatment',
          icon: Icons.medication,
          color: const Color(0xFFFF6B6B),
          details: 'Amoxicillin 5ml twice daily, dietary changes implemented.',
        ),

        _buildTimelineItem(
          date: '15 June 2025',
          title: 'Emergency Vet Visit',
          subtitle: 'Symptoms: Vomiting, diarrhea',
          type: 'Visit',
          icon: Icons.local_hospital,
          color: const Color(0xFFFF9800),
          details:
              'Diagnosed with parvovirus infection. Treatment plan created.',
        ),

        _buildTimelineItem(
          date: '10 June 2025',
          title: 'Routine Checkup',
          subtitle: 'Annual health examination',
          type: 'Visit',
          icon: Icons.health_and_safety,
          color: const Color(0xFF50C878),
          details: 'Overall health good. Weight: 25kg. Vaccines up to date.',
        ),

        _buildTimelineItem(
          date: '05 June 2025',
          title: 'Rabies Vaccination',
          subtitle: 'Annual vaccine dose',
          type: 'Vaccine',
          icon: Icons.vaccines,
          color: const Color(0xFF4ECDC4),
          details: 'Rabies vaccine administered. Next due: June 2026.',
        ),

        _buildTimelineItem(
          date: '01 June 2025',
          title: 'Weight Monitoring',
          subtitle: 'Monthly weight check',
          type: 'Monitoring',
          icon: Icons.monitor_weight,
          color: const Color(0xFF9C27B0),
          details:
              'Weight: 25kg (+0.5kg from last month). Within healthy range.',
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String title,
    required String subtitle,
    required String type,
    required IconData icon,
    required Color color,
    required String details,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              Container(width: 2, height: 40, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: GestureDetector(
              onTap: () => _showHistoryDetails(title, details, date, type),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            type,
                            style: TextStyle(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      details,
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Health Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Current Weight',
                  value: '25 kg',
                  trend: '+0.5kg',
                  trendUp: true,
                  icon: Icons.monitor_weight,
                  color: const Color(0xFF4A90E2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Health Score',
                  value: '85/100',
                  trend: '+5',
                  trendUp: true,
                  icon: Icons.favorite,
                  color: const Color(0xFF50C878),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Vet Visits',
                  value: '3',
                  trend: 'This year',
                  trendUp: null,
                  icon: Icons.local_hospital,
                  color: const Color(0xFFFF9800),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Vaccines',
                  value: 'Up to date',
                  trend: 'Next: Aug 2025',
                  trendUp: null,
                  icon: Icons.vaccines,
                  color: const Color(0xFF4ECDC4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Weight Chart
          _buildWeightChart(),
          const SizedBox(height: 24),

          // Health Trends
          _buildHealthTrends(),
          const SizedBox(height: 24),

          // Upcoming Events
          _buildUpcomingEvents(),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String trend,
    required bool? trendUp,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              if (trendUp != null)
                Icon(
                  trendUp ? Icons.trending_up : Icons.trending_down,
                  color: trendUp ? Colors.green : Colors.red,
                  size: 16,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            trend,
            style: TextStyle(
              color:
                  trendUp == null
                      ? Colors.grey[600]
                      : (trendUp ? Colors.green : Colors.red),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weight Trend (Last 6 Months)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Simple chart representation
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Weight trend chart'),
                  Text(
                    '24.5kg → 25kg (Healthy increase)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTrends() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Health Trends',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildTrendItem(
            title: 'Appetite',
            status: 'Excellent',
            color: const Color(0xFF50C878),
            trend: 'Improved',
          ),
          _buildTrendItem(
            title: 'Energy Level',
            status: 'High',
            color: const Color(0xFF4A90E2),
            trend: 'Stable',
          ),
          _buildTrendItem(
            title: 'Coat Condition',
            status: 'Good',
            color: const Color(0xFF50C878),
            trend: 'Improving',
          ),
          _buildTrendItem(
            title: 'Digestive Health',
            status: 'Recovering',
            color: const Color(0xFFFF9800),
            trend: 'Improving',
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem({
    required String title,
    required String status,
    required Color color,
    required String trend,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(trend, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Health Events',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildEventItem(
            date: '25 Jun',
            title: 'Anti-viral Injection',
            icon: Icons.vaccines,
            color: const Color(0xFF4ECDC4),
          ),
          _buildEventItem(
            date: '30 Jun',
            title: 'Follow-up Checkup',
            icon: Icons.local_hospital,
            color: const Color(0xFFFF9800),
          ),
          _buildEventItem(
            date: '15 Aug',
            title: 'Annual Vaccination',
            icon: Icons.vaccines,
            color: const Color(0xFF4A90E2),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem({
    required String date,
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date Range'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Event Type'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.sort),
                  title: const Text('Sort Order'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
    );
  }

  void _showHistoryDetails(
    String title,
    String details,
    String date,
    String type,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: $date'),
              Text('Type: $type'),
              const SizedBox(height: 12),
              Text(details),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
              ),
              child: const Text('View Details'),
            ),
          ],
        );
      },
    );
  }
}
