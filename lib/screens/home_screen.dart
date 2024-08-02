import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tricycle_app/blocs/tricycle_event.dart';
import 'package:tricycle_app/models/tricycle_save.dart';
import '../blocs/tricycle_bloc.dart';
import '../repositories/tricycle_repository.dart';
import '../widgets/tricycle_list.dart';

class HomeScreen extends StatefulWidget {
  final TricycleRepository tricycleRepository;

  const HomeScreen({super.key, required this.tricycleRepository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tricycles'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: BlocProvider(
        create: (context) =>
            TricycleBloc(widget.tricycleRepository)..add(GetAllTricycles()),
        child: const TricycleList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTricycleModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTricycleModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _modelController = TextEditingController();
    final _brandController = TextEditingController();
    final _materialController = TextEditingController();
    final _loadCapacityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Tricycle'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the brand';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _materialController,
                  decoration: const InputDecoration(labelText: 'Material'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the material';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _loadCapacityController,
                  decoration: const InputDecoration(labelText: 'Load Capacity'),
                  validator: (value) {
                    if (int.tryParse(value!) == null) {
                      return 'Please enter a valid load capacity';
                    }

                    if (int.parse(value) <= 0) {
                      return 'Please enter a positive load capacity';
                    }

                    return null;
                  },
                ),
                const Text('Por favor recarga la página para ver los cambios')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newTricycle = TricycleSave(
                    brand: _modelController.text,
                    model: _brandController.text,
                    material: _materialController.text,
                    load_capacity: int.parse(_loadCapacityController.text),
                  );
                  context.read<TricycleBloc>().add(SaveTricycle(newTricycle));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
