import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pet_profile_screen.dart';
import 'screens/full_checkup_screen.dart';
import 'screens/profile_screen.dart';

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
      routes: {
        '/home': (context) => const MainNavigationScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    PetProfileScreen(),
    FullCheckupScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: _PremiumNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Replace _PremiumNavBar with a stateful widget that animates a line between items
class _PremiumNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _PremiumNavBar({required this.selectedIndex, required this.onTap});

  @override
  State<_PremiumNavBar> createState() => _PremiumNavBarState();
}

class _PremiumNavBarState extends State<_PremiumNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _oldIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _oldIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant _PremiumNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _oldIndex = oldWidget.selectedIndex;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _LiquidNavBarItemData(
        icon: Icons.home_rounded,
        selected: widget.selectedIndex == 0,
        onTap: () => widget.onTap(0),
        gradient: const LinearGradient(
          colors: [Color(0xFFE4A574), Color(0xFFFFD600)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _LiquidNavBarItemData(
        icon: Icons.search_rounded,
        selected: widget.selectedIndex == 1,
        onTap: () => widget.onTap(1),
        gradient: const LinearGradient(
          colors: [Color(0xFF00B8D4), Color(0xFFE040FB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _LiquidNavBarItemData(
        icon: Icons.add_rounded,
        selected: widget.selectedIndex == 2,
        onTap: () => widget.onTap(2),
        gradient: const LinearGradient(
          colors: [Color(0xFF00E676), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _LiquidNavBarItemData(
        icon: Icons.notifications_rounded,
        selected: widget.selectedIndex == 3,
        onTap: () => widget.onTap(3),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF536DFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ];
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated line between old and new selected item
              CustomPaint(
                size: const Size(double.infinity, 80),
                painter: _NavBarLinePainter(
                  progress: _animation.value,
                  from: _oldIndex,
                  to: widget.selectedIndex,
                  itemCount: items.length,
                  color: Colors.white.withOpacity(0.18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(items.length, (i) {
                  return _LiquidNavBarItem(
                    icon: items[i].icon,
                    selected: widget.selectedIndex == i,
                    onTap: items[i].onTap,
                    gradient: items[i].gradient,
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavBarLinePainter extends CustomPainter {
  final double progress;
  final int from;
  final int to;
  final int itemCount;
  final Color color;

  _NavBarLinePainter({
    required this.progress,
    required this.from,
    required this.to,
    required this.itemCount,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double navWidth = size.width;
    final double navHeight = size.height;
    final double itemSpacing = navWidth / itemCount;
    final double fromX = itemSpacing * (from + 0.5);
    final double toX = itemSpacing * (to + 0.5);
    final double centerY = navHeight / 2;
    final double lerpX = fromX + (toX - fromX) * progress;
    final double thickness = 18;
    final double glow = 0.5 + 0.5 * progress;

    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.deepPurpleAccent.withOpacity(0.7 * glow),
          Colors.blueAccent.withOpacity(0.5 * glow),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromPoints(Offset(fromX, centerY), Offset(toX, centerY)))
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * glow);

    if (from != to) {
      // Draw a morphing "liquid" line with bulges at both ends
      Path path = Path();
      path.moveTo(fromX, centerY);
      double midX = fromX + (toX - fromX) * progress;
      double bulge = 16 * (1 - (progress - 0.5).abs() * 2); // bulge in the middle
      path.cubicTo(
        fromX + bulge, centerY - bulge,
        midX - bulge, centerY + bulge,
        midX, centerY,
      );
      path.cubicTo(
        midX + bulge, centerY - bulge,
        toX - bulge, centerY + bulge,
        toX, centerY,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NavBarLinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.from != from || oldDelegate.to != to;
  }
}

class _LiquidNavBarItemData {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Gradient gradient;
  const _LiquidNavBarItemData({
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.gradient,
  });
}

class _LiquidNavBarItem extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Gradient gradient;
  const _LiquidNavBarItem({
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.gradient,
  });

  @override
  State<_LiquidNavBarItem> createState() => _LiquidNavBarItemState();
}

class _LiquidNavBarItemState extends State<_LiquidNavBarItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _bubbleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _bubbleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    if (widget.selected) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _LiquidNavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected && !oldWidget.selected) {
      _controller.forward();
    } else if (!widget.selected && oldWidget.selected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (widget.selected)
                  Opacity(
                    opacity: _bubbleAnim.value * 0.8,
                    child: Container(
                      width: 48 + 18 * _bubbleAnim.value,
                      height: 48 + 18 * _bubbleAnim.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: widget.gradient,
                        boxShadow: [
                          BoxShadow(
                            color: widget.gradient.colors.last.withOpacity(0.35),
                            blurRadius: 24,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                Transform.scale(
                  scale: _scaleAnim.value,
                  child: Icon(
                    widget.icon,
                    size: widget.selected ? 32 : 26,
                    color: widget.selected ? Colors.white : Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
