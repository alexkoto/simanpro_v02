import 'package:flutter/material.dart';

class InvoiceForm extends StatelessWidget {
  final TextEditingController invoiceNumberController;
  final TextEditingController clientController;
  final TextEditingController dateController;
  final TextEditingController dueDateController;
  final VoidCallback onAddItem;
  final List<Map<String, dynamic>> items;
  final VoidCallback onSubmit;

  const InvoiceForm({
    super.key,
    required this.invoiceNumberController,
    required this.clientController,
    required this.dateController,
    required this.dueDateController,
    required this.onAddItem,
    required this.items,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Invoice'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: invoiceNumberController,
              decoration: const InputDecoration(labelText: 'Invoice Number'),
            ),
            TextField(
              controller: clientController,
              decoration: const InputDecoration(labelText: 'Client'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
            ),
            TextField(
              controller: dueDateController,
              decoration: const InputDecoration(
                labelText: 'Due Date (YYYY-MM-DD)',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: onAddItem,
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
            ),
            ...items.map(
              (item) => ListTile(
                title: Text(item['description']),
                subtitle: Text(
                  'Qty: ${item['quantity']}, Price: ${item['unit_price']}',
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: onSubmit, child: const Text('Add')),
      ],
    );
  }
}
