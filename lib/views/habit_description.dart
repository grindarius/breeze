import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:breeze/components/habit_result_chart.dart';
import 'package:breeze/constants/colors.dart';
import 'package:breeze/helpers/datetime.dart';
import 'package:breeze/models/chart_data.dart';
import 'package:breeze/models/current_habit.dart';
import 'package:breeze/models/habit_type.dart';
import 'package:breeze/views/update_habit.dart';

class HabitDescriptionPage extends StatefulWidget {
  const HabitDescriptionPage({ Key? key, required this.currentHabit }) : super(key: key);

  static const String route = '/habit_description';
  final CurrentHabit currentHabit;

  @override
  _HabitDescriptionPageState createState() => _HabitDescriptionPageState();
}

class _HabitDescriptionPageState extends State<HabitDescriptionPage> {
  late List<String> _sortedYesNoData;
  late Map<String, int> _sortedMeasurableData;

  late String _startDate;
  late String _endDate;

  List<Widget> _getMeasurableDone() {
    if (widget.currentHabit.habit.type == HabitType.yesOrNo) {
      return [const SizedBox(width: 1)];
    } else {
      return [
        const Text(
          'Habit measurable done',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(widget.currentHabit.habit.measurableDone.toString() + ' times'),
      ];
    }
  }

  List<charts.Series<ChartData, DateTime>> _getChartData() {
    if (widget.currentHabit.habit.type == HabitType.yesOrNo) {
      List<ChartData> yesNoData = getDaysInBetween(DateTime.parse(_startDate), DateTime.parse(_endDate))
        .map((eachDate) {
          return ChartData(eachDate, widget.currentHabit.habit.daysDoneYesNo.contains(hiveDateFormat.format(eachDate)) ? 1 : 0);
        }).toList();

      return [
        charts.Series<ChartData, DateTime>(
          id: 'YesNoChart',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(maximumPurple),
          domainFn: (ChartData data, _) => data.date,
          measureFn: (ChartData data, _) => data.finished,
          data: yesNoData,
        )
      ];
    } else {
      List<ChartData> measurableData = getDaysInBetween(DateTime.parse(_startDate), DateTime.parse(_endDate))
        .map((eachDate) {
          return ChartData(eachDate, widget.currentHabit.habit.daysDoneMeasurable[hiveDateFormat.format(eachDate)] ?? 0);
        }).toList();

      return [
        charts.Series<ChartData, DateTime>(
          id: 'MeasurableChart',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(maximumPurple),
          domainFn: (ChartData data, _) => data.date,
          measureFn: (ChartData data, _) => data.finished,
          data: measurableData.every((e) => e.finished == 0) ? [] : measurableData,
        ),
      ];
    }
  }

  List<charts.ChartBehavior<DateTime>> _getChartBehavior() {
    if (widget.currentHabit.habit.type == HabitType.yesOrNo) {
      return [];
    } else {
      return [
        charts.RangeAnnotation([
          charts.LineAnnotationSegment(
            widget.currentHabit.habit.measurableDone,
            charts.RangeAnnotationAxisType.measure,
            endLabel: 'Done level',
            color: charts.ColorUtil.fromDartColor(Colors.red),
          ),
        ]),
      ];
    }
  }

  Widget _renderChart() {
    List<int> mappedMeasurableData = _sortedMeasurableData.entries.map((e) {
      return e.value;
    }).toList();

    if (_sortedYesNoData.isEmpty && widget.currentHabit.habit.type == HabitType.yesOrNo) {
      return const Text(
        'No data',
        style: TextStyle(color: Colors.red),
      );
    } else if (mappedMeasurableData.where((e) => e != 0).isEmpty && widget.currentHabit.habit.type == HabitType.measurable) {
      return const Text(
        'No data',
        style: TextStyle(color: Colors.red),
      );
    } else {
      return HabitResultChart(
        series: _getChartData(),
        animate: false,
        behaviors: _getChartBehavior(),
      );
    }
  }

  @override
  void initState() {
    if (widget.currentHabit.habit.type == HabitType.yesOrNo) {
      _sortedMeasurableData = {};

      if (widget.currentHabit.habit.daysDoneYesNo.isEmpty) {
        _sortedYesNoData = [];
        _startDate = hiveDateFormat.format(DateTime.now());
        _endDate = hiveDateFormat.format(DateTime.now());
      } else {
        _sortedYesNoData = widget.currentHabit.habit.daysDoneYesNo..sort((a, b) => a.compareTo(b));
        _startDate = _sortedYesNoData.first;
        _endDate = _sortedYesNoData.last;
      }
    } else {
      _sortedYesNoData = [];
      _sortedMeasurableData = SplayTreeMap<String, int>
        .from(widget.currentHabit.habit.daysDoneMeasurable,
        (a, b) => a.compareTo(b));
      _startDate = _sortedMeasurableData.keys.first;
      _endDate = _sortedMeasurableData.keys.last;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentHabit.habit.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(
              context,
              UpdateHabitPage.route,
              arguments: widget.currentHabit,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habit type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.currentHabit.habit.type == HabitType.yesOrNo ? 'Yes or No' : 'Measurable'),
            const SizedBox(height: 12),
            const Text(
              'Habit name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.currentHabit.habit.name),
            const SizedBox(height: 12),
            const Text(
              'Habit description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.currentHabit.habit.goal),
            const SizedBox(height: 12),
            ..._getMeasurableDone(),
            const Text(
              'Your habit result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
              child: _renderChart(),
            ),
          ],
        ),
      ),
    );
  }
}
