import 'package:flutter/material.dart';

class CaseTrackingScreen extends StatefulWidget {
  const CaseTrackingScreen({super.key});

  @override
  State<CaseTrackingScreen> createState() => _CaseTrackingScreenState();
}

class _CaseTrackingScreenState extends State<CaseTrackingScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy list of "My Cases"
  List<Map<String, String>> myCases = [
    {"caseNo": "CNR12345", "status": "Pending", "nextDate": "12 Sep 2025"},
    {"caseNo": "CNR67890", "status": "Disposed", "nextDate": "N/A"},
    {"caseNo": "CNR54321", "status": "Approved", "nextDate": "20 Sep 2025"},
  ];

  // Dummy search result
  Map<String, String>? _searchResult;

  // Simulate case search
  void _performSearch(String query) {
    if (query.isEmpty) return;
    setState(() {
      _searchResult = {
        "caseNo": query.toUpperCase(),
        "status": "Pending",
        "nextDate": "15 Sep 2025",
      };
    });
  }

  // Add searched case into My Cases
  void _addToMyCases() {
    if (_searchResult != null) {
      setState(() {
        bool exists = myCases.any(
          (c) => c["caseNo"] == _searchResult!["caseNo"],
        );
        if (!exists) {
          myCases.insert(0, Map.from(_searchResult!));
        }
        _searchResult = null; // Clear search
        _searchController.clear();
      });
    }
  }

  // Get color for status badges
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

  // Create badge widget for status
  Widget _statusBadge(String status) {
    return Container(
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case Tracking"),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search panel
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Enter CNR / Case Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onSubmitted: _performSearch,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _performSearch(_searchController.text),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Search"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Show search result if available
            if (_searchResult != null) ...[
              Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    "Case No: ${_searchResult!['caseNo']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Next Hearing: ${_searchResult!['nextDate']}"),
                      const SizedBox(height: 6),
                      _statusBadge(_searchResult!['status']!),
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
            ],

            // Heading for My Cases
            Text(
              "My Cases",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 8),

            // My Cases list
            Expanded(
              child: myCases.isEmpty
                  ? const Center(
                      child: Text(
                        "No cases added yet.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
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
                              "Case No: ${caseData['caseNo']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text("Next Hearing: ${caseData['nextDate']}"),
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
    );
  }
}
