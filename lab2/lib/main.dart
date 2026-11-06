// Laborator 2 - Varianta 3: Mid City Gym Training
// Autor: Brînză Bogdan
// Ecrane (conform Figma, pagina V3): "21. Home v2" si "30. Fitness"
import 'package:flutter/material.dart';

void main() => runApp(const GymApp());

const Color kGreen = Color(0xFF5CC466);
const Color kDark = Color(0xFF14161C);
const Color kGrey = Color(0xFF8A8F9C);

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mid City Gym Training',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// Ecranul 1: 21. Home v2
// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];
  int _selectedCategory = 0;

  void _openFitness() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FitnessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Friday, 20 May',
                          style: TextStyle(color: kGrey, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Good Morning',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const _BellButton(),
                ],
              ),
              const SizedBox(height: 24),

              // Today's Challenge
              const _ChallengeCard(),
              const SizedBox(height: 28),

              // Featured Plan
              _SectionHeader(title: 'Featured Plan', onSeeAll: () {}),
              const SizedBox(height: 16),
              SizedBox(
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _FeaturedCard(
                      title: 'Massive Upper Body',
                      info: '5 week  •  4x/week',
                      onStart: _openFitness,
                    ),
                    const SizedBox(width: 16),
                    _FeaturedCard(
                      title: 'Massive Lower Body',
                      info: '6 week  •  3x/week',
                      onStart: _openFitness,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Workout Programs
              _SectionHeader(title: 'Workout Programs', onSeeAll: () {}),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final selected = i == _selectedCategory;
                    return ChoiceChip(
                      label: Text(_categories[i]),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedCategory = i),
                      showCheckmark: false,
                      selectedColor: kGreen,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : kDark,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: selected ? kGreen : const Color(0xFFE3E5EA),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Program cards
              Row(
                children: [
                  Expanded(
                    child: _ProgramCard(
                      title: 'Yoga',
                      kcal: '210 kcl',
                      minutes: '120 min',
                      imageColors: const [Color(0xFF4A4B52), Color(0xFF1B1C21)],
                      onTap: _openFitness,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ProgramCard(
                      title: 'Arm\nStrengthening',
                      kcal: '210 kcl',
                      minutes: '120 min',
                      isPro: true,
                      imageColors: const [Color(0xFF5B5440), Color(0xFF1B1C21)],
                      onTap: _openFitness,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _BellButton extends StatelessWidget {
  const _BellButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE6E8EC)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.notifications_none_rounded, size: 26, color: kDark),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Today's Challenge",
                    style: TextStyle(color: kGrey, fontSize: 16)),
                SizedBox(height: 6),
                Text('Running',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircularProgressIndicator(
                  value: 15 / 20,
                  strokeWidth: 5,
                  color: kGreen,
                  backgroundColor: Color(0xFF2B2E37),
                ),
                Text('15/20',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('See All',
              style: TextStyle(
                  color: kGreen, fontSize: 16, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback onStart;

  const _FeaturedCard({
    required this.title,
    required this.info,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 210,
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: _PhotoPlaceholder(width: 150, height: 150, radius: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170,
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.fitness_center,
                      color: Colors.white70, size: 16),
                  const SizedBox(width: 6),
                  Text(info, style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(130, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Start Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final String title;
  final String kcal;
  final String minutes;
  final bool isPro;
  final List<Color> imageColors;
  final VoidCallback onTap;

  const _ProgramCard({
    required this.title,
    required this.kcal,
    required this.minutes,
    required this.imageColors,
    required this.onTap,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: imageColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: Center(
                child: Icon(Icons.image_outlined,
                    color: Colors.white24, size: 48),
              ),
            ),
            if (isPro)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.workspace_premium_outlined,
                          color: kGreen, size: 16),
                      SizedBox(width: 4),
                      Text('Pro',
                          style: TextStyle(
                              color: kGreen, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_fire_department_outlined,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(kcal,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(minutes,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Ecranul 2: 30. Fitness
// ============================================================
class _Amenity {
  final String name;
  final IconData icon;

  const _Amenity(this.name, this.icon);
}

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  static const _amenities = [
    _Amenity('Showers', Icons.shower),
    _Amenity('Lockers', Icons.lock_outline),
    _Amenity('Sauna', Icons.spa_outlined),
    _Amenity('Parking', Icons.local_parking),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    _PhotoPlaceholder(width: screenWidth, height: 380),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CircleIcon(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                            const _CircleIcon(icon: Icons.more_vert),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.star_rounded,
                              color: Color(0xFFFFB648), size: 24),
                          SizedBox(width: 6),
                          Text('4.5',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Text('(1,232 reviews)',
                              style: TextStyle(color: kGrey, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Mid City Gym Training',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      const Text('California, New York',
                          style: TextStyle(color: kGrey, fontSize: 16)),
                      const Divider(height: 32),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              color: kGrey, fontSize: 16, height: 1.5),
                          children: [
                            TextSpan(
                                text: 'Lorem ipsum dolor sit amet consectetur. '
                                    'Blandit vitae aliquet eros laoreet quam '
                                    'sollicitudin. Duis non eu habitant id vel '
                                    'nisi eget amet tellus... '),
                            TextSpan(
                              text: 'Read more',
                              style: TextStyle(
                                  color: kGreen, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Amenities',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.9,
                        children: _amenities
                            .map((a) => _AmenityTile(amenity: a))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bara de jos: Total + Reserve
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -4)),
              ],
            ),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total', style: TextStyle(color: kGrey, fontSize: 16)),
                    SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$69.00',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' /week',
                            style: TextStyle(color: kGrey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 170,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rezervare trimisă!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Reserve',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityTile extends StatelessWidget {
  final _Amenity amenity;

  const _AmenityTile({required this.amenity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E8EC)),
      ),
      child: Row(
        children: [
          Icon(amenity.icon, color: kGrey, size: 22),
          const SizedBox(width: 12),
          Text(amenity.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIcon({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white24,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

// Placeholder pentru fotografii. Înlocuiește cu Image.asset după ce exporți
// imaginile din Figma în folderul assets/.
class _PhotoPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _PhotoPlaceholder({
    required this.width,
    required this.height,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [Color(0xFF4B4F5B), Color(0xFF23262E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(Icons.person_outline, color: Colors.white24, size: 56),
    );
  }
}