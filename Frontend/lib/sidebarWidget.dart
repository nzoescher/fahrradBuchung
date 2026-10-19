import 'package:flutter/material.dart';

class Sidebarwidget extends StatelessWidget {
  const Sidebarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo-Kachel mit abgerundeten Ecken & leichtem Schatten
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FractionallySizedBox(
              widthFactor: 0.55,
              child: Image.asset(
                'pictures/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Titel mit Akzent & sauberer Typografie
          Text(
            'Bike Booking',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Colors.blueGrey[900],
            ),
          ),

          // Subline / Badge-Look
          Text(
            'MANAGER',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: primaryColor,
            ),
          ),

          const SizedBox(height: 20),
          
          Divider(
            color: Colors.grey.withValues(alpha: 0.2),
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
        ],
      ),
    );
  }
}