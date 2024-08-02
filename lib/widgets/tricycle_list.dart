import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricycle_app/blocs/tricycle_event.dart';
import 'package:tricycle_app/models/tricycle.dart';
import '../blocs/tricycle_bloc.dart';
import '../blocs/tricycle_state.dart';

class TricycleList extends StatelessWidget {
  const TricycleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TricycleBloc, TricycleState>(
      builder: (context, state) {
        if (state is TricyclesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TricyclesLoaded) {
          return ListView.builder(
            itemCount: state.tricycles.length,
            itemBuilder: (context, index) {
              final tricycle = state.tricycles[index];
              return ListTile(
                title: Text(tricycle.model),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tricycle.brand),
                    Text('Material: ${tricycle.material}'),
                    Text('Load Capacity: ${tricycle.load_capacity} kg'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, tricycle);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(
                                  'Are you sure you want to delete this tricycle? Por favor esperar unos segundos para que se actualice la lista.'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    context
                                        .read<TricycleBloc>()
                                        .add(DeleteTricycle(tricycle.id));
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Failed to load tricycles'),
          );
        }
      },
    );
  }

  void _showEditDialog(BuildContext context, Tricycle tricycle) {
    final TextEditingController modelController =
        TextEditingController(text: tricycle.model);
    final TextEditingController brandController =
        TextEditingController(text: tricycle.brand);
    final TextEditingController materialController =
        TextEditingController(text: tricycle.material);
    final TextEditingController loadCapacityController =
        TextEditingController(text: tricycle.load_capacity.toString());

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Tricycle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Brand'),
              ),
              TextField(
                controller: materialController,
                decoration: const InputDecoration(labelText: 'Material'),
              ),
              TextField(
                controller: loadCapacityController,
                decoration: const InputDecoration(labelText: 'Load Capacity'),
                keyboardType: TextInputType.number,
              ),
              const Text(
                  'Por favor esperar unos segundos para que se actualice la lista.'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                final updatedTricycle = tricycle.copyWith(
                  model: modelController.text,
                  brand: brandController.text,
                  material: materialController.text,
                  load_capacity: int.parse(loadCapacityController.text),
                );
                context
                    .read<TricycleBloc>()
                    .add(UpdateTricycle(updatedTricycle));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
