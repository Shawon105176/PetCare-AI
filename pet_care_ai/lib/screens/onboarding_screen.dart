import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  Timer? _autoPageTimer;

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
    _startAutoPage();
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

  void _startAutoPage() {
    _autoPageTimer?.cancel();
    _autoPageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentPets.isNotEmpty && _pageController.hasClients) {
        int nextPage = (_pageController.page?.round() ?? 0) + 1;
        if (nextPage >= currentPets.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
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

  List<Map<String, dynamic>> get currentPets {
    if (selectedCategory == 'All') {
      // Combine all images from all categories
      return petsByCategory.values.expand((list) => list).toList();
    }
    return petsByCategory[selectedCategory] ?? [];
  }

  @override
  void dispose() {
    _autoPageTimer?.cancel();
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
      backgroundColor: Colors.black, // Set background to black
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
                        color: Color(0xFF00E676), // Green accent
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
                        color: Color(0xFF00B8D4), // Cyan accent
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
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Discover',
                            textStyle: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                              shadows: [
                                Shadow(
                                  blurRadius: 12,
                                  color: Color(0xFF00E676),
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            colors: [
                              Color(0xFFFFC107), // Amber
                              Color(0xFF00E676), // Green
                              Color(0xFF00B8D4), // Cyan
                              Colors.white,
                            ],
                            speed: Duration(milliseconds: 600),
                          ),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      const SizedBox(height: 8),
                      AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'AI-powered pet care for you',
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00B8D4),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  color: Color(0xFF00B8D4).withOpacity(0.5),
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 2000),
                          ),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryPill('All', selectedCategory == 'All'),
                        const SizedBox(width: 12),
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
    // Icon mapping for each category
    final Map<String, IconData> icons = {
      'All': Icons.apps,
      'Dog': Icons.pets,
      'Cat': Icons.pets, // You can use a custom cat icon if available
      'Bird': Icons.flutter_dash, // Substitute for bird
      'Fish': Icons.bubble_chart, // Substitute for fish
    };
    final Map<String, List<Color>> gradients = {
      'All': [Color(0xFF00B8D4), Color(0xFF00E676)],
      'Dog': [Color(0xFFFFC107), Color(0xFF00E676)],
      'Cat': [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
      'Bird': [Color(0xFFFFA17F), Color(0xFF00223E)],
      'Fish': [Color(0xFF43C6AC), Color(0xFF191654)],
    };
    return GestureDetector(
      onTap: () => _selectCategory(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: gradients[title] ?? [Color(0xFF00E676), Color(0xFF00B8D4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 2.5,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: gradients[title]?.last.withOpacity(0.4) ?? Colors.black26,
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: isSelected ? 1.2 : 1.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) => Transform.scale(
                scale: scale,
                child: child,
              ),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    colors: gradients[title] ?? [Color(0xFF00E676), Color(0xFF00B8D4)],
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcIn,
                child: Icon(
                  icons[title] ?? Icons.pets,
                  size: 22,
                  color: isSelected ? Colors.white : Color(0xFF00B8D4),
                  shadows: isSelected
                      ? [
                          Shadow(
                            blurRadius: 12,
                            color: gradients[title]?.first.withOpacity(0.7) ?? Colors.white,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                title,
                key: ValueKey(isSelected),
                style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFF00B8D4),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 1.1,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: isSelected
                          ? gradients[title]?.first.withOpacity(0.7) ?? Color(0xFFFFC107)
                          : Color(0xFF00B8D4).withOpacity(0.4),
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              AnimatedBuilder(
                animation: _slideController,
                builder: (context, child) {
                  return Opacity(
                    opacity: 0.7 + 0.3 * (_slideController.value),
                    child: Container(
                      margin: const EdgeInsets.only(left: 6),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: gradients[title] ?? [Color(0xFF00E676), Color(0xFF00B8D4)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: gradients[title]?.last.withOpacity(0.7) ?? Colors.white,
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetCardStack() {
    if (currentPets.isEmpty) return Container();

    return PageView.builder(
      key: ValueKey(selectedCategory), // Force rebuild on category change
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
      // Enable page snapping and allow swiping through all images
      physics: const BouncingScrollPhysics(),
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