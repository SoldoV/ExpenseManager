import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 240,
      child: userTransactions.isEmpty
          ? Container(
              child: Text('No transactions',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30)),
              alignment: Alignment.center,
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Chip(
                        avatar: CircleAvatar(
                          child: const Text('\$',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        label: Text(
                            '${userTransactions[i].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userTransactions[i].title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                              DateFormat.yMd().format(userTransactions[i].date),
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      new Spacer(),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(userTransactions[i].id),
                          color: Colors.grey),
                    ],
                  ),
                ));
              },
              itemCount: userTransactions.length,
            ),
    );
  }
}
