import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'diary_dashboard_screen.dart';

class CauseListScreen extends StatefulWidget {
  final String advocateName;

  const CauseListScreen({super.key, required this.advocateName});

  @override
  State<CauseListScreen> createState() => _CauseListScreenState();
}

class _CauseListScreenState extends State<CauseListScreen> {
  String? selectedState;
  String? selectedDistrict;
  String? selectedCourtComplex;
  String? selectedCourtName;
  DateTime? selectedDate;
  String selectedCaseType = "Civil";

  List<Map<String, dynamic>> causeList = [];
  List<Map<String, dynamic>> myCases = [];

  // Dummy Dropdown Options
  final List<String> states = ["Delhi", "Maharashtra", "Uttar Pradesh"];
  final Map<String, List<String>> districts = {
    "Delhi": ["South West", "North", "East"],
    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
    "Uttar Pradesh": ["Lucknow", "Noida", "Varanasi"],
  };

  final Map<String, List<String>> courtComplexes = {
    "South West": ["Dwarka Courts", "Patiala House"],
    "North": ["Rohini Courts"],
    "East": ["Karkardooma Courts"],
    "Mumbai": ["City Civil Court", "Sessions Court"],
    "Pune": ["Shivajinagar Courts"],
  };

  final Map<String, List<String>> courtNames = {
    "Dwarka Courts": ["Judge A - Court 101", "Judge B - Court 102"],
    "Patiala House": ["Judge C - Court 201"],
    "Rohini Courts": ["Judge D - Court 301"],
    "City Civil Court": ["Judge E - Court 401"],
  };

  // ✅ Dummy Data for Cause List Table (DateTime instead of String)
  final List<Map<String, dynamic>> dummyCauseList = [
    {
      "caseNumber": "CS/123/2025",
      "partyName": "Ramesh vs Suresh",
      "advocate": "Adv. Mayank Bhardwaj",
      "courtName": "Judge A - Court 101",
      "hearingDate": DateTime(2025, 8, 28),
      "stage": "Final Arguments",
    },
    {
      "caseNumber": "CR/456/2025",
      "partyName": "State vs Rohan",
      "advocate": "Adv. Mehta",
      "courtName": "Judge B - Court 102",
      "hearingDate": DateTime(2025, 8, 28),
      "stage": "Cross Examination",
    },
    {
      "caseNumber": "CS/789/2025",
      "partyName": "Anita vs Raj",
      "advocate": "Adv. Verma",
      "courtName": "Judge C - Court 201",
      "hearingDate": DateTime(2025, 8, 28),
      "stage": "Evidence",
    },
  ];

  void fetchCauseList() {
    setState(() {
      causeList = dummyCauseList
          .where(
            (caseItem) => caseItem["courtName"].toString().contains(
              selectedCourtName ?? "",
            ),
          )
          .toList();

      // ✅ Get advocate's own cases
      myCases = causeList
          .where(
            (caseItem) =>
                caseItem["advocate"].toString().toLowerCase() ==
                widget.advocateName.toLowerCase(),
          )
          .toList();
    });
  }

  void addToDiary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryDashboardScreen(myCases: myCases),
      ),
    );
  }

  // ✅ Date Picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cause List")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FILTERS SECTION
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Select State"),
              items: states
                  .map(
                    (state) =>
                        DropdownMenuItem(value: state, child: Text(state)),
                  )
                  .toList(),
              value: selectedState,
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedDistrict = null;
                  selectedCourtComplex = null;
                  selectedCourtName = null;
                });
              },
            ),
            const SizedBox(height: 10),
            if (selectedState != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select District"),
                items: districts[selectedState]!
                    .map(
                      (district) => DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      ),
                    )
                    .toList(),
                value: selectedDistrict,
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value;
                    selectedCourtComplex = null;
                    selectedCourtName = null;
                  });
                },
              ),
            const SizedBox(height: 10),
            if (selectedDistrict != null &&
                courtComplexes.containsKey(selectedDistrict))
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Court Complex",
                ),
                items: courtComplexes[selectedDistrict]!
                    .map(
                      (complex) => DropdownMenuItem(
                        value: complex,
                        child: Text(complex),
                      ),
                    )
                    .toList(),
                value: selectedCourtComplex,
                onChanged: (value) {
                  setState(() {
                    selectedCourtComplex = value;
                    selectedCourtName = null;
                  });
                },
              ),
            const SizedBox(height: 10),
            if (selectedCourtComplex != null &&
                courtNames.containsKey(selectedCourtComplex))
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Court Name",
                ),
                items: courtNames[selectedCourtComplex]!
                    .map(
                      (court) =>
                          DropdownMenuItem(value: court, child: Text(court)),
                    )
                    .toList(),
                value: selectedCourtName,
                onChanged: (value) {
                  setState(() => selectedCourtName = value);
                },
              ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => selectDate(context),
              icon: const Icon(Icons.date_range),
              label: Text(
                selectedDate == null
                    ? "Select Date"
                    : DateFormat("dd MMM yyyy").format(selectedDate!),
              ),
            ),
            const SizedBox(height: 10),

            // Civil/Criminal Toggle
            ToggleButtons(
              isSelected: [
                selectedCaseType == "Civil",
                selectedCaseType == "Criminal",
                selectedCaseType == "Other",
              ],
              onPressed: (index) {
                setState(() {
                  selectedCaseType = ["Civil", "Criminal", "Other"][index];
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Civil"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Criminal"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Other"),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // FETCH BUTTON
            ElevatedButton(
              onPressed: fetchCauseList,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text("Fetch Cause List"),
            ),
            const SizedBox(height: 15),

            // TABLE VIEW
            if (causeList.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateColor.resolveWith(
                    (_) => Colors.blue.shade100,
                  ),
                  columns: const [
                    DataColumn(label: Text("Case No.")),
                    DataColumn(label: Text("Party Name")),
                    DataColumn(label: Text("Advocate")),
                    DataColumn(label: Text("Court Name")),
                    DataColumn(label: Text("Hearing Date")),
                    DataColumn(label: Text("Stage")),
                  ],
                  rows: causeList.map((caseItem) {
                    final isMyCase =
                        caseItem["advocate"].toString().toLowerCase() ==
                        widget.advocateName.toLowerCase();
                    return DataRow(
                      color: WidgetStateProperty.resolveWith(
                        (_) => isMyCase ? Colors.green.shade100 : Colors.white,
                      ),
                      cells: [
                        DataCell(Text(caseItem["caseNumber"])),
                        DataCell(Text(caseItem["partyName"])),
                        DataCell(Text(caseItem["advocate"])),
                        DataCell(Text(caseItem["courtName"])),
                        DataCell(
                          Text(
                            DateFormat(
                              "dd MMM yyyy",
                            ).format(caseItem["hearingDate"]),
                          ),
                        ),
                        DataCell(Text(caseItem["stage"])),
                      ],
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 20),

            // MAINTAIN DIARY BUTTON ✅ FIXED
            if (myCases.isNotEmpty)
              ElevatedButton.icon(
                onPressed: addToDiary,
                icon: const Icon(Icons.book),
                label: const Text("Maintain Diary"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
