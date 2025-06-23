import 'package:flutter/material.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3), // Warm cream background
      appBar: AppBar(
        title: const Text(
          'AI Prescriptions',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C2C2C),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF2C2C2C),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Prescription
            _buildCurrentPrescription(),
            const SizedBox(height: 24),

            // Today's Schedule
            _buildTodaySchedule(),
            const SizedBox(height: 24),

            // Upcoming Reminders
            _buildUpcomingReminders(),
            const SizedBox(height: 24),

            // Recent Prescriptions
            _buildRecentPrescriptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPrescription() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF50C878)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pets, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Luna (Golden Retriever, 2 yrs)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Row(
            children: [
              Icon(Icons.medical_services, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'Diagnosis: Parvovirus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          const Text(
            'Current Treatment Plan',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),

          _buildPrescriptionItem(
            icon: Icons.medication,
            text: 'Amoxicillin – 5ml – 2 times a day',
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
          _buildPrescriptionItem(
            icon: Icons.restaurant,
            text: 'Boiled rice & chicken, avoid milk',
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
          _buildPrescriptionItem(
            icon: Icons.vaccines,
            text: 'Anti-viral injection on 25 June',
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
          _buildPrescriptionItem(
            icon: Icons.calendar_today,
            text: 'Next checkup: 30 June 2025',
            iconColor: Colors.white,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionItem({
    required IconData icon,
    required String text,
    required Color iconColor,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Schedule',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        _buildScheduleCard(
          time: '08:00 AM',
          title: 'Morning Medicine',
          subtitle: 'Amoxicillin - 5ml for Luna',
          icon: Icons.medication,
          color: const Color(0xFF4A90E2),
          isCompleted: true,
        ),
        const SizedBox(height: 12),

        _buildScheduleCard(
          time: '02:00 PM',
          title: 'Afternoon Medicine',
          subtitle: 'Amoxicillin - 5ml for Luna',
          icon: Icons.medication,
          color: const Color(0xFFFF6B6B),
          isCompleted: false,
          isNext: true,
        ),
        const SizedBox(height: 12),

        _buildScheduleCard(
          time: '06:00 PM',
          title: 'Evening Feeding',
          subtitle: 'Boiled rice & chicken for Luna',
          icon: Icons.restaurant,
          color: const Color(0xFF50C878),
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildScheduleCard({
    required String time,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isCompleted,
    bool isNext = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isNext ? Border.all(color: color, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted ? color : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted ? Colors.white : color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Colors.grey : null,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isNext ? color : Colors.grey[600],
                ),
              ),
              if (isNext)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingReminders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Reminders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        _buildReminderCard(
          date: 'Tomorrow',
          title: 'Anti-viral Injection',
          subtitle: 'Luna - Scheduled at 10:00 AM',
          icon: Icons.vaccines,
          color: const Color(0xFF4ECDC4),
        ),
        const SizedBox(height: 12),

        _buildReminderCard(
          date: '30 Jun',
          title: 'Vet Checkup',
          subtitle: 'Luna - Follow-up appointment',
          icon: Icons.local_hospital,
          color: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 12),

        _buildReminderCard(
          date: '02 Jul',
          title: 'Rabies Vaccination',
          subtitle: 'Max - Annual vaccine',
          icon: Icons.vaccines,
          color: const Color(0xFF4A90E2),
        ),
      ],
    );
  }

  Widget _buildReminderCard({
    required String date,
    required String title,
    required String subtitle,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              date,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPrescriptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent Prescriptions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 16),

        _buildPrescriptionHistoryCard(
          petName: 'Max',
          diagnosis: 'Upper Respiratory Infection',
          date: '15 June 2025',
          status: 'Completed',
          statusColor: const Color(0xFF50C878),
          onTap: () => _showPrescriptionDetails('Max - URI Treatment'),
        ),
        const SizedBox(height: 12),

        _buildPrescriptionHistoryCard(
          petName: 'Luna',
          diagnosis: 'Routine Checkup',
          date: '10 June 2025',
          status: 'Completed',
          statusColor: const Color(0xFF50C878),
          onTap: () => _showPrescriptionDetails('Luna - Routine Care'),
        ),
      ],
    );
  }

  Widget _buildPrescriptionHistoryCard({
    required String petName,
    required String diagnosis,
    required String date,
    required String status,
    required Color statusColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.pets, color: statusColor, size: 20),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$petName - $diagnosis',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _showPrescriptionDetails(String prescriptionTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => PrescriptionDetailsBottomSheet(
            prescriptionTitle: prescriptionTitle,
          ),
    );
  }
}

class PrescriptionDetailsBottomSheet extends StatelessWidget {
  final String prescriptionTitle;

  const PrescriptionDetailsBottomSheet({
    super.key,
    required this.prescriptionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    prescriptionTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Prescription Summary
                  _buildSection(
                    title: '🩺 Diagnosis',
                    content:
                        'Parvovirus infection with gastrointestinal symptoms',
                  ),

                  _buildSection(
                    title: '💊 Medications',
                    content: '''• Amoxicillin 5ml - Twice daily (8 AM, 8 PM)
• Probiotics 2ml - Once daily (12 PM)
• Anti-nausea drops 1ml - As needed''',
                  ),

                  _buildSection(
                    title: '🍲 Dietary Instructions',
                    content: '''• Boiled rice and chicken (small portions)
• Avoid milk, dairy products, and oily foods
• Fresh water always available
• Feed 4-5 small meals throughout the day''',
                  ),

                  _buildSection(
                    title: '💉 Injections & Vaccines',
                    content:
                        '''• Anti-viral injection - 25 June 2025 at 10:00 AM
• Follow-up blood work - 28 June 2025
• Next vaccination due - 15 August 2025''',
                  ),

                  _buildSection(
                    title: '🗓️ Follow-up Schedule',
                    content: '''• Next checkup: 30 June 2025 at 2:00 PM
• Weight monitoring: Weekly
• Symptom monitoring: Daily for 7 days''',
                  ),

                  _buildSection(
                    title: '⚠️ Warning Signs',
                    content: '''Contact vet immediately if:
• Vomiting persists for more than 24 hours
• No improvement in appetite after 48 hours
• Lethargy or weakness increases
• Any new concerning symptoms''',
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                          label: const Text('Share with Vet'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                          label: const Text('Export PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
