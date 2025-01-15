import 'package:flutter/material.dart';

import 'jigsaw_piece.dart';

class ImageAmountTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String url;
  final int amount;
  final double scale;

  const ImageAmountTable({
    required this.data,
    required this.url,
    required this.amount,
    required this.scale, // A list of maps with 'imageUrl' and 'amount' keys
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        border: TableBorder.all(color: Colors.grey), // Optional: Add a border
        columnWidths: const {
          0: FixedColumnWidth(100), // Set fixed width for the image column
          1: FlexColumnWidth(), // Amount column takes the remaining space
        },
        children: [
          // Table Header
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[200]),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Table Rows (from data)
          ...data.map((item) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: JigsawPiece(
                    imageUrl: '',
                    index: data.indexOf(item),
                    totalPieces: amount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${item['amount'].toString()}', // Format the amount
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
