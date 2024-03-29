import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(){

    if (_amountController.text.isEmpty){
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 || _selectedDate == null ) {
      return;
    }

     widget.addTx( 
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );

      Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      ).then((pickDate) {
        if(pickDate == null){
          return;
        }

        setState(() {
          _selectedDate = pickDate;
        });

      });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: 
                      InputDecoration(
                        labelText: "Title"),
                        controller: _titleController,
                        onSubmitted: (_) => _submitData(),
                        // onChanged: (val) {
                        //   titleInput = val;
                        // },
                        ),
                    TextField(
                      decoration: 
                      InputDecoration(
                        labelText: "Amount"),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _submitData(),
                        // onChanged: (val) => amountInput = val,
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _selectedDate == null ?
                               "No Date Chosen" 
                               : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                              ),
                          ),
                          TextButton(
                            child: Text("Chose Date"),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                               TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                               ),
                              ),
                            ),
                                                     
                            onPressed: _presentDatePicker,
                             ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Add Transaction'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white),
                      ),
                      onPressed: _submitData,),
              
                  ],
                ),
              ),
              ),
    );
  }
}