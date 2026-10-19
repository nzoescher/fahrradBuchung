import 'package:flutter/material.dart';

class Forminput extends StatelessWidget {
  final String label;
  final String hintLabel;
  final TextEditingController controller;
  final bool isDate;
  final bool isTime;

  const Forminput({
    super.key,
    required this.label,
    required this.hintLabel,
    required this.controller,
    required this.isDate,
    required this.isTime,
  });


  Future<DateTime?> _openDatePicker(BuildContext context) async{
    final DateTime? date= await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2026,01,01),
    lastDate: DateTime(2050,12,31)
    );
    return date;
  }

  Future<TimeOfDay?> _openTimePicker (BuildContext context) async{
    final TimeOfDay? time= await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
       },
    );
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        if (isDate) {
          final DateTime? date = await _openDatePicker(context);
            if (date != null) {
              String time = date.toIso8601String().split("T")[0];
              controller.text = time;
            }
        }
        if (isTime) {
          final TimeOfDay? time = await _openTimePicker(context);
          if (time != null) {
            final hour = time.hour.toString().padLeft(2, '0');
            final minute = time.minute.toString().padLeft(2, '0');
            controller.text = "$hour:$minute";
          }
        }
      },
      controller: controller,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.2,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.orange.shade900,
        ),
        hintText: hintLabel,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.directions_bike_rounded,
          color: Colors.orange.shade800,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // Standard-Zustand auf orangem Grund
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.orange.shade200,
            width: 1.5,
          ),
        ),
        // Fokus-Zustand: Dunkleres Orange als Kontrast
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.orange.shade900,
            width: 2,
          ),
        ),
        // Fehler-Zustand
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}