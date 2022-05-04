import 'package:flutter/material.dart';
import 'package:flutter_guide/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/tansaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.green,
          fontFamily: 'SourceSansPro',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /*Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, dateTime: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        dateTime: DateTime.now())*/
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days:7),),);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransacation),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _addNewTransacation(String txTitle, double tXamount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: tXamount,
        dateTime: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }
}
