import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:breeze/constants/colors.dart';
import 'package:breeze/models/chart_data.dart';

class HabitResultChart extends StatelessWidget {
  const HabitResultChart({ Key? key, required this.series, required this.animate, required this.behaviors }) : super(key: key);

  final List<charts.Series<ChartData, DateTime>> series;
  final List<charts.ChartBehavior<DateTime>> behaviors;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      series,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(includePoints: true),
      behaviors: behaviors,
      customSeriesRenderers: [
        charts.PointRendererConfig(
          customRendererId: 'customPoint',
        )
      ],
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(babyPowderWhite),
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(babyPowderWhite),
          ),
        ),
      ),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
