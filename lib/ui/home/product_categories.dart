import 'package:flutter/material.dart';

class ProductCategoriesPage extends StatefulWidget {
  @override
  _ProductCategoriesPageState createState() => _ProductCategoriesPageState();
}

class _ProductCategoriesPageState extends State<ProductCategoriesPage> {
  final List<Map<String, String>> filterMenuList = [
    {'Category': 'Category 1', 'Type': 'Type A'},
    {'Category': 'Category 2', 'Type': 'Type B'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Drawer Content'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 16, left: 21, right: 15, bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 18), // Replace with textMedium
                  ),
                  Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink, // Replace with AppColor.neonPink
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                filterMenuList.length,
                (index) => Column(
                  children: [
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      title: Text(
                        "${filterMenuList[index]['Category']}",
                        style: TextStyle(
                          fontSize: 16, // Replace with textRegular
                          color: Colors.black, // Replace with AppColor.black
                        ),
                      ),
                      trailing: Text(
                        "${filterMenuList[index]['Type']}",
                        style: TextStyle(
                          fontSize: 16, // Replace with textRegular
                          color: Colors.grey, // Replace with AppColor.grey
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/nested');
                      },
                    ),
                    Divider(
                      color: Colors.black, // Replace with AppColor.black
                    ),
                  ],
                ),
              ),
            ),
            // Add more items here
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        if (settings.name == '/') {
          page = MainDrawerContent();
        } else if (settings.name == '/nestedroute') {
          page = MainDrawerContent();
        } else {
          page = MainDrawerContent();
        }

        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => UndefinedRouteScreen(),
        );
      },
    );
  }
}

class MainDrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Drawer Content'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/nestedroute');
          },
          child: Text('Go to Nested Drawer Content'),
        ),
      ),
    );
  }
}

class UndefinedRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Route'),
      ),
      body: Center(
        child: Text('This route is not defined'),
      ),
    );
  }
}
