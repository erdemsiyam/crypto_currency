import 'package:crypto_currency/models/coin.dart';
import 'package:crypto_currency/services/services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int coinCounter;
  List<Coin> coins = []; // Tüm coinler
  List<Coin> filteredCoins = []; // Gösterilecek olan coinler

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.getCoins(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print('2');
        if (!snapshot.hasData) {
          print('3');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          coins = snapshot.data;
          filteredCoins = snapshot.data;
          print('4');
          return dataReadyWidget();
        }
      },
    );
  }

  Widget dataReadyWidget() {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.white70,
      backgroundColor: Colors.pink,
      child: Column(
        children: [
          filterText(),
          Expanded(child: coinList()),
        ],
      ),
    );
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      filteredCoins = coins;
    });
  }

  Widget filterText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            contentPadding: EdgeInsets.only(left: 50),
            hintText: 'Enter Coin Name',
          ),
          onChanged: (string) {
            setState(
              () {
                filteredCoins = coins
                    .where((u) =>
                        (u.fullName
                            .toLowerCase()
                            .contains(string.toLowerCase())) ||
                        (u.name.toLowerCase().contains(string.toLowerCase())))
                    .toList();
              },
            );
          },
        ),
      ),
    );
  }

  Widget coinList() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: filteredCoins.length,
      itemBuilder: (BuildContext context, int index) {
        coinCounter = index;
        return Card(
          child: ListTile(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailsPage(
              //       filteredCoins[index],
              //     ),
              //   ),
              // );
            },
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${coinCounter + 1}',
                ),
              ],
            ),
            title: Text(
              filteredCoins[index].fullName,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            subtitle: Text(
              filteredCoins[index].name,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: Text(
              '\$${filteredCoins[index].price.toStringAsFixed(4)}',
            ),
          ),
        );
      },
    );
  }
}
