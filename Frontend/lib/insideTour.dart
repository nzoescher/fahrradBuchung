import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/tabelle.dart';
import 'package:frontend/tour.dart';
import 'addDialog.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key, required Tour tour});

  @override
  State<TourScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TourScreen> {
  int _reloadCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Tabelle(
                  key: ValueKey(_reloadCounter),
                  titel: "Added Bikes",
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? tourAdded = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => const Adddialog(),
          );

          if (tourAdded == true) {
            setState(() => _reloadCounter++); // Tabelle neu laden
          }
        },
        tooltip: "Add Bike",
        child: const Icon(Icons.add),
      ),
    );
  }
}