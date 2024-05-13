import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> products = [
    Product(
      name: 'Coca-cola',
      description: 'Uma refrescante lata de coca-cola 500ml',
      price: 5.99,
      imageUrl: 'coca.png',
    ),
    Product(
      name: 'Fanta',
      description: 'Uma refrescante lata de fanta laranja 500ml',
      price: 4.99,
      imageUrl: 'fanta.png',
    ),
    Product(
      name: 'Guaraná Antártica',
      description: 'Uma refrescante lata de guaraná antartica 500ml',
      price: 3.99,
      imageUrl: 'guarana_antartica.png',
    ),
    Product(
      name: 'Pepsi',
      description: 'Uma refrescante lata de pepsi 500ml',
      price: 5.99,
      imageUrl: 'pepsi.png',
    ),
    Product(
      name: 'Sprite',
      description: 'Uma refrescante lata de sprite 500ml',
      price: 2.99,
      imageUrl: 'sprite.png',
    ),
  ];

  int _currentPageIndex = 0;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Produtos'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              itemCount: products.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              controller: PageController(initialPage: _currentPageIndex),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: products[index]),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          products[index].imageUrl,
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(height: 20),
                        Text(products[index].name),
                        Text(products[index].description),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height / 2,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _currentPageIndex = (_currentPageIndex - 1).clamp(0, products.length - 1);
                });
              },
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height / 2,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  _currentPageIndex = (_currentPageIndex + 1).clamp(0, products.length - 1);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            product.imageUrl,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(product.description),
          Text('Price: \$${product.price.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Você comprou ${product.name} por \$${product.price.toStringAsFixed(2)}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text('Compre'),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}