// HistoryPage.dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// MyApp widget, which is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HistoryScreen(),
    );
  }
}

// History data model
class History {
  String date;
  String translator;
  bool isSelected = false; // To keep track of selection status
  bool isExpanded = false; // To keep track of expansion status

  History({
    required this.date,
    required this.translator,
  });
}

// HistoryScreen StatefulWidget
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<History> histories = [
    History(date: '2024.03.30 22:30', translator: 'Хулгана'),
    History(date: '2024.03.30 19:20', translator: 'Лууван'),
    History(date: '2024.03.30 19:10', translator: 'Муур'),
  ];
  List<History> filteredHistories = [];
  bool isDeleteMode = false;

  @override
  void initState() {
    super.initState();
    filteredHistories = histories;
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      filteredHistories = histories
          .where((history) =>
              history.translator.toLowerCase().contains(newQuery.toLowerCase()) ||
              history.date.contains(newQuery))
          .toList();
    });
  }

  void deleteHistory(History historyToDelete) {
    setState(() {
      histories.removeWhere((history) => history == historyToDelete);
      // Also, filter the deleted history out of the filteredHistories list
      filteredHistories.removeWhere((history) => history == historyToDelete);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('History deleted.')),
    );
  }

  void deleteSelectedHistories() {
    // Collect selected history items
    final selectedHistories = histories.where((history) => history.isSelected).toList();
    // Remove selected history items from both histories and filteredHistories
    setState(() {
      histories.removeWhere((history) => history.isSelected);
      filteredHistories.removeWhere((history) => history.isSelected);
      isDeleteMode = false; // Exit delete mode after deletion
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected histories deleted.')),
    );
  }

  void toggleDeleteMode() {
    setState(() {
      isDeleteMode = !isDeleteMode;
      // Reset selection status of all histories when entering delete mode
      histories.forEach((history) {
        history.isSelected = false;
      });
    });
  }

  void toggleCardExpansion(History history) {
    setState(() {
      history.isExpanded = !history.isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // Extend body behind the app bar
      appBar: isDeleteMode
          ? AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: deleteSelectedHistories,
                ),
              ],
            )
          : null, // Set app bar to null if not in delete mode
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/white_dragon.png',
                    width: 140,
                    height: 130,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'ӨМНӨХ ТҮҮХҮҮД',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF053140),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: updateSearchQuery,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: toggleDeleteMode,
                    child: Text(isDeleteMode ? 'Cancel' : 'Delete'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHistories.length,
                // Inside your ListView.builder:
                itemBuilder: (context, index) {
                  final history = filteredHistories[index];
                  return HistoryCard(
                    history: history,
                    isDeleteMode: isDeleteMode,
                    onExpandToggle: () => toggleCardExpansion(history),
                    onSelected: () {
                      setState(() {
                        history.isSelected = !history.isSelected;
                      });
                    },
                    onDelete: () => deleteHistory(history),
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

// HistoryCard StatefulWidget
class HistoryCard extends StatefulWidget {
  final History history;
  final bool isDeleteMode;
  final VoidCallback onExpandToggle;
  final VoidCallback onSelected;
  final VoidCallback onDelete;

  const HistoryCard({
    Key? key,
    required this.history,
    required this.isDeleteMode,
    required this.onExpandToggle,
    required this.onSelected,
    required this.onDelete,
  }) : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.history.isExpanded ? Color(0xFFFBCF0A) : Color(0xFF00C7C8);
    final textColor = widget.history.isExpanded ? Color(0xFF053140) : Color(0xFF053140);
    final cancelButtonColor = widget.history.isExpanded ? Color(0xFF00C7C8) : Color(0xFFFBCF0A);

    return GestureDetector(
      onTap: () {
        if (!widget.isDeleteMode) {
          widget.onExpandToggle();
        } else {
          widget.onSelected();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.isDeleteMode)
                  Checkbox(
                    value: widget.history.isSelected,
                    onChanged: (_) {
                      widget.onSelected();
                    },
                  ),
                  if (widget.isDeleteMode)
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
              ],
            ),
            if (widget.history.isExpanded && !widget.isDeleteMode)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: cancelButtonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Хөрвүүлэг: ${widget.history.translator}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: textColor),
                        onPressed: widget.onExpandToggle,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/result.png',
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.6,
                  ),
                ],
              ),
            if (!widget.history.isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/result.png',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.history.date,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: cancelButtonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Хөрвүүлэг: ${widget.history.translator}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
