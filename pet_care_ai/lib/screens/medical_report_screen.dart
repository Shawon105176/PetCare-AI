import 'package:flutter/material.dart';

class MedicalReportScreen extends StatefulWidget {
  const MedicalReportScreen({super.key});

  @override
  State<MedicalReportScreen> createState() => _MedicalReportScreenState();
}

class _MedicalReportScreenState extends State<MedicalReportScreen> {
  String _selectedPet = 'Luna';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3), // Warm cream background
      appBar: AppBar(
        title: const Text(
          'Medical Reports',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C2C2C),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF2C2C2C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Section
            _buildUploadSection(),
            const SizedBox(height: 24),

            // Recent Reports
            _buildRecentReports(),
            const SizedBox(height: 24),

            // Processing Status
            _buildProcessingStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Upload Medical Report',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Pet Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
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
          const SizedBox(height: 20),

          // Upload Options
          Row(
            children: [
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.camera_alt,
                  title: 'Take Photo',
                  subtitle: 'Camera',
                  color: const Color(0xFF4A90E2),
                  onTap: () => _showUploadDialog('camera'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.photo_library,
                  title: 'From Gallery',
                  subtitle: 'Photos',
                  color: const Color(0xFF50C878),
                  onTap: () => _showUploadDialog('gallery'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.picture_as_pdf,
                  title: 'PDF Document',
                  subtitle: 'Files',
                  color: const Color(0xFFFF6B6B),
                  onTap: () => _showUploadDialog('pdf'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.scanner,
                  title: 'Scan Document',
                  subtitle: 'Scanner',
                  color: const Color(0xFF4ECDC4),
                  onTap: () => _showUploadDialog('scan'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent Reports',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 16),

        _buildReportCard(
          petName: 'Luna',
          reportType: 'Blood Test',
          date: '20 June 2025',
          status: 'Processed',
          statusColor: const Color(0xFF50C878),
          icon: Icons.bloodtype,
          onTap: () => _showReportDetails('Luna - Blood Test'),
        ),
        const SizedBox(height: 12),

        _buildReportCard(
          petName: 'Max',
          reportType: 'X-Ray',
          date: '18 June 2025',
          status: 'Processing',
          statusColor: const Color(0xFFFF9800),
          icon: Icons.medical_services,
          onTap: () => _showReportDetails('Max - X-Ray'),
        ),
        const SizedBox(height: 12),

        _buildReportCard(
          petName: 'Luna',
          reportType: 'Vaccination Record',
          date: '15 June 2025',
          status: 'Processed',
          statusColor: const Color(0xFF50C878),
          icon: Icons.vaccines,
          onTap: () => _showReportDetails('Luna - Vaccination'),
        ),
      ],
    );
  }

  Widget _buildReportCard({
    required String petName,
    required String reportType,
    required String date,
    required String status,
    required Color statusColor,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: statusColor, size: 24),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$petName - $reportType',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'AI Processing Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildProcessingItem(
            title: 'Max - X-Ray Report',
            subtitle: 'Extracting text from image...',
            progress: 0.7,
            icon: Icons.auto_awesome,
          ),
          const SizedBox(height: 16),

          _buildProcessingItem(
            title: 'Buddy - Lab Results',
            subtitle: 'Analyzing medical data...',
            progress: 0.4,
            icon: Icons.analytics,
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingItem({
    required String title,
    required String subtitle,
    required double progress,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF4A90E2), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
        ),
      ],
    );
  }

  void _showUploadDialog(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload from ${type.toUpperCase()}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getIconForType(type),
                size: 48,
                color: const Color(0xFF4A90E2),
              ),
              const SizedBox(height: 16),
              Text(
                'This will upload a medical report for $_selectedPet from $type.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _simulateUpload(type);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'camera':
        return Icons.camera_alt;
      case 'gallery':
        return Icons.photo_library;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'scan':
        return Icons.scanner;
      default:
        return Icons.upload_file;
    }
  }

  void _simulateUpload(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Uploading medical report for $_selectedPet from $type...',
        ),
        action: SnackBarAction(label: 'View Progress', onPressed: () {}),
      ),
    );
  }

  void _showReportDetails(String reportTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReportDetailsBottomSheet(reportTitle: reportTitle),
    );
  }
}

class ReportDetailsBottomSheet extends StatelessWidget {
  final String reportTitle;

  const ReportDetailsBottomSheet({super.key, required this.reportTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
                    reportTitle,
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
                  // Report Image/Preview
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.description, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Report Preview'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Extracted Data
                  const Text(
                    'Extracted Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard('Diagnosis', 'Mild gastroenteritis'),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    'Symptoms',
                    'Vomiting, diarrhea, loss of appetite',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    'Recommended Treatment',
                    'Antibiotics and dietary changes',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard('Next Checkup', '30 June 2025'),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.medication),
                          label: const Text('Generate Prescription'),
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

  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
