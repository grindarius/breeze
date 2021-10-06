import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:breeze/helpers/input_box_style.dart';
import 'package:breeze/helpers/measurable_done_validator.dart';
import 'package:breeze/models/current_habit.dart';
import 'package:breeze/models/habit.dart';
import 'package:breeze/models/habit_type.dart';
import 'package:breeze/views/home.dart';

class UpdateHabitPage extends StatefulWidget {
  const UpdateHabitPage({ Key? key, required this.currentHabit }) : super(key: key);

  static const String route = '/update_habit';
  final CurrentHabit currentHabit;

  @override
  _UpdateHabitPageState createState() => _UpdateHabitPageState();
}

class _UpdateHabitPageState extends State<UpdateHabitPage> {
  late final Box<Habit> _box;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _goalController;
  late TextEditingController _measurableDoneController;
  late String _appBarHeader;

  Widget _getMeasurableMarkDone() {
    if (widget.currentHabit.habit.type == HabitType.yesOrNo) {
      return const SizedBox(width: 10);
    } else {
      return TextFormField(
        controller: _measurableDoneController,
        validator: measurableDoneValidator,
        decoration: inputBoxStyle('Mark as done amount', 'How many times for a habit to be done.'),
      );
    }
  }

  void _updateHabit() async {
    Habit _newHabit = Habit(
      name: _nameController.text,
      goal: _goalController.text,
      type: widget.currentHabit.habit.type,
      daysDoneYesNo: widget.currentHabit.habit.daysDoneYesNo,
      daysDoneMeasurable: widget.currentHabit.habit.daysDoneMeasurable,
      measurableDone: int.parse(_measurableDoneController.text),
    );

    _box.putAt(widget.currentHabit.i, _newHabit);
  }

  String? _inputValidator(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    _box = Hive.box<Habit>('habits');
    _appBarHeader = widget.currentHabit.habit.name;
    _nameController = TextEditingController(text: widget.currentHabit.habit.name);
    _goalController = TextEditingController(text: widget.currentHabit.habit.goal);
    _measurableDoneController = TextEditingController(text: widget.currentHabit.habit.measurableDone.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarHeader)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                validator: _inputValidator,
                onChanged: (value) => setState(() {
                  _appBarHeader = value.isEmpty ? 'New habit' : value;
                }),
                decoration: inputBoxStyle('Name', 'Drink water')
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _goalController,
                validator: _inputValidator,
                onChanged: (value) => _inputValidator(value),
                decoration: inputBoxStyle(
                  'Goal',
                  'Drink 6 glasses of water a day'
                )
              ),
              const SizedBox(height: 10),
              _getMeasurableMarkDone(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      FormState? _state = _formKey.currentState;
                      if (_state != null && _state.validate()) {
                        _updateHabit();
                        Navigator.pushNamedAndRemoveUntil(context, HomePage.route, (route) => false);
                      }
                    },
                    child: const Text('Update')
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
