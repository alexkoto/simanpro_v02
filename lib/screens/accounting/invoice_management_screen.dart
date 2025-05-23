import 'package:flutter/material.dart';
import 'invoice_card.dart';
import 'invoice_form.dart';
import 'invoice_detail_dialog.dart';

class InvoiceManagementScreen extends StatefulWidget {
  const InvoiceManagementScreen({super.key});

  @override
  State<InvoiceManagementScreen> createState() =>
      _InvoiceManagementScreenState();
}

class _InvoiceManagementScreenState extends State<InvoiceManagementScreen> {
  final List<Map<String, dynamic>> _invoices = [];
  final TextEditingController _invoiceNumberController =
      TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  List<Map<String, dynamic>> _items = [];

  void _showAddInvoiceDialog() {
    _invoiceNumberController.clear();
    _clientController.clear();
    _dateController.clear();
    _dueDateController.clear();
    _items = [];

    showDialog(
      context: context,
      builder:
          (_) => InvoiceForm(
            invoiceNumberController: _invoiceNumberController,
            clientController: _clientController,
            dateController: _dateController,
            dueDateController: _dueDateController,
            items: _items,
            onAddItem: _addItemDialog,
            onSubmit: _addInvoice,
          ),
    );
  }

  void _addItemDialog() {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController unitPriceController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: unitPriceController,
                  decoration: const InputDecoration(labelText: 'Unit Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _items.add({
                      'description': descriptionController.text,
                      'quantity': int.tryParse(quantityController.text) ?? 0,
                      'unit_price':
                          double.tryParse(unitPriceController.text) ?? 0.0,
                    });
                  });
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _addInvoice() {
    setState(() {
      _invoices.add({
        'invoice_number': _invoiceNumberController.text,
        'client': _clientController.text,
        'date': _dateController.text,
        'due_date': _dueDateController.text,
        'items': List<Map<String, dynamic>>.from(_items),
        'status': 'Pending',
      });
    });
    Navigator.pop(context);
  }

  void _markInvoiceAsPaid(String invoiceNumber) {
    setState(() {
      final index = _invoices.indexWhere(
        (inv) => inv['invoice_number'] == invoiceNumber,
      );
      if (index != -1) {
        _invoices[index]['status'] = 'Paid';
      }
    });
  }

  void _showInvoiceDetail(Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder:
          (_) => InvoiceDetailDialog(
            invoice: invoice,
            onMarkAsPaid: () => _markInvoiceAsPaid(invoice['invoice_number']),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice Management')),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return InvoiceCard(
            invoice: invoice,
            onTap: () => _showInvoiceDetail(invoice),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddInvoiceDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
