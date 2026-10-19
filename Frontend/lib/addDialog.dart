import 'package:flutter/material.dart';
import 'package:frontend/FormInput.dart';
import 'package:frontend/tour.dart';

class Adddialog extends StatefulWidget {
  const Adddialog({super.key});

  @override
  State<Adddialog> createState() => _AdddialogState();
}

  class _AdddialogState extends State<Adddialog> {
    final TextEditingController _tournameController = TextEditingController();
    final TextEditingController _startTimeController = TextEditingController();
    final TextEditingController _endTimeController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();

    @override
    void dispose() {
      _dateController.dispose();
      _tournameController.dispose();
      _startTimeController.dispose();
      _endTimeController.dispose();
      super.dispose();
    }

    Future<void> _saveTour() async{

      final String tourname = _tournameController.text.trim();
      final String starttime = _startTimeController.text.trim();
      final String endtime= _endTimeController.text.trim();
      final String date = _dateController.text.trim();

      String ganzesStartDatum = date + "T" +starttime;
      DateTime parsedStartDatum = DateTime.parse(ganzesStartDatum);

      String ganzesEndDatum = date +"T" + endtime;
      DateTime parsedEndDatum = DateTime.parse(ganzesEndDatum);

      Tour tour = new Tour(tourname: tourname, startTime: parsedStartDatum, endTime: parsedEndDatum);
      await tour.createTour(tour);
    }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
            width: 600,
            height: 500,
      child :Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        leading: const Icon(Icons.add_road, color: Colors.white),
        title: const Text(
          "Add Tour",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          heightFactor: 0.85,
          child: Card(
            elevation: 3,
            shadowColor: Colors.orange.withOpacity(0.2),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: Colors.orange.shade100,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Forminput(
                              controller: _tournameController,
                              label: "Tourname",
                              hintLabel: "eg Alpine-Tour",
                              isDate: false,
                              isTime: false,
                            ),
                             Forminput(
                              controller: _startTimeController,
                              label: 'Starting Time',
                              hintLabel: "HH:MM",
                               isDate: false,
                               isTime: true,
                            ),
                             Forminput(
                               controller: _endTimeController,
                              label: 'Ending Time',
                              hintLabel: "HH:MM",
                               isDate: false,
                               isTime: true,
                            ),
                             Forminput(
                              controller: _dateController,
                              label: 'Date',
                              hintLabel: "DD/MM/YYYY",
                               isDate: true,
                               isTime: false,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Sekundärer Button: Abbrechen
                                OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey.shade700,
                                    side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                ElevatedButton(
                                  onPressed: () async {
                                    await _saveTour();

                                    if (context.mounted) {
                                      Navigator.of(context).pop(true);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade700,
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shadowColor: Colors.orange.withOpacity(0.4),
                                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Add Tour",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      ),
        ),
    );
  }
}