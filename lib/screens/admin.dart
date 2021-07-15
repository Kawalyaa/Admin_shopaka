import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/components/adminCard.dart';
import 'package:shopla_ecommerce_app/db/category.dart';
import 'package:shopla_ecommerce_app/db/brand.dart';
import 'package:shopla_ecommerce_app/model/products_model.dart';
import 'package:shopla_ecommerce_app/model/user_model.dart';
import 'package:shopla_ecommerce_app/screens/add_products.dart';
import 'package:shopla_ecommerce_app/screens/products_screen.dart';
import 'package:shopla_ecommerce_app/screens/users_screen.dart';

enum Page { DASHBOARD, MANAGE }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.DASHBOARD;
  Color activeColor = Color(0xFFFF0025);
  Color notActiveColor = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();

  CategoryServices categoryServices = CategoryServices();
  BrandServices brandServices = BrandServices();

  Widget _loadScreen({List products,List users}) {
    switch (_selectedPage) {
      case Page.DASHBOARD:
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900),
              ),
              subtitle: TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.cyan,
                ),
                label: Text(
                  '12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {
                        Navigator.pushNamed(context, UsersList.id);
                      },
                      icon: Icon(
                        Icons.people_outline,
                        color: Colors.black,
                      ),
                      iconName: 'Users',
                      value: '${users?.length??0}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {},
                      icon: Icon(
                        Icons.category,
                        color: Colors.black,
                      ),
                      iconName: 'Categories',
                      value: '23',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {
                        Navigator.pushNamed(context, ProductsScreen.id,);
                      },
                      icon: Icon(
                        Icons.track_changes,
                        color: Colors.black,
                      ),
                      iconName: 'Products',
                      value: '${products?.length??0}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {},
                      icon: Icon(
                        Icons.tag_faces,
                        color: Colors.black,
                      ),
                      iconName: 'Sold',
                      value: '250',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {},
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      iconName: 'Oders',
                      value: '5',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleCard(
                      activeColor: activeColor,
                      onTap: () {},
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      iconName: 'Returns',
                      value: '0',
                    ),
                  ),
                ],
              ),
            )
          ],
        );
        break;
      case Page.MANAGE:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProducts(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text('Products List'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('Add Category'),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category List'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text('Add Brand'),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Products'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Brand List'),
              onTap: () {},
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  //=========Alert Dialogs========

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return ('Field cant be empty');
            } else
              return null;
          },
          decoration: InputDecoration(hintText: 'Add Category'),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (categoryController.text != null) {
              categoryServices.createCategory(categoryController.text);
            }
            Fluttertoast.showToast(msg: 'Category Added');
            Navigator.pop(context);
          },
          child: Text(
            'ADD',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'CANCEL',
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return ('Field cant be empty');
            } else
              return null;
          },
          decoration: InputDecoration(hintText: 'Add brand'),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (brandController.text != null) {
              brandServices.createBrand(brandController.text);
            }
            Fluttertoast.showToast(msg: 'Brand Added');
            Navigator.pop(context);
          },
          child: Text('ADD'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  @override
  Widget build(BuildContext context) {
     List<ProductModel>   allProducts = Provider.of<List<ProductModel>>(context);
     List<UserModel>  user = Provider.of<List<UserModel>>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.DASHBOARD;
                  });
                },
                icon: Icon(
                  Icons.dashboard,
                  color: _selectedPage == Page.DASHBOARD
                      ? activeColor
                      : notActiveColor,
                ),
                label: Text('Dashboard'),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.MANAGE;
                  });
                },
                icon: Icon(
                  Icons.sort,
                  color: _selectedPage == Page.MANAGE
                      ? activeColor
                      : notActiveColor,
                ),
                label: Text('Manage'),
              ),
            )
          ],
        ),
      ),
      body: _loadScreen(products: allProducts,users: user),
    );
  }
}
