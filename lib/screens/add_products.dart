import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/brand.dart';
import '../db/category.dart';
import '../db/products.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  CategoryServices _categoryService = CategoryServices();
  BrandServices _brandService = BrandServices();
  ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _quantityKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController keyFeatureController = TextEditingController();
    TextEditingController colorController = TextEditingController();

      


  final priceController = TextEditingController();
  final oldPriceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  List<String> selectedSize = [];
  List<String> selectedColor = [];
  List<String> description = [];
  List<String> keyFeatures = [];
  bool isFeatured = false;
  bool isFavorite = false;
  File image1;
  File image2;
  File image3;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //Load categories when page is created
    _getCategories();
    _getBrands();
  }

  // Category drop down list

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    //==Get items from brands list insert them in items list
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i]['categoryName']),
                value: categories[i]['categoryName']));
      });
    }
    return items;
  }

  // Brand drop down list

  List<DropdownMenuItem<String>> getBrandDropDown() {
    //==Get items from brands list insert them in items list
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < brands.length; i++) {
      items.insert(
        0,
        DropdownMenuItem(
          child: Text(brands[i]['BrandName']),
          value: brands[i]['BrandName'],
        ),
      );
    }
    return items;
  }

  //Get categories from data base store and insert them in categories lis
  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      //set getCategoriesDropdown list value = categoriesDropDown list
      categoriesDropDown = getCategoriesDropdown();
     // _currentCategory = categories[0].data['categoryName';
      _currentCategory = categories[0]['categoryName'];
    });
  }

  // Get brands from data store and insert them in brands list
  void _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrand();
    brands = data;
    // Set getBrandDropDown list values to brandsDropDown list
    brandsDropDown = getBrandDropDown();
    _currentBrand = brands[0]['BrandName'];
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File selectedImage = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => image1 = selectedImage);
        break;
      case 2:
        setState(() => image2 = selectedImage);
        break;
      case 3:
        setState(() => image3 = selectedImage);
        break;
    }
  }

  //imageDisplay widget
  Widget _displayChild(File image) {
    if (image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 40.0, 14.0, 40.0),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        image,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: white,
          title: Text(
            'Add Products',
            style: TextStyle(color: black),
          ),
          elevation: 0.1,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    _selectImage(
                                        ImagePicker.pickImage(
                                            source: ImageSource.gallery),
                                        1);
                                  },
                                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: BorderSide(
                                    color: grey.withOpacity(0.5),
                                    width: 2.0,
                                  ),),
                                  
                                  child: _displayChild(image1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    _selectImage(
                                        ImagePicker.pickImage(
                                            source: ImageSource.gallery),
                                        2);
                                  },
                                  style: OutlinedButton.styleFrom( shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: BorderSide(
                                    color: grey.withOpacity(0.5),
                                    width: 2.0,
                                  ),),
                                 
                                  child: _displayChild(image2),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    _selectImage(
                                        ImagePicker.pickImage(
                                            source: ImageSource.gallery),
                                        3);
                                  },
                                  style: OutlinedButton.styleFrom( shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  side: BorderSide(
                                    color: grey.withOpacity(0.5),
                                    width: 2.0,
                                  ),),
                                 
                                  child: _displayChild(image3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: productNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter product name',
                                hintStyle: TextStyle(fontSize: 18)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return ('Field should Not be empty');
                              } else if (value.length > 18) {
                                return ('Product name should not exceed 18 letters');
                              } else
                                return null;
                            },
                          ),
                        ),
                       
                            // Category button section
                            Row(children: [    Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Category: ',
                                style: TextStyle(
                                  color: Color(0xFFFF0025),
                                ),
                              ),
                            ),
                            DropdownButton(
                              items: categoriesDropDown,
                              onChanged: changeSelectedCategory,
                              value: _currentCategory,
                            ),],),
                        

                            // Brands button section
                            Row(children: [  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Brand',
                                style: TextStyle(color: Color(0xFFFF0025)),
                              ),
                            ),
                            DropdownButton(
                              items: brandsDropDown,
                              onChanged: (String selectedBrand) {
                                setState(() => _currentBrand = selectedBrand);
                              },
                              value: _currentBrand,
                            ),],),
                          
            
                        TextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Quantity'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Quantity field should not be empty');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Price'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Price field should not be empty');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: oldPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'oldPrice'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Price field should not be empty');
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          controller: descriptionController,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Description'),
                          
                        ),
                        ElevatedButton(onPressed: (){
                          if(descriptionController.text.isNotEmpty){
                          description.add(descriptionController.text);
                          descriptionController.clear();
                          }
                        }, child: Text('Add Description')),



                          TextFormField(
                          controller: keyFeatureController,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Key Features eg -something'),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return ('Key Features field should not be empty');
                          //   }
                          //   return null;
                          // },
                        ),

                         ElevatedButton(onPressed: (){
                            if(keyFeatureController.text.isNotEmpty){
                          keyFeatures.add(keyFeatureController.text);
                          keyFeatureController.clear();
                          }

                         }, child: Text('Add Key Features')),


                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: selectedSize.contains('XS'),
                              onChanged: (value) => changeSelectedSize('XS'),
                            ),
                            Text('XS'),
                            Checkbox(
                                value: selectedSize.contains('S'),
                                onChanged: (value) => changeSelectedSize('S')),
                            Text('S'),
                            Checkbox(
                                value: selectedSize.contains('M'),
                                onChanged: (value) => changeSelectedSize('M')),
                            Text('M'),
                            Checkbox(
                                value: selectedSize.contains('L'),
                                onChanged: (value) => changeSelectedSize('L')),
                            Text('L'),
                            Checkbox(
                                value: selectedSize.contains('XL'),
                                onChanged: (value) => changeSelectedSize('XL')),
                            Text('XL'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: selectedSize.contains('28'),
                                onChanged: (value) => changeSelectedSize('28')),
                            Text('28'),
                            Checkbox(
                                value: selectedSize.contains('30'),
                                onChanged: (value) => changeSelectedSize('30')),
                            Text('30'),
                            Checkbox(
                                value: selectedSize.contains('32'),
                                onChanged: (value) => changeSelectedSize('32')),
                            Text('32'),
                            Checkbox(
                                value: selectedSize.contains('34'),
                                onChanged: (value) => changeSelectedSize('34')),
                            Text('34'),
                            Checkbox(
                                value: selectedSize.contains('36'),
                                onChanged: (value) => changeSelectedSize('36')),
                            Text('36'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: selectedSize.contains('38'),
                                onChanged: (value) => changeSelectedSize('38')),
                            Text('38'),
                            Checkbox(
                                value: selectedSize.contains('40'),
                                onChanged: (value) => changeSelectedSize('40')),
                            Text('40'),
                            Checkbox(
                                value: selectedSize.contains('42'),
                                onChanged: (value) => changeSelectedSize('42')),
                            Text('42'),
                            Checkbox(
                                value: selectedSize.contains('44'),
                                onChanged: (value) => changeSelectedSize('44')),
                            Text('44'),
                            Checkbox(
                                value: selectedSize.contains('46'),
                                onChanged: (value) => changeSelectedSize('46')),
                            Text('46'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Color',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: selectedColor.contains('red'),
                                onChanged: (value) =>
                                    changeSelectedColor('red')),
                            Text('red'),
                            Checkbox(
                                value: selectedColor.contains('wite'),
                                onChanged: (value) =>
                                    changeSelectedColor('wite')),
                            Text('wite'),
                            Checkbox(
                                value: selectedColor.contains('black'),
                                onChanged: (value) =>
                                    changeSelectedColor('black')),
                            Text('black'),
                            Checkbox(
                                value: selectedColor.contains('brown'),
                                onChanged: (value) =>
                                    changeSelectedColor('brown')),
                            Text('brown'),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Or Type Color',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                          TextFormField(
                          controller: colorController,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Add your color eg mint green'),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return ('Key Features field should not be empty');
                          //   }
                          //   return null;
                          // },
                        ),

                         ElevatedButton(onPressed: (){
                            if(colorController.text.isNotEmpty){
                          selectedColor.add(colorController.text);
                          colorController.clear();
                          }

                         }, child: Text('Add Color')),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //====Featured button=====
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 20.0, 8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isFeatured = !isFeatured;
                                  });
                                },
                                child: Container(
                                  height: 30.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    color:
                                        isFeatured ? Colors.green : Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Featured',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        FlatButton(
                          onPressed: () {
                            _validateAndUpload();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Color(0xFFFF0025),
                          textColor: Colors.white,
                          child: Text('Add Products'),
                        ),
                      ],
                    )),
        ));
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSize.contains(size)) {
      setState(() {
        selectedSize.remove(size);
      });
    } else {
      setState(() {
        selectedSize.add(size);
      });
    }
  }

  void changeSelectedColor(String color) {
    if (selectedColor.contains(color)) {
      setState(() => selectedColor.remove(color));
    } else {
      setState(() => selectedColor.add(color));
    }
  }

  void _validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (image1 != null && image2 != null && image3 != null) {
          final FirebaseStorage storage = FirebaseStorage.instance;
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          //=========Generate image id=========
          final String picture1 =
              '1${DateTime.now().millisecondsSinceEpoch.toString()}jpg';
          final String picture2 =
              '2${DateTime.now().millisecondsSinceEpoch.toString()}jpg';
          final String picture3 =
              '3${DateTime.now().millisecondsSinceEpoch.toString()}jpg';

          //=====Upload images=====
          UploadTask task1 =
              storage.ref().child(picture1).putFile(image1);
          UploadTask task2 =
              storage.ref().child(picture2).putFile(image2);
          UploadTask task3 =
              storage.ref().child(picture3).putFile(image3);

          //======Check if last image is uploaded then do something====
          TaskSnapshot snapshot1 =
              await task1.then((snapShot) => snapShot);
          TaskSnapshot snapshot2 =
              await task2.then((snapShot) => snapShot);

              

          task3.then((snapshot3) async {
            //====Then get the image url===
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];
            productService.uploadProduct(
              productName: productNameController.text,
              price: int.parse(priceController.text),
              oldPrice: int.parse(oldPriceController.text),
              size: selectedSize,
              category: _currentCategory,
              brand: _currentBrand,
              images: imageList,
              colors: selectedColor,
              favorite: isFavorite,
              featured: isFeatured,
              quantity: int.parse(quantityController.text),
              description: description,
              keyFeatures: keyFeatures,
            );
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
            Fluttertoast.showToast(msg: 'Product added');
          });
       
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'All images must be provided');
      }
    }
  }
}
