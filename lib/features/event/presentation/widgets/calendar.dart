import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfiniteCalendarScreen extends StatefulWidget {
  @override
  _InfiniteCalendarScreenState createState() => _InfiniteCalendarScreenState();
}

class _InfiniteCalendarScreenState extends State<InfiniteCalendarScreen> {
  final ScrollController _scrollController = ScrollController();
  List<DateTime> _months = [];
  final int _bufferMonths = 2;

  @override
  void initState() {
    super.initState();
    _initializeMonths();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeMonths() {
    final today = DateTime.now();
    setState(() {
      _months = List.generate(_bufferMonths * 2 + 1, (index) {
        return DateTime(today.year, today.month - _bufferMonths + index, 1);
      });
    });
  }

  void _loadPreviousMonths() {
    final firstDate = _months.first;
    setState(() {
      final newMonths = List.generate(_bufferMonths, (index) {
        return DateTime(firstDate.year, firstDate.month - _bufferMonths + index, 1);
      });
      _months.insertAll(0, newMonths);
    });
  }

  void _loadNextMonths() {
    final lastDate = _months.last;
    setState(() {
      final newMonths = List.generate(_bufferMonths, (index) {
        return DateTime(lastDate.year, lastDate.month + index + 1, 1);
      });
      _months.addAll(newMonths);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadNextMonths();
    } else if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      _loadPreviousMonths();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinite Calendar"),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _months.length,
        itemBuilder: (context, index) {
          return CalendarMonthWidget(month: _months[index]);
        },
      ),
    );
  }
}

class CalendarMonthWidget extends StatelessWidget {
  final DateTime month;

  const CalendarMonthWidget({required this.month, super.key});

  @override
  Widget build(BuildContext context) {
    final daysInMonth = List<DateTime>.generate(
      DateTime(month.year, month.month + 1, 0).day,
          (index) => DateTime(month.year, month.month, index + 1),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month and Year Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              DateFormat.yMMMM().format(month), // e.g., "November 2024"
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7 columns for days of the week
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: daysInMonth.length,
            itemBuilder: (context, index) {
              final day = daysInMonth[index];
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue.shade50,
                ),
                child: Text(
                  day.day.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
