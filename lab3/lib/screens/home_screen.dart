import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workout_cubit.dart';
import '../bloc/workout_state.dart';
import '../core/app_colors.dart';
import '../models/fitness_models.dart';
import '../widgets/featured_plan_card.dart';
import '../widgets/filter_chips_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';
import '../widgets/workout_program_card.dart';
import 'gym_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            return switch (state) {
              WorkoutLoading() => const LoadingView(),
              WorkoutError(:final message) => ErrorView(
                  message: message,
                  onRetry: () => context.read<WorkoutCubit>().load(),
                ),
              WorkoutLoaded loaded => _HomeContent(state: loaded),
            };
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.state});

  final WorkoutLoaded state;

  void _openGym(BuildContext context, GymDetails gym) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GymDetailsScreen(gym: gym)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = state.data;
    final cubit = context.read<WorkoutCubit>();

    final programWidgets = <Widget>[];
    if (state is WorkoutEmpty) {
      programWidgets.add(const EmptyView(
          message: 'Nu există programe pentru căutarea sau filtrul curent.'));
    } else {
      for (final p in state.visiblePrograms) {
        programWidgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: WorkoutProgramCard(
            program: p,
            isFavorite: state.favoriteIds.contains(p.id),
            onToggleFavorite: () => cubit.toggleFavorite(p.id),
            onTap: () => _openGym(context, data.gym),
          ),
        ));
      }
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      children: [
        _Header(
          date: data.date,
          greeting: data.greeting,
          hasUnread: data.hasUnread,
        ),
        const SizedBox(height: 24),
        _ChallengeCard(challenge: data.challenge),
        const SizedBox(height: 28),
        SectionHeader(title: 'Featured Plan', onSeeAll: () {}),
        const SizedBox(height: 16),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.featuredPlans.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, i) => FeaturedPlanCard(
              plan: data.featuredPlans[i],
              onStart: () => _openGym(context, data.gym),
            ),
          ),
        ),
        const SizedBox(height: 28),
        SectionHeader(title: 'Workout Programs', onSeeAll: () {}),
        const SizedBox(height: 16),
        TextField(
          onChanged: cubit.setQuery,
          decoration: InputDecoration(
            hintText: 'Caută un program',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF4F5F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilterChipsBar(
          filters: data.filters,
          selectedId: state.filterId,
          onSelected: cubit.setFilter,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '${state.visiblePrograms.length} programe',
              style: const TextStyle(color: kGrey),
            ),
            const Spacer(),
            DropdownButton<SortOption>(
              value: state.sort,
              underline: const SizedBox.shrink(),
              items: SortOption.values
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s.label,
                            style: const TextStyle(fontSize: 14)),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) cubit.setSort(v);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...programWidgets,
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.greeting,
    required this.hasUnread,
  });

  final String date;
  final String greeting;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(color: kGrey, fontSize: 16)),
            const SizedBox(height: 4),
            Text(greeting,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
          ],
        ),
        Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE6E8EC)),
              ),
              child: const Icon(Icons.notifications_none_rounded, color: kDark),
            ),
            if (hasUnread)
              Positioned(
                top: 14,
                right: 14,
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
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final ChallengeInfo challenge;

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
              children: [
                Text(challenge.title,
                    style: const TextStyle(color: kGrey, fontSize: 16)),
                const SizedBox(height: 6),
                Text(challenge.activity,
                    style: const TextStyle(
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
              children: [
                CircularProgressIndicator(
                  value: challenge.progress,
                  strokeWidth: 5,
                  color: kGreen,
                  backgroundColor: const Color(0xFF2B2E37),
                ),
                Text('${challenge.completed}/${challenge.total}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
