# app_base_api

Ejemplo práctico de una sencilla App básica pero con temas interesantes.
Vamós a ver :
- await http.get
- ListView.builder
- PageView.builder
- Pasar datos entre páginas

## Apuntes sobre la App:

Código:
```
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para jsonDecode
```
....
```
List? _dataList;
  void _incrementCounter() async {
    final data =
        await http.get(Uri.parse('https://api.npoint.io/8becd3a84a59e32bc124'));
    _dataList = jsonDecode(data.body);
    setState(() {});
  }
  ```

Que nos cargue los datos al inicializar
```
  @override
  void initState() {
    super.initState();
    _incrementCounter();
  }
  ```
.....
Con un ListView
```
    body: Center(
        child: ListView.builder(
          itemCount: _dataList?.length,
          itemExtent: 200,
          itemBuilder: (context, index) {
          final item = _dataList?[index];
          final image = item['image'];
          return Image.network(image);
        }),
```
.....
Con un PageView. 
Importante: Decirle que mientras los datos sean null, muestre el Circular Progress....
```
    body: Center(
        child: _dataList != null 
            ? PageView.builder(
                itemCount: _dataList?.length,
                itemBuilder: (context, index) {
                  final item = _dataList?[index];
                  final _image = item['image'];
                  final _city = item['city'];
                  final _name = item['name'];
                  final _description = item['description'];
                  final equipo = Equipo(
                      name: _name,
                      city: _city,
                      image: _image,
                      description: _description);
                  // Mostrar datos
                  return MyItems(equipo: equipo);
                },
              )
            : CircularProgressIndicator(),
```
Para poder manejar mejor los datos creo una clase:
```
class Equipo {
  final String name;
  final String city;
  final String description;
  final String image;
```
......
![Screenshot](/assets/images/video.gif)

