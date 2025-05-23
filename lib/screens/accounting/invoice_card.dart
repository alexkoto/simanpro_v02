import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  final Map<String, dynamic> invoice;
  final Function() onTap;

  const InvoiceCard({super.key, required this.invoice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    double total = (invoice['items'] as List<dynamic>)
        .fold(0.0, (sum, item) => sum + (item['quantity'] * item['unit_price']));

    return Card(
      child: ListTile(
        title: Text('Invoice: ${invoice['invoice_number']}'),
        subtitle: Text('Client: ${invoice['client']}\nTotal: ${currencyFormat.format(total)}'),
        trailing: Chip(
          label: Text(invoice['status']),
          backgroundColor: invoice['status'] == 'Paid'
              ? Colors.green[100]
              : invoice['status'] == 'Pending'
                  ? Colors.orange[100]
                  : Colors.red[100],
        ),
        onTap: onTap,
      ),
    );
  }
}
