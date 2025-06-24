import 'package:flutter/material.dart';
import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _cardController;
  late AnimationController _petChangeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _petChangeAnimation;
  bool _animationsInitialized = false;

  void _setupPetChangeAnimation() {
    _petChangeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _petChangeController, curve: Curves.easeInOut),
    );
  }

  String selectedCategory = 'Dog';
  int currentPetIndex = 0;
  PageController _pageController = PageController();

  // Pet data organized by category
  final Map<String, List<Map<String, dynamic>>> petsByCategory = {
    'Dog': [
      {
        'imageAsset': 'assets/image/pets.jpg',
      },
      {
        'imageAsset': 'assets/image/pets1.png',
      },
      {
        'imageAsset': 'assets/image/pets2.jpg',
      },
    ],
    'Cat': [
      {
        'imageAsset': 'assets/image/pets3.jpg',
      },
      {
        'imageAsset': 'assets/image/pets4.jpg',
      },
      {
        'imageAsset': 'assets/image/pets5.jpg',
      },
    ],
    'Bird': [
      {
        'imageAsset': 'assets/image/pets6.jpg',
      },
      {
        'imageAsset': 'assets/image/pets7.jpg',
      },
    ],
    'Fish': [
      {
        'imageAsset': 'assets/image/pets8.jpg',
      },
      {
        'imageAsset': 'assets/image/pets9.jpg',
      },
    ],
  };
  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _petChangeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _setupPetChangeAnimation();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _startAnimations();
    _animationsInitialized = true;
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _cardController.forward();
    _petChangeController.forward();
  }

  void _selectCategory(String category) {
    if (category != selectedCategory) {
      setState(() {
        selectedCategory = category;
        currentPetIndex = 0;
      });
      _petChangeController.reset();
      _petChangeController.forward();
    }
  }

  List<Map<String, dynamic>> get currentPets =>
      petsByCategory[selectedCategory] ?? [];

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _cardController.dispose();
    _petChangeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_animationsInitialized) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6D3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top Section with Menu and Search
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu,
                        color: Color(0xFF2C2C2C),
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Color(0xFF2C2C2C),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Title Section
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Discover',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C2C2C),
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI-powered pet care for you',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF2C2C2C).withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32), // Category Pills
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      _buildCategoryPill('Dog', selectedCategory == 'Dog'),
                      const SizedBox(width: 12),
                      _buildCategoryPill('Cat', selectedCategory == 'Cat'),
                      const SizedBox(width: 12),
                      _buildCategoryPill('Bird', selectedCategory == 'Bird'),
                      const SizedBox(width: 12),
                      _buildCategoryPill('Fish', selectedCategory == 'Fish'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Main Pet Card Stack
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: AnimatedBuilder(
                      animation: _petChangeAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 0.9 + (_petChangeAnimation.value * 0.1),
                          child: _buildPetCardStack(),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Get Started Button
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const MainNavigationScreen(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 600,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pets, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryPill(String title, bool isSelected) {
    return GestureDetector(
      onTap: () => _selectCategory(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black87 : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildPetCardStack() {
    if (currentPets.isEmpty) return Container();

    return PageView.builder(
      controller: _pageController,
      itemCount: currentPets.length,
      onPageChanged: (index) {
        setState(() {
          currentPetIndex = index;
        });
      },
      itemBuilder: (context, index) {
        final pet = currentPets[index];
        return _buildPetCard(pet, index);
      },
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: (pet['gradient'] as List<Color>?) ?? [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.asset(
          pet['imageAsset'],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(
                Icons.pets,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}