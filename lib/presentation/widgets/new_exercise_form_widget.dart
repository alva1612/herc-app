import 'package:flutter/material.dart';
import 'package:namer_app/config/helpers/muscle_section_service.dart';
import 'package:namer_app/domain/entities/exercise.dart';
import 'package:namer_app/presentation/providers/new_exercise_provider.dart';
import 'package:namer_app/presentation/widgets/filter_chips_widget.dart';
import 'package:provider/provider.dart';

class NewExerciseForm extends StatefulWidget {
  @override
  State<NewExerciseForm> createState() => _NewExerciseFormState();
}

class NewExerciseWidget extends StatelessWidget {
  const NewExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NewExerciseProvider(child: NewExerciseForm());
  }
}

class _NewExerciseFormState extends State<NewExerciseForm> {
  late Future<List<MuscleSection>> muscleSections;
  final selectedFilters = <FilterChipData>[];

  @override
  void initState() {
    super.initState();
    muscleSections = MuscleSectionService.getMuscleSections('');
  }

  @override
  Widget build(BuildContext context) {
    var formState = context.watch<NewExerciseFormState>();
    var setDescription = formState.setDescription;
    var setName = formState.setName;
    var setMuscleSectionExercises = formState.setMuscleSectionExercises;
    var create = formState.createExercise;
    var clear = formState.clear;

    return Container(
      color: Color.fromRGBO(25, 33, 38, 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: FutureBuilder(
                  future: muscleSections,
                  builder: (contextFuture, snapshot) {
                    if (snapshot.hasError) {
                      print('----ERROR_FURURE_MUSCLES');
                      print(snapshot.error);
                      return const Text('error');
                    }
                    if (!snapshot.hasData) {
                      return const Text('loading');
                    }
                    final filterChipValues = snapshot.data!.map((muscle) {
                      return FilterChipData(
                          label: muscle.name, value: muscle.uuid);
                    }).toList();
                    return FilterChips(
                      chips: filterChipValues,
                      selectedChips: selectedFilters,
                      onSelected: (bool selected, FilterChipData chip) {
                        setState(() {
                          if (selected) {
                            selectedFilters.add(chip);
                          } else {
                            selectedFilters.removeWhere(
                                (item) => item.value == chip.value);
                          }
                          final muscleSectionExercise = selectedFilters.map((e) {
                            return MuscleExerciseOnCreate(
                                description: "descrpi",
                                effort: 100,
                                muscleSectionId: e.value);
                          }).toList();
                          print(muscleSectionExercise);
                          setMuscleSectionExercises(muscleSectionExercise);
                        });
                      },
                    );
                  }),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Nombre"),
            onChanged: (event) {
              try {
                setName(event);
              } catch (e) {
                print(e);
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Descripción"),
            onChanged: (event) {
              try {
                setDescription(event);
              } catch (e) {
                print(e);
              }
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  create();
                },
                label: Text('Save'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  clear();
                },
                child: Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
