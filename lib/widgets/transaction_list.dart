import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      
        child: transactions.isEmpty 
        ? Column(
          children:<Widget> [
          Text(
            "No Transaction added yet!", 
            style:Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          
        ],) : ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
                ),
              child: ListTile(
                leading: CircleAvatar(
                 radius: 30,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                 DateFormat.yMMMd().format( transactions[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => deleteTx(transactions[index].id),
                  ),
              ),
            );

           },
          itemCount: transactions.length,
          // children: transactions.map((tx){
                
          //     }).toList(),
              ),
      );

          
          } 

    }