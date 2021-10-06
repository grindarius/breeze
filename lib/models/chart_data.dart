/// Model class for formatting data for the graph.
/// 
/// If it's Yes or No graph, finished value could only be 0 and 1.
/// 
/// If it's measurable chart, finished value could be anything greater than 0.
class ChartData {
  final DateTime date;
  final int finished;

  ChartData(this.date, this.finished);
}
