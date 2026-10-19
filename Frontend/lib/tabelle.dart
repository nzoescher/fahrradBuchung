import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/tour.dart';
import 'package:http/http.dart' as http;

import 'insideTour.dart';

class Tabelle extends StatefulWidget {

  final String titel;

  const Tabelle({
    super.key,
    required this.titel,
  });

  @override
  State<Tabelle> createState() => _TabelleState();
}

class _TabelleState extends State<Tabelle> {
  final ScrollController _scrollController = ScrollController();

  List<Tour> _touren = [];
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List<bool>.generate(_touren.length, (int index) => false);
    fetchTours();
  }

  Future<void> fetchTours() async {
    bool _isLoading = true;
    final response = await http.get(Uri.parse("http://127.0.0.1:8000/"));
    if (response.statusCode == 200) {
        List<dynamic> data =  jsonDecode(response.body);
        setState(() {
          _touren = data.map((item) => Tour.fromJson(item)).toList();
          selected = List<bool>.generate(_touren.length, (_) => false);
          _isLoading = false;
        });

    } else {
      throw Exception("Failed to load greeting");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _doubleTapEvent(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TourScreen(tour: _touren[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_bike_rounded,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.titel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${_touren.length} active",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    showCheckboxColumn: false,
                    horizontalMargin: 20,
                    columnSpacing: 24,
                    dataRowMinHeight: 48,
                    dataRowMaxHeight: 48,
                    headingRowColor: WidgetStateProperty.all(
                      const Color(0xFFF9FAFB),
                    ),
                    headingTextStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey[700],
                      letterSpacing: 0.5,
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text("TOUR")),
                      DataColumn(label: Text("START")),
                      DataColumn(label: Text("ENDE")),
                      DataColumn(label: Text("AKTION")),
                    ],
                    rows: List<DataRow>.generate(
                      _touren.length,
                          (int index) => DataRow(
                        selected: selected[index],
                        onSelectChanged: (bool? value) {
                          setState(() {
                            selected[index] = value ?? false;
                          });
                        },
                        color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.green.withValues(alpha: 0.15);
                          }
                          if (index.isEven) {
                            return Colors.grey.withValues(alpha: 0.1);
                          }
                          return null;
                        }),
                        cells: [
                          DataCell(
                            onDoubleTap: () => _doubleTapEvent(index),
                            Text(
                              _touren[index].tourname,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const DataCell(Text("10:00 Uhr")),
                          const DataCell(Text("14:30 Uhr")),
                          DataCell(
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                              tooltip: 'Tour entfernen',
                              onPressed: () => _showDeleteDialog(context, index)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            // Zwingt den Dialog auf eine typische Desktop-Breite
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header mit Warn-Icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red.shade700,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Tour entfernen',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Fließtext
                  Text.rich(
                    TextSpan(
                      text: 'Möchtest du die Tour ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade700,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: '"${_touren[index]}"',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const TextSpan(
                          text: ' wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Button-Leiste (Desktop-typisch rechtsbündig)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blueGrey.shade800,
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Abbrechen'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          final Tour tourToDelete = _touren[index];
                          if (tourToDelete.id != null) {
                            tourToDelete.removeTour(tourToDelete.id!);
                          } else {
                            print("Tour hat keine gültige ID!");
                          }
                          Navigator.of(ctx).pop();
                          setState(() {
                            _touren.removeAt(index);
                            selected.removeAt(index);
                          });
                        },
                        child: const Text('Löschen'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}