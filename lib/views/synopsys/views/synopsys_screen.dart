import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../operation/views/constructor_screen.dart';
import '../../operation/views/finance_screen.dart';
import '../widgets/currency_container.dart';

class SynopsysScreen extends StatefulWidget {
  @override
  _SynopsysScreenState createState() => _SynopsysScreenState();
}

class _SynopsysScreenState extends State<SynopsysScreen> {
  List<Map<String, dynamic>> operations = [];

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  void _addOperation(Map<String, dynamic> operation) async {
    setState(() {
      operations.add(operation);
    });
    await SharedPreferencesService.saveOperations(operations);
  }

  double get _totalIncome {
    return operations
        .where((op) => op['type'] == 'Income')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double get _totalSpendings {
    return operations
        .where((op) => op['type'] == 'Spendings')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double _totalAmount() {
    double totalIncome = _totalIncome;
    double totalSpendings = _totalSpendings;

    return totalIncome - totalSpendings;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                            operations: operations,
                          )),
                );
              },
              child: Text('History'))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(5.0),
                  border:
                      Border(bottom: BorderSide(color: AppColors.blackColor)),
                  color: AppColors.lightGreyColor.withOpacity(0.4),
                ),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Your balance',
                                    style: HomeScreenTextStyle.bannerTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '\$${_totalAmount().toString()}',
                              style: HomeScreenTextStyle.bannerIncome,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Income',
                                  style: HomeScreenTextStyle.bannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '\$$_totalIncome ',
                              style: HomeScreenTextStyle.bannerIncome,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: size.width * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Expense',
                                  style: HomeScreenTextStyle.bannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '\$$_totalSpendings ',
                              style: HomeScreenTextStyle.bannerSpendings,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CurrencyConverter(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.46,
                  height: size.height * 0.17,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.purpleColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/usdt.svg'),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'USDT',
                                style: HomeScreenTextStyle.titleName,
                              ),
                              Text(
                                'Tether',
                                style: HomeScreenTextStyle.titleDate,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$1,00',
                            style: HomeScreenTextStyle.titleName,
                          ),
                          Text(
                            '0.00%',
                            style: HomeScreenTextStyle.titleDate,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: size.width * 0.46,
                  height: size.height * 0.17,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.purpleColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/btc.svg'),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BTC',
                                style: HomeScreenTextStyle.titleName,
                              ),
                              Text(
                                'Bitcoin',
                                style: HomeScreenTextStyle.titleDate,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$69 824,30',
                            style: HomeScreenTextStyle.titleName,
                          ),
                          Text(
                            '0.45%',
                            style: HomeScreenTextStyle.titleDate,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: size.width * 0.95,
              height: size.height * 0.09,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.purpleColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/eth.svg'),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ETH',
                        style: HomeScreenTextStyle.titleName,
                      ),
                      Text(
                        'Ethereum',
                        style: HomeScreenTextStyle.titleDate,
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$3763,45',
                        style: HomeScreenTextStyle.titleName,
                      ),
                      Text(
                        '0.68%',
                        style: HomeScreenTextStyle.titleDate,
                      ),
                    ],
                  )
                ],
              ),
            ),
            ChosenActionButton(
              text: 'Add income/expense',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConstructorScreen()),
                );
                if (result != null) {
                  _addOperation(result);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
