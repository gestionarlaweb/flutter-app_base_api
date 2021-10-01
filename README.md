# app_base_api

Ejemplo práctico de una sencilla App básica pero con temas interesantes.
Vamós a ver :
- await http.get
- ListView.builder
- PageView.builder
- Pasar datos entre páginas
- Omitir el AppBar y poder regresar a la página anterior colocando un boton
- Widget HERO para crear una transición agradable

## Apuntes sobre la App:

### Código Apartado 1:
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
                  final _equipo = Equipo(
                      name: _name,
                      city: _city,
                      image: _image,
                      description: _description);
                  // Mostrar datos
                  return MyItems(equipo: _equipo);
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

### Código Apartado 2:
Vamos a ir a otra página mostrando la imagen seleccionada
- Modificamos un poco el código
```
return MyItems(equipo: equipo);
```
por 
```
return GestureDetector(
  onTap: () {
     Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailsPage(equipo: _equipo)));
  },
  child: MyItems(equipo: _equipo));
```
Ahora preparamos la página destino :
```
final Equipo equipo;

return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              equipo.image,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
```
Como lo hacemos si queremos quitar el AppBar y poder tener un boton para retroceder de página:
Con el 
``` 
BackButton(),
```
pero para ello es neceario que herede de (Material)
```
return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              equipo.image,
              fit: BoxFit.cover,
            ),
          ),
          BackButton(),
        ],
      ),
    );
```
### Widget HERO para una transición entre pantallas agradable:
El tag será el identificador entre los dos HERO
```
// HERO del main.dart
child: Column(
        children: [
          Hero(
            tag: equipo.name,
  
// HERO del details_page.dart        
child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: equipo.name,
              child: Image.network(
                equipo.image,
                fit: BoxFit.cover,
              ),
```
......
![Screenshot](/assets/images/video2.gif)

