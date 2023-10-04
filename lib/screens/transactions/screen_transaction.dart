import 'package:financia/db/transaction_db.dart';
import 'package:financia/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.Refresh(); // Use lowercase 'refresh' instead of 'Refresh'

    // Replace these values with your actual total income and total expense


    return Column(
      children: [
        // Carousel-like credit card for total income and total expense
        ValueListenableBuilder(valueListenable: TransactionDB.instance.totalListNotifier, 
        builder: (BuildContext ctx, List<double> totallist, Widget? _)
        {
    
          return CreditCardCarousel(
          totalIncome: totallist.first,
          totalExpense: totallist.last,
        );
    
        })
        ,
    
        // Transaction list
        Expanded(
          child: ValueListenableBuilder<List<TransactionModel>>(
            valueListenable: TransactionDB.instance.trsansactionListNotifier,
            builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemBuilder: (ctx, index) {
                  final _value = newlist[index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: _value.type == CategoryType.income
                            ? const Color.fromARGB(255, 114, 210, 117)
                            : const Color.fromARGB(255, 252, 127, 118),
                        child: Text(
                          parseDate(_value.date),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text('Rs ${_value.amount}'),
                      subtitle: Text(_value.category.name),
                      trailing: IconButton(
                        onPressed: () {
                          TransactionDB.instance.deleteTransaction(_value.id!);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: newlist.length,
              );
            },
          ),
        ),
      ],
    );
  }

  String parseDate(DateTime date) {
    return '${DateFormat.d().format(date)} ${DateFormat.MMM().format(date)}';
  }
}

class CreditCardCarousel extends StatefulWidget {
  final double totalIncome;
  final double totalExpense;

  const CreditCardCarousel({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
  }) : super(key: key);

  @override
  _CreditCardCarouselState createState() => _CreditCardCarouselState();
}

class _CreditCardCarouselState extends State<CreditCardCarousel> {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust the height as needed
      child: PageView(
        controller: _pageController,
        children: [
          CreditCardWidget(
            total: widget.totalIncome,
            title: 'Total Income',
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.blue], // Customize the gradient colors
            ),
          ),
          CreditCardWidget(
            total: widget.totalExpense,
            title: 'Total Expense',
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, Colors.orange], // Customize the gradient colors
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  final double total;
  final String title;
  final Gradient gradient;

  const CreditCardWidget({
    Key? key,
    required this.total,
    required this.title,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: gradient, // Use the gradient here
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Rs ${total.toStringAsFixed(2)}', // Format the total with 2 decimal places
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
