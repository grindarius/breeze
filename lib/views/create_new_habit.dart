import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:breeze/constants/colors.dart';
import 'package:breeze/helpers/input_box_style.dart';
import 'package:breeze/helpers/measurable_done_validator.dart';
import 'package:breeze/models/habit.dart';
import 'package:breeze/models/habit_type.dart';

class CreateNewHabitPage extends StatefulWidget {
  const CreateNewHabitPage({ Key? key }) : super(key: key);

  static const String route = '/new_habit';

  @override
  _CreateNewHabitPageState createState() => _CreateNewHabitPageState();
}

class _CreateNewHabitPageState extends State<CreateNewHabitPage> {
  late final Box<Habit> _box;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _habitTypeController = TextEditingController(text: 'Yes or No');
  final TextEditingController _measurableDoneController = TextEditingController(text: '0');

  HabitType _selectedHabitType = HabitType.yesOrNo;

  String _appBarHeader = 'New habit';

  Widget _getMeasurableMarkDone() {
    if (_selectedHabitType == HabitType.yesOrNo) {
      return const SizedBox(width: 10);
    } else {
      return TextFormField(
        controller: _measurableDoneController,
        validator: measurableDoneValidator,
        decoration: inputBoxStyle('Mark as done amount', 'How many times for a habit to be done.'),
      );
    }
  }

  void _addNewHabit() async {
    Habit _newHabit = Habit(
      name: _nameController.text,
      goal: _goalController.text,
      type: _selectedHabitType,
      measurableDone: int.parse(_measurableDoneController.text),
      daysDoneYesNo: [],
      daysDoneMeasurable: {},
    );

    await _box.add(_newHabit);
  }

  String? _inputValidator(String? input) {
    if (input == null || input.isEmpty) {
      return 'This field cannot be blank';
    }
    return null;
  }

  @override
  void initState() {
    _box = Hive.box<Habit>('habits');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarHeader),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _habitTypeController,
                    decoration: inputBoxStyle('Habit type', 'Which type of habit'),
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setRadioState) => AlertDialog(
                        contentPadding: const EdgeInsets.fromLTRB(8, 14, 10, 14),
                        backgroundColor: darkGray,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RadioListTile<HabitType>(
                              title: const Text('Yes or No habit'),
                              subtitle: Text(
                                'A type of habit that you only have to do it once per day.',
                                style: TextStyle(color: babyPowderWhite),
                              ),
                              value: HabitType.yesOrNo,
                              groupValue: _selectedHabitType,
                              onChanged: (HabitType? value) {
                                setRadioState(() {
                                  _selectedHabitType = value ?? HabitType.yesOrNo;
                                  _habitTypeController.text = 'Yes or No';
                                });
                                setState(() {});
                              },
                            ),
                            RadioListTile<HabitType>(
                              title: const Text('Measurable habit'),
                              subtitle: Text(
                                'A type of habit that you have to do it multiple times per day.',
                                style: TextStyle(color: babyPowderWhite),
                              ),
                              value: HabitType.measurable,
                              groupValue: _selectedHabitType,
                              onChanged: (HabitType? value) {
                                setRadioState(() {
                                  _selectedHabitType = value ?? HabitType.measurable;
                                  _habitTypeController.text = 'Measurable';
                                });
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextFormField(
                controller: _nameController,
                validator: _inputValidator,
                onChanged: (value) => setState(() {
                  _appBarHeader = value.isEmpty ? 'New habit' : value;
                }),
                decoration: inputBoxStyle('Name', 'Drink water'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _goalController,
                validator: _inputValidator,
                onChanged: (value) => _inputValidator(value),
                decoration: inputBoxStyle(
                  'Goal',
                  'Drink 6 glasses of water a day',
                ),
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
                        _addNewHabit();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
