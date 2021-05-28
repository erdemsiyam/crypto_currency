import 'dart:convert';

class Coin {
  final String name;
  final String fullName;
  final double price;
  final double change;

  const Coin({
    this.name,
    this.fullName,
    this.price,
    this.change,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fullName': fullName,
      'price': price,
      'change': change,
    };
  }

  factory Coin.fromMap(Map<String, dynamic> map) {
    return Coin(
      name: map['CoinInfo']['Name'],
      fullName: map['CoinInfo']['FullName'],
      price: (map['RAW']['USD']['PRICE'] as num).toDouble(),
      change: (map['RAW']['USD']['CHANGE24HOUR'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coin.fromJson(String source) => Coin.fromMap(json.decode(source));
}
