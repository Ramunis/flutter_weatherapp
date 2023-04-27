import 'package:flutter/material.dart';
import 'package:ramunisweatherapp/home_page.dart';
import 'package:ramunisweatherapp/favforecast_page.dart';


class Favorite extends StatefulWidget {
  FavoriteState createState() => FavoriteState();
}
List<String> city = <String>["Vladivostok", "Paris", "London"];
int selectedIndex = 0;

class FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite")),
      body: Column(
        children: [
          Text("Ввести город в Избранное:", style: TextStyle(fontSize: 22)),
          TextField(decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Montevideo",
              fillColor: Colors.black12,
              filled: true
          ),
              onSubmitted: (text) {
                //print("onSubmitted");
                //print("Введенный текст: $text");
                city.add(text);
              },
              onChanged: (text) {
                //print("onChanged");
                //print("Введенный текст: $text");
              }),
          ElevatedButton(
              child: Text("Удалить город "+city[selectedIndex], style: TextStyle(fontSize: 22)),
              onPressed:(){ city.removeAt(selectedIndex);}
          ),
          Expanded(child: ListView.builder(
              itemCount: city.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        onTap: () {
                          //print(city[index]);
                          selectedIndex = index;
                          Navigator.push(context,MaterialPageRoute(builder: (_) => FavforecastPage(fav: city[index],)));
                        },
                        title: Text(city[index]),
                        subtitle: Text('Click here'),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/premium-vector/isometric-3d-icon-city-urban-area-with-a-lot-of-houses_70347-3522.jpg?w=2000"))
                    ));
              }))
        ],
      )
      );

  }
}