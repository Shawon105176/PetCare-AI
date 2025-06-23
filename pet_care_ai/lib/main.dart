import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pet_profile_screen.dart';
import 'screens/medical_report_screen.dart';
import 'screens/prescription_screen.dart';
import 'screens/health_history_screen.dart';

void main() {
  runApp(const PetCareApp());
}

class PetCareApp extends StatelessWidget {
  const PetCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE4A574), // Warm peach color like the image
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(
          0xFFF5E6D3,
        ), // Warm cream background
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PetProfileScreen(),
    const MedicalReportScreen(),
    const PrescriptionScreen(),
    const HealthHistoryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            indicatorColor: const Color(0xFFE4A574),
            surfaceTintColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.white70),
                selectedIcon: Icon(Icons.home, color: Colors.white),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.pets_outlined, color: Colors.white70),
                selectedIcon: Icon(Icons.pets, color: Colors.white),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.upload_file_outlined, color: Colors.white70),
                selectedIcon: Icon(Icons.upload_file, color: Colors.white),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.medication_outlined, color: Colors.white70),
                selectedIcon: Icon(Icons.medication, color: Colors.white),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined, color: Colors.white70),
                selectedIcon: Icon(Icons.history, color: Colors.white),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
