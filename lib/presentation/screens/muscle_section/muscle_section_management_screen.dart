import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/config/helpers/muscle_section_service.dart';
import 'package:namer_app/presentation/providers/muscle_sections_provider.dart';
import 'package:namer_app/presentation/widgets/ui/generic_list_widget.dart';

class MuscleSectionManagementScreen extends ConsumerWidget {
  const MuscleSectionManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<MuscleSection>> muscleSections =
        ref.watch(muscleSectionsListProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gestión de Secciones Musculares'),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para crear una nueva sección muscular
                },
                child: const Text('Nueva Sección'),
              ),
            ],
          ),
          switch (muscleSections) {
            AsyncData(:final value) => GenericListWidget(
                items: value.map((e) => e.toGenericListItem()).toList(),
                onDelete: (item) {
                  final muscleSection = item as MuscleSection;
                  ref
                      .read(muscleSectionsListProvider.notifier)
                      .delete(muscleSection.uuid);
                }),
            AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            AsyncError() => const Center(
                child: Text('Error al cargar las secciones musculares'),
              ),
          }
        ]));
  }
}
