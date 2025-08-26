import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryDashboardScreen extends StatefulWidget {
  final List<Map<String, dynamic>> myCases; // Comes from cause list

  const DiaryDashboardScreen({super.key, required this.myCases});

  @override
  State<DiaryDashboardScreen> createState() => _DiaryDashboardScreenState();
}

class _DiaryDashboardScreenState extends State<DiaryDashboardScreen> {
  late Map<DateTime, List<Map<String, dynamic>>> events;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    events = {};

    // Load advocate's own case events from cause list
    for (var caseData in widget.myCases) {
      final dateParts = caseData["hearingDate"].split("-");
      final date = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
      );

      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add(caseData);
    }
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addManualNote(String note) {
    final dateKey = DateTime(
      selectedDay!.year,
      selectedDay!.month,
      selectedDay!.day,
    );

    if (events[dateKey] == null) {
      events[dateKey] = [];
    }

    events[dateKey]!.add({
      "type": "note",
      "note": note,
      "hearingDate": "${dateKey.day}-${dateKey.month}-${dateKey.year}",
    });

    setState(() {});
    _noteController.clear();
  }

  void _showAddNoteDialog() {
    if (selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date first!")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Diary Note"),
          content: TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              hintText: "Enter your note here...",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addManualNote(_noteController.text);
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventTile(Map<String, dynamic> event) {
    if (event.containsKey("note")) {
      // Manual note added by advocate
      return ListTile(
        leading: const Icon(Icons.note_alt, color: Colors.blue),
        title: Text(event["note"]),
        subtitle: Text("Personal Note"),
      );
    } else {
      // Case data from cause list
      return ListTile(
        leading: const Icon(Icons.gavel, color: Colors.deepPurple),
        title: Text(event["partyName"]),
        subtitle: Text("${event["caseNumber"]} • ${event["courtName"]}"),
        trailing: Text(event["hearingDate"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dayEvents = _getEventsForDay(selectedDay ?? DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddNoteDialog,
            tooltip: "Add Manual Note",
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });
            },
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: dayEvents.isEmpty
                ? const Center(
                    child: Text(
                      "No events or notes for this day.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: dayEvents.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: _buildEventTile(dayEvents[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
