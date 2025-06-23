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
        'name': 'Friendly Dog',
        'breed': 'Playful & Loyal',
        'gradient': [Color(0xFFFFE4B5), Color(0xFFFFB6C1)],
        'color': Color(0xFFD4AF37),
        'imageAsset': 'assets/image/pets.jpg',
        'description': 'Loves to greet everyone!',
      },
      {
        'name': 'Golden Pup',
        'breed': 'Fluffy & Energetic',
        'gradient': [Color(0xFFFFE4B5), Color(0xFFFFB6C1)],
        'color': Color(0xFFD4AF37),
        'imageAsset': 'assets/image/pets1.png',
        'description': 'Always ready for a walk.',
      },
      {
        'name': 'White Pomeranian',
        'breed': 'Cute & Smart',
        'gradient': [Color(0xFF87CEEB), Color(0xFFE6E6FA)],
        'color': Color(0xFF708090),
        'imageAsset': 'assets/image/pets2.jpg',
        'description': 'Loves to play and cuddle.',
      },
    ],
    'Cat': [
      {
        'name': 'Cat Duo',
        'breed': 'Best Friends',
        'gradient': [Color(0xFFDDA0DD), Color(0xFF98FB98)],
        'color': Color(0xFF8B7355),
        'imageAsset': 'assets/image/pets3.jpg',
        'description': 'Double the fun and love.',
      },
      {
        'name': 'Paw Cat',
        'breed': 'Curious & Sweet',
        'gradient': [Color(0xFFDDA0DD), Color(0xFF98FB98)],
        'color': Color(0xFF8B7355),
        'imageAsset': 'assets/image/pets4.jpg',
        'description': 'Loves to explore and nap.',
      },
      {
        'name': 'Happy Cat',
        'breed': 'Chill & Cheerful',
        'gradient': [Color(0xFFDDA0DD), Color(0xFF98FB98)],
        'color': Color(0xFF8B7355),
        'imageAsset': 'assets/image/pets5.jpg',
        'description': 'Always in a good mood.',
      },
    ],
    'Bird': [
      {
        'name': 'Canary',
        'breed': 'Cheerful Singer',
        'gradient': [Color(0xFFFFE4B5), Color(0xFF87CEFA)],
        'color': Color(0xFFFFD700),
        'imageAsset': 'assets/image/pets6.jpg',
        'description': 'Beautiful songs every morning',
      },
      {
        'name': 'Parrot',
        'breed': 'Smart & Talkative',
        'gradient': [Color(0xFF32CD32), Color(0xFF87CEEB)],
        'color': Color(0xFF32CD32),
        'imageAsset': 'assets/image/pets7.jpg',
        'description': 'Interactive and intelligent pet',
      },
    ],
    'Fish': [
      {
        'name': 'Goldfish',
        'breed': 'Peaceful Swimmer',
        'gradient': [Color(0xFF20B2AA), Color(0xFFFFE4E1)],
        'color': Color(0xFF4ECDC4),
        'imageAsset': 'assets/image/pets8.jpg',
        'description': 'Calming and low maintenance',
      },
      {
        'name': 'Betta Fish',
        'breed': 'Colorful & Vibrant',
        'gradient': [Color(0xFF4169E1), Color(0xFFFF1493)],
        'color': Color(0xFF4169E1),
        'imageAsset': 'assets/image/pets9.jpg',
        'description': 'Beautiful colors and flowing fins',
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
          colors: pet['gradient'] as List<Color>,
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
      child: Stack(
        children: [
          // Pet Image Section
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 220,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    pet['imageAsset'],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
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
              ),
            ),
          ),
          // Pet Name & Breed below image
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  pet['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C2C2C),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  pet['breed'],
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color(0xFF2C2C2C).withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Overlay with interaction hint
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 16,
                color: Color(0xFF2C2C2C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
