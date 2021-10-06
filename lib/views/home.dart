import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:breeze/components/icons_loop.dart';
import 'package:breeze/constants/colors.dart';
import 'package:breeze/helpers/datetime.dart';
import 'package:breeze/helpers/input_box_style.dart';
import 'package:breeze/models/current_habit.dart';
import 'package:breeze/models/habit.dart';
import 'package:breeze/models/habit_type.dart';
import 'package:breeze/views/create_new_habit.dart';
import 'package:breeze/views/habit_description.dart';
import 'package:breeze/views/update_habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Box<Habit> _box;

  final DateFormat _onlyDate = DateFormat('d MMM');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _measurableDoneController = TextEditingController();

  Color _circleColor(int i, Habit h) {
    if (h.type == HabitType.yesOrNo) {      
      return h.daysDoneYesNo.contains(hiveDateFormat.format(DateTime.now().add(Duration(days: i))))
        ? maximumPurple
        : darkGray;
    } else {
      if (h.daysDoneMeasurable[hiveDateFormat.format(DateTime.now().add(Duration(days: i)))] != null) {
        if (h.daysDoneMeasurable[hiveDateFormat.format(DateTime.now().add(Duration(days: i)))]! >= h.measurableDone) {
          return maximumPurple;
        } else {
          return darkGray;
        }
      } else {
        return darkGray;
      }
    }
  }

  String _tileTitle(Habit h) {
    return h.name + (h.type == HabitType.yesOrNo ? ' (Yes or No)' : ' (Measurable ${h.measurableDone})');
  }

  Center _circleNumber(int i, Habit h) {
    if (h.type == HabitType.yesOrNo) {
      return const Center(
        child: Text(''),
      );
    } else {
      return Center(
        child: Text(
          h.daysDoneMeasurable[hiveDateFormat.format(DateTime.now().add(Duration(days: i)))]?.toString() ?? '0'
        ),
      );
    }
  }

  String? _newMeasurableValueValidator(String? input) {
    if (input == null || input.isEmpty) {
      return 'This field cannot be blank';
    }

    try {
      int _numberSign = int.parse(input).sign;

      if (_numberSign == -1) {
        return 'The value cannot be less than 0';
      }
    } on Exception catch (_) {
      return 'This field only accepts number';
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
        title: const Text('Habits'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateNewHabitPage.route);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _box.listenable(),
        builder: (ctx, Box<Habit> value, _) {
          if (value.isEmpty) {
            return const IconsLoopComponent();
          } else {
            return ListView.builder(
              itemCount: _box.length,
              itemBuilder: (_, index) {
                Habit _currentHabit = _box.getAt(index) ??
                  Habit(
                    name: '',
                    goal: '',
                    type: HabitType.yesOrNo,
                    daysDoneYesNo: [],
                    daysDoneMeasurable: {},
                    measurableDone: 0,
                  );

                return Dismissible(
                  key: ValueKey(index),
                  direction: DismissDirection.endToStart,
                  child: ExpansionTile(
                    textColor: babyPowderWhite,
                    iconColor: babyPowderWhite,
                    title: Text(_tileTitle(_currentHabit)),
                    collapsedIconColor: babyPowderWhite,
                    subtitle: Text(
                      _currentHabit.goal,
                      style: TextStyle(
                        color: babyPowderWhite,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('Recents', style: TextStyle(fontWeight: FontWeight.bold)),
                                const Spacer(),
                                ElevatedButton(
                                  child: const Text('Description'),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    HabitDescriptionPage.route,
                                    arguments: CurrentHabit(_currentHabit, index),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  child: const Text('Edit'),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    UpdateHabitPage.route,
                                    arguments: CurrentHabit(_currentHabit, index),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List<GestureDetector>.generate(7, (i) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_currentHabit.type == HabitType.yesOrNo) {
                                      String _dateString = hiveDateFormat.format(DateTime.now().add(Duration(days: i)));

                                      if (_currentHabit.daysDoneYesNo.contains(_dateString)) {
                                        _currentHabit.daysDoneYesNo.remove(_dateString);
                                      } else {
                                        _currentHabit.daysDoneYesNo.add(_dateString);
                                      }

                                      setState(() {
                                        _box.putAt(index, _currentHabit);
                                      });
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: darkGray,
                                          content: Form(
                                            key: _formKey,
                                            autovalidateMode: AutovalidateMode.always,
                                            child: TextFormField(
                                              controller: _measurableDoneController,
                                              validator: _newMeasurableValueValidator,
                                              decoration: inputBoxStyle('New amount', 'New measurable habit value'),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text('Exit'),
                                              onPressed: () {
                                                _measurableDoneController.clear();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Submit'),
                                              onPressed: () {
                                                FormState? _state = _formKey.currentState;

                                                if (_state != null && _state.validate()) {
                                                  _currentHabit.daysDoneMeasurable.update(
                                                    hiveDateFormat.format(DateTime.now().add(Duration(days: i))),
                                                    (_) => int.parse(_measurableDoneController.text),
                                                    ifAbsent: () => int.parse(_measurableDoneController.text),
                                                  );

                                                  setState(() {
                                                    _box.putAt(index, _currentHabit);
                                                  });

                                                  Navigator.pop(context);
                                                }
                                              }
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    width: (MediaQuery.of(context).size.width - 40) / 7,
                                    child: Column(
                                      children: [
                                        Text(_onlyDate.format(DateTime.now().add(Duration(days: i)))),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: _circleColor(i, _currentHabit),
                                            shape: BoxShape.circle,
                                            border: Border.all(color: maximumPurple),
                                          ),
                                          child: _circleNumber(i, _currentHabit),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                    expandedAlignment: Alignment.topLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        _box.deleteAt(index);
                      });
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
