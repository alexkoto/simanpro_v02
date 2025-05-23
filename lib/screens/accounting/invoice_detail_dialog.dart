import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceDetailDialog extends StatelessWidget {
  final Map<String, dynamic> invoice;
  final Function() onMarkAsPaid;

  const InvoiceDetailDialog({
    super.key,
    required this.invoice,
    required this.onMarkAsPaid,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
    );
    double total = (invoice['items'] as List<dynamic>).fold(
      0.0,
      (sum, item) => sum + (item['quantity'] * item['unit_price']),
    );

    return AlertDialog(
      title: Text('Invoice ${invoice['invoice_number']}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client: ${invoice['client']}'),
          Text('Date: ${invoice['date']}'),
          Text('Due Date: ${invoice['due_date']}'),
          const SizedBox(height: 10),
          const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...invoice['items'].map<Widget>((item) {
            return ListTile(
              title: Text(item['description']),
              subtitle: Text(
                'Qty: ${item['quantity']} x ${currencyFormat.format(item['unit_price'])}',
              ),
            );
          }).toList(),
          const Divider(),
          Text(
            'Total: ${currencyFormat.format(total)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (invoice['status'] != 'Paid')
          ElevatedButton(
            onPressed: () {
              onMarkAsPaid();
              Navigator.pop(context);
            },
            child: const Text('MARK AS PAID'),
          ),
      ],
    );
  }
}
