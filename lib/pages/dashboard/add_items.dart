import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/item_model.dart';
import '../../providers/items_provider.dart';
import '../../utils/constant/app_colors.dart';
import '../../utils/image_processor.dart';

class AddItems extends StatefulWidget {

  final ItemModel? editProduct;
  const AddItems({super.key, this.editProduct});


  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {

  File? _image;
  bool isLoading = false;
  bool _imageError = false;
  final _formKey = GlobalKey<FormState>();


  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productCategoryController = TextEditingController();
  final _productStockController = TextEditingController();
  final _productDescriptionController = TextEditingController();



  Icon productNameIcon = Icon(Icons.inventory,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String productNameHelperText = "Product Name";

  Icon productPriceIcon = Icon(Icons.price_change,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String productPriceHelperText = "Product Price";

  Icon productCategoryIcon = Icon(Icons.category_outlined,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String productCategoryHelperText = "Product Category";

  Icon productStockIcon = Icon(Icons.warehouse,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String productStockHelperText = "Product Stock";

  Icon productDescriptionIcon = Icon(Icons.category_outlined,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String productDescriptionHelperText = "Product Description";



  @override
  void initState() {
    super.initState();
    if (widget.editProduct != null) {
      _productNameController.text = widget.editProduct!.name;
      _productPriceController.text = widget.editProduct!.price.toString();
      _productCategoryController.text = widget.editProduct!.category;
      _productStockController.text = widget.editProduct!.stock.toString();
      _productDescriptionController.text = widget.editProduct!.description;
      if (widget.editProduct!.imagePath.isNotEmpty) {
        _image = File(widget.editProduct!.imagePath);
      }


      productNameHelperText = "Valid";
      productNameIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);

      productPriceHelperText = "Valid";
      productPriceIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);

      productCategoryHelperText = "Valid";
      productCategoryIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);

      productStockHelperText = "Valid";
      productStockIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);

      productDescriptionHelperText = "Valid";
      productDescriptionIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);

    }
  }


  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productCategoryController.dispose();
    _productStockController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isEdit = widget.editProduct != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Product" : "Add Product")),
      body: Container(
        decoration: BoxDecoration(color: AppColors.bodyBgOverlayColor),
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0.h,left: 10.0.w,right: 10.0.w,bottom: 10.0.h),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            SizedBox(height: 30.h,),

                            /// >>> =========== Product Name Start Here ==================
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Product Name",
                                hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                labelText: "Product Name",
                                labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                helper: Row(children: [productNameIcon, SizedBox(width: 5.w,), Text(productNameHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                              ),
                              keyboardType: TextInputType.text,
                              maxLength: 30,
                              cursorColor: AppColors.appInputFieldActiveColor,
                              controller: _productNameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value){
                                setState(() {
                                  if (value.trim().isNotEmpty){
                                    productNameHelperText = "Valid";
                                    productNameIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                  }else{
                                    productNameHelperText = "";
                                  }
                                });
                              },
                              validator: (value){
                                if(value == null || value.trim().isEmpty){
                                  return "Field is Empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox( height: 20.h),
                            /// <<< =========== Product Name End Here ====================


                            /// >>> =========== Product Price Start Here ==================
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Product Price",
                                hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                labelText: "Product Price",
                                labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                helper: Row(children: [productPriceIcon, SizedBox(width: 5.w,), Text(productPriceHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              cursorColor: AppColors.appInputFieldActiveColor,
                              controller: _productPriceController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value){
                                if (value.startsWith(".")) {
                                  _productPriceController.text = "0$value";
                                  _productPriceController.selection = TextSelection.fromPosition(
                                    TextPosition(offset: _productPriceController.text.length),
                                  );
                                }
                                if (value.split(".").length > 2) {
                                  _productPriceController.text = value.substring(0, value.length - 1);
                                  _productPriceController.selection = TextSelection.fromPosition(
                                    TextPosition(offset: _productPriceController.text.length),
                                  );
                                }
                                setState(() {
                                  if (value.trim().isNotEmpty){
                                    productPriceHelperText = "Valid";
                                    productPriceIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                  }else{
                                    productPriceHelperText = "";
                                  }
                                });
                              },
                              validator: (value){
                                if(value == null || value.trim().isEmpty){
                                  return "Field is Empty";
                                }
                                if (value.startsWith(".")) {
                                  return "Invalid Format";
                                }
                                if (value.split(".").length > 2) {
                                  return "Only one decimal point allowed";
                                }
                                return null;
                              },
                            ),
                            SizedBox( height: 20.h),
                            /// <<< =========== Product Price End Here ====================


                            /// >>> =========== Product Stock Start Here ==================
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Product Stock",
                                hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                labelText: "Product Stock",
                                labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                helper: Row(children: [productStockIcon, SizedBox(width: 5.w,), Text(productStockHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              cursorColor: AppColors.appInputFieldActiveColor,
                              controller: _productStockController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value){
                                setState(() {
                                  if (value.trim().isNotEmpty && RegExp(r'^(0|[1-9][0-9]*)$').hasMatch(value.trim())){
                                    productStockHelperText = "Valid";
                                    productStockIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                  }else{
                                    productStockHelperText = "";
                                  }
                                });
                              },
                              validator: (value){
                                if(value == null || value.trim().isEmpty){
                                  return "Field is Empty";
                                }
                                if (!RegExp(r'^(0|[1-9][0-9]*)$').hasMatch(value.trim())) {
                                  return "Only integers allowed, and cannot start with 0";
                                }
                                return null;
                              },
                            ),
                            SizedBox( height: 20.h),
                            /// <<< =========== Product Stock End Here ====================


                            /// >>> =========== Product Category Start Here ==================
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Product Category",
                                hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                labelText: "Product Category",
                                labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                helper: Row(children: [productCategoryIcon, SizedBox(width: 5.w,), Text(productCategoryHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                              ),
                              keyboardType: TextInputType.text,
                              maxLength: 20,
                              cursorColor: AppColors.appInputFieldActiveColor,
                              controller: _productCategoryController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
                              onChanged: (value){
                                setState(() {
                                  if (value.trim().isNotEmpty){
                                    productCategoryHelperText = "Valid";
                                    productCategoryIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                  }else{
                                    productCategoryHelperText = "";
                                  }
                                });
                              },
                              validator: (value){
                                if(value == null || value.trim().isEmpty){
                                  return "Field is Empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox( height: 20.h),
                            /// <<< =========== Product Category End Here ====================



                            /// >>> =========== Product Description Start Here ==================
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Product Description",
                                hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                labelText: "Product Description",
                                labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                helper: Row(children: [productDescriptionIcon, SizedBox(width: 5.w,), Text(productDescriptionHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                              ),
                              keyboardType: TextInputType.text,
                              maxLength: 20,
                              cursorColor: AppColors.appInputFieldActiveColor,
                              controller: _productDescriptionController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
                              onChanged: (value){
                                setState(() {
                                  if (value.trim().isNotEmpty){
                                    productDescriptionHelperText = "Valid";
                                    productDescriptionIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                  }else{
                                    productDescriptionHelperText = "";
                                  }
                                });
                              },
                              validator: (value){
                                if(value == null || value.trim().isEmpty){
                                  return "Field is Empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox( height: 20.h),
                            /// <<< =========== Product Description End Here ====================



                            /// >>> Product Image Upload Field Start Here ===================
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  File? pickedFile = await ImageProcessor.pickImage(context, 300, true, false, "products");
                                  if (pickedFile != null) {
                                    setState(() {_image = pickedFile;_imageError = false;});
                                  }
                                },
                                icon: Icon(Icons.upload_file, size: 24.sp, color: _imageError ? Colors.red : _image != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor,),
                                label: Text(_image != null ? path.basename(_image!.path) : "Upload Product Image", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: _imageError ? Colors.red : _image != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor,), overflow: TextOverflow.ellipsis,),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0, side: BorderSide(color: _imageError ? Colors.red : _image != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor, width: 1.5,), padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),),),
                              ),
                            ),
                            SizedBox(height: 30.h,),
                            /// <<< Product Image Upload Field End Here =====================



                            /// >>>  Upload Product Button Start Here ========================
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: isLoading? null :() async{
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){

                                  if (_image == null) {
                                    setState(() {_imageError = true;});
                                    return;
                                  }

                                  final product = ItemModel(
                                    id: isEdit ? widget.editProduct!.id : const Uuid().v4(),
                                    name: _productNameController.text,
                                    category: _productCategoryController.text,
                                    price: double.tryParse(_productPriceController.text) ?? 0,
                                    stock: int.tryParse(_productStockController.text) ?? 0,
                                    description: _productDescriptionController.text,
                                    imagePath: _image?.path ?? "",
                                  );
                                  final provider = Provider.of<ItemsProvider>(context, listen: false);

                                  if (isEdit) {
                                    provider.updateProduct(product);
                                  } else {
                                    provider.addProduct(product);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(isEdit ? "Update Product" : "Upload Product"),
                            ),
                            /// <<<  Upload Product Button End Here ==========================


                            SizedBox(height: 100.h,),

                          ],
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
