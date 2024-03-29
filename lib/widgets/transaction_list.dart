import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Card(
           
        child: transactions.isEmpty 
        ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
          children:<Widget> [
          Text(
            "No Transaction added yet!", 
            style:Theme.of(context).textTheme.titleLarge
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          
        ],
        );
        }) 
        
         : ListView.builder(
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
                trailing: MediaQuery.of(context).size.width > 360
                ? TextButton.icon(
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: const Text("Delete",style: TextStyle(
                          color: Colors.red,//for text color
    ),),
                                                    
                  onPressed: () => deleteTx(transactions[index].id),
                  )
                : IconButton(
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