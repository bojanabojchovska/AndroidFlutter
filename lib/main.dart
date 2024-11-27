import 'package:flutter/material.dart';
import 'package:mis/clothes.dart';
import 'clothes_card.dart';

void main() {
  runApp(const MaterialApp(
    home: ClothesList(),
  ));
}

class ClothesList extends StatefulWidget {
  const ClothesList({super.key});

  @override
  State<ClothesList> createState() => _ClothesListState();
}


class _ClothesListState extends State<ClothesList> {


  List<Clothes> clothes = [
    Clothes(name: 'dress', pictureUrl: 'https://static.zara.net/photos/2023/I/0/1/p/3067/348/800/14/w/560/3067348800_1_1_1.jpg?ts=1700578931363', description: 'party dress', price: 1999.0),
    Clothes(name: 'shirt', pictureUrl: 'https://i.pinimg.com/originals/b6/6c/4d/b66c4d33ef7f3176d6586496e2eeba25.jpg', description: 'white silk shirt', price: 2999.0),
    Clothes(name: 'skirt', pictureUrl: 'https://i.pinimg.com/originals/64/f1/f7/64f1f7d9579b221dd4e15c753b9b2a85.jpg', description: 'black short skirt', price: 1499.0),
    Clothes(name: 'skirt', pictureUrl: 'https://i.pinimg.com/originals/64/f1/f7/64f1f7d9579b221dd4e15c753b9b2a85.jpg', description: 'black short skirt', price: 1499.0),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('213089'),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
      ),
      body: ListView.builder(
        itemCount: clothes.length,
        itemBuilder: (context, index) {
          return ItemCard(item: clothes[index]);
        },
      ),
    );
  }
}




