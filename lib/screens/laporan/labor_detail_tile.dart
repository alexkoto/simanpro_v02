import 'package:flutter/material.dart';

class LaborDetailTile extends StatelessWidget {
  final Map<String, dynamic> labor;

  const LaborDetailTile({super.key, required this.labor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.person),
      title: Text(labor['name']),
      subtitle: Text('${labor['task']} (${labor['qty']})'),
    );
  }
}
