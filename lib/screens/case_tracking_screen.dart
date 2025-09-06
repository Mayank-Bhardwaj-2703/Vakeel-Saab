import 'package:flutter/material.dart';
import '../widgets/app_footer.dart';

class CaseTrackingScreen extends StatefulWidget {
  const CaseTrackingScreen({super.key});

  @override
  State<CaseTrackingScreen> createState() => _CaseTrackingScreenState();
}

class _CaseTrackingScreenState extends State<CaseTrackingScreen> {
  // Search methods
  final List<String> searchMethods = [
    'CNR Number',
    'Case Number',
    'Party Name',
    'Filing Number',
    'FIR Number',
    'Advocate Name',
  ];
  String selectedMethod = 'CNR Number';

  // Dropdowns
  final List<String> caseTypes = ['Civil', 'Criminal'];
  String selectedCaseType = 'Civil';

  final List<String> policeStations = [
    'Station A',
    'Station B',
    'Station C',
    'Station D',
  ];
  String selectedPoliceStation = 'Station A';

  // Input Controllers
  final cnrController = TextEditingController();
  final caseNumberController = TextEditingController();
  final caseYearController = TextEditingController();
  final partyNameController = TextEditingController();
  final filingNumberController = TextEditingController();
  final firNumberController = TextEditingController();
  final advocateNameController = TextEditingController();

  // Cases list
  List<Map<String, String>> myCases = [];
  Map<String, String>? searchResult;

  // Status color helper
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "disposed":
        return Colors.green;
      case "approved":
        return Colors.blue;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _statusBadge(String status) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: _getStatusColor(status).withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _getStatusColor(status), width: 1),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: _getStatusColor(status),
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Generate dummy data
  Map<String, String> _generateDummyCase(String id) => {
    'caseNo': id.toUpperCase(),
    'caseType': selectedCaseType,
    'status': 'Pending',
    'nextDate': '12 Sep 2025',
    'filingNo': 'F1234',
    'courtName': 'District Court A',
    'partyNames': 'John Doe vs ABC Ltd.',
    'advocate': 'Adv. Sharma',
  };

  // Search logic
  void _performSearch() {
    String id = '';
    switch (selectedMethod) {
      case 'CNR Number':
        id = cnrController.text.trim();
        if (id.isEmpty) return;
        break;
      case 'Case Number':
        if (caseNumberController.text.isEmpty ||
            caseYearController.text.isEmpty)
          return;
        id = caseNumberController.text.trim();
        break;
      case 'Party Name':
        if (partyNameController.text.isEmpty || caseYearController.text.isEmpty)
          return;
        id = partyNameController.text.trim();
        break;
      case 'Filing Number':
        if (filingNumberController.text.isEmpty ||
            caseYearController.text.isEmpty)
          return;
        id = filingNumberController.text.trim();
        break;
      case 'FIR Number':
        if (firNumberController.text.isEmpty || caseYearController.text.isEmpty)
          return;
        id = firNumberController.text.trim();
        break;
      case 'Advocate Name':
        if (advocateNameController.text.isEmpty ||
            caseYearController.text.isEmpty)
          return;
        id = advocateNameController.text.trim();
        break;
    }

    // Set dummy result
    setState(() {
      searchResult = _generateDummyCase(id);
    });
  }

  void _addToMyCases() {
    if (searchResult != null) {
      setState(() {
        if (!myCases.any((c) => c['caseNo'] == searchResult!['caseNo'])) {
          myCases.insert(0, Map.of(searchResult!));
        }
        searchResult = null;
      });
    }
  }

  // Build input fields based on method
  Widget _buildInputFields() {
    switch (selectedMethod) {
      case 'CNR Number':
        return TextField(
          controller: cnrController,
          decoration: const InputDecoration(
            labelText: "Enter CNR Number",
            border: OutlineInputBorder(),
          ),
        );
      case 'Case Number':
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCaseType,
              items: caseTypes
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedCaseType = val!),
              decoration: const InputDecoration(
                labelText: "Select Case Type",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseNumberController,
              decoration: const InputDecoration(
                labelText: "Enter Case Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseYearController,
              decoration: const InputDecoration(
                labelText: "Enter Year",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      case 'Party Name':
        return Column(
          children: [
            TextField(
              controller: partyNameController,
              decoration: const InputDecoration(
                labelText: "Enter Party Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseYearController,
              decoration: const InputDecoration(
                labelText: "Enter Year",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      case 'Filing Number':
        return Column(
          children: [
            TextField(
              controller: filingNumberController,
              decoration: const InputDecoration(
                labelText: "Enter Filing Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseYearController,
              decoration: const InputDecoration(
                labelText: "Enter Year",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      case 'FIR Number':
        return Column(
          children: [
            TextField(
              controller: firNumberController,
              decoration: const InputDecoration(
                labelText: "Enter FIR Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPoliceStation,
              items: policeStations
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedPoliceStation = val!),
              decoration: const InputDecoration(
                labelText: "Select Police Station",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseYearController,
              decoration: const InputDecoration(
                labelText: "Enter Year",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      case 'Advocate Name':
        return Column(
          children: [
            TextField(
              controller: advocateNameController,
              decoration: const InputDecoration(
                labelText: "Enter Advocate Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: caseYearController,
              decoration: const InputDecoration(
                labelText: "Enter Year",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    cnrController.dispose();
    caseNumberController.dispose();
    caseYearController.dispose();
    partyNameController.dispose();
    filingNumberController.dispose();
    firNumberController.dispose();
    advocateNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case Tracking"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Search By: "),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedMethod,
                  items: searchMethods
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedMethod = val!;
                    searchResult = null;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildInputFields(),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _performSearch,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Search"),
            ),
            const SizedBox(height: 16),
            if (searchResult != null)
              Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    "Case No: ${searchResult!['caseNo']} (${searchResult!['caseType']})",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Filing No: ${searchResult!['filingNo']}"),
                      Text("Next Hearing: ${searchResult!['nextDate']}"),
                      Text("Court: ${searchResult!['courtName']}"),
                      Text("Parties: ${searchResult!['partyNames']}"),
                      Text("Advocate: ${searchResult!['advocate']}"),
                      const SizedBox(height: 6),
                      _statusBadge(searchResult!['status']!),
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: _addToMyCases,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Cases",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: myCases.isEmpty
                  ? const Center(child: Text("No cases added yet."))
                  : ListView.builder(
                      itemCount: myCases.length,
                      itemBuilder: (context, index) {
                        final caseData = myCases[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              "Case No: ${caseData['caseNo']} (${caseData['caseType']})",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text("Filing No: ${caseData['filingNo']}"),
                                Text("Next Hearing: ${caseData['nextDate']}"),
                                Text("Court: ${caseData['courtName']}"),
                                Text("Parties: ${caseData['partyNames']}"),
                                Text("Advocate: ${caseData['advocate']}"),
                                const SizedBox(height: 6),
                                _statusBadge(caseData['status']!),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
