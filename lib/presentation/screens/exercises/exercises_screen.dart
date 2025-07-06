import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/config/helpers/muscle_section_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/presentation/providers/exercises_provider.dart';
import 'package:namer_app/presentation/providers/muscle_sections_provider.dart';
import 'package:namer_app/presentation/screens/exercises/new_exercise_screen.dart';
import 'package:namer_app/presentation/widgets/exercise_list_widget.dart';
import 'package:namer_app/presentation/widgets/filter_chips_widget.dart';

class ExercisesScreen extends ConsumerWidget {
  static final name = 'exercises_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Exercise>> exercises = ref.watch(exerciseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios'),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(NewExerciseScreen.name);
                },
                child: Text('Nuevo')),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterSection();
                    });
              },
              icon: Icon(Icons.filter_alt),
            )
          ],
        ),
        switch (exercises) {
          AsyncData(:final value) => ExerciseListWidget(
              exercises: value,
            ),
          AsyncLoading() => Center(
              child: CircularProgressIndicator(),
            ),
          AsyncError() => Center(
              child: Text('Error'),
            ),
        }
      ]),
    );
  }
}

class FilterSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterSectionState();
}

class _FilterSectionState extends ConsumerState<FilterSection> {
  final selectedFilters = <FilterChipData>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MuscleSection>> muscleSections =
        ref.watch(muscleSectionsProvider);

    return SizedBox(
        child: Card(
            child: Column(children: [
      Text('Filtros'),
      Expanded(
          child: ListView(scrollDirection: Axis.vertical, children: [
        SizedBox(
          height: 48,
          child: switch (muscleSections) {
            AsyncData(:final value) => FilterChips(
                chips: value.map((muscle) {
                  return FilterChipData(label: muscle.name, value: muscle.uuid);
                }).toList(),
                selectedChips: selectedFilters,
                onSelected: (bool selected, FilterChipData chip) {
                  setState(() {
                    if (selected) {
                      selectedFilters.add(chip);
                    } else {
                      selectedFilters
                          .removeWhere((item) => item.value == chip.value);
                    }
                    final muscleSectionExercise = selectedFilters.map((e) {
                      return MuscleExerciseOnCreate(
                          description: "descrpi",
                          effort: 100,
                          muscleSectionId: e.value);
                    }).toList();
                    print(muscleSectionExercise);
                  });
                },
              ),
            AsyncLoading() => Center(
                child: CircularProgressIndicator(),
              ),
            AsyncError() => Center(
                child: Text('Error'),
              ),
          },
        ),
      ]))
    ])));
  }
}
