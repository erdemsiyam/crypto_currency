import 'package:crypto_currency/models/coin.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Coin coin;
  DetailPage(this.coin);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
              title: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.coin.fullName}'s 24 Hour Change=  ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "\$${widget.coin.change.toStringAsFixed(4)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.coin.change > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
