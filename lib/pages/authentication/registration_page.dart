import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:path/path.dart' as path;
import '../../utils/image_processor.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  int currentStep = 1;
  bool isLoading = false;
  bool dropDownBorderColor = false;
  File? tradeLicenseImage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phnNumberController = TextEditingController();
  final deliveryRangeController = TextEditingController();
  final tradeLicenseController = TextEditingController();
  final dropdownController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;


  /// >>> Helper Text & Icon Here
  Icon nameIcon = Icon(Icons.person,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon emailIcon = Icon(Icons.email,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon phoneIcon = Icon(Icons.phone,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon deliveryRangeIcon = Icon(Icons.delivery_dining,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon tradeLicenseIcon = Icon(Icons.insert_drive_file_sharp,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon dropDownIcon = Icon(Icons.store,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String nameHelperText = "Your Full Name";
  String emailHelperText = "Example : prothes19@gmail.com";
  String phoneHelperText = "Example : 01317818826";
  String deliveryRangeHelperText = "600-meter";
  String tradeLicenseHelperText = "your trade license";
  String dropdownHelperText = "Select Store Type";



  Icon passIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon conPassIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String passHelperText = "At least 8 chars, Example : Prothes@123";
  String conPassHelperText = "Re-type Password";


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phnNumberController.dispose();
    deliveryRangeController.dispose();
    tradeLicenseController.dispose();
    dropdownController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _navigateLoginPage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.bodyBgOverlayColor,elevation: 0,),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// >>> Form Title Start Here ======================
                              Text("Registration Form",style:TextStyle(color: AppColors.primaryColor,fontSize: 30.sp,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                              SizedBox(height: 50.h,),
                              /// <<< Form Title End Here ========================


                              /// >>> User Name Field Start Here ================
                              if (currentStep >= 1)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Full Name",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [nameIcon, SizedBox(width: 5.w,), Text(nameHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 30,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: nameController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
                                  onChanged: (value){
                                    setState(() {
                                      if (RegExp(r'^[a-zA-Z\s.)(]+$').hasMatch(value)){
                                        nameHelperText = "Valid Name";
                                        nameIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 2;});
                                      }else{
                                        nameHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value){
                                    if(value == null || value.trim().isEmpty){
                                      return "Field is Empty";
                                    }
                                    if (!RegExp(r'^[a-zA-Z\s.)(]+$').hasMatch(value)){
                                      return "Ignore Some Special Symbol";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< User Name Field End Here ==================


                              /// >>> Email Field Start Here =======================
                              if (currentStep >= 2)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Email",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.email_outlined),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [emailIcon, SizedBox(width: 5.w,), Text(emailHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 50,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: emailController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                                        emailHelperText = "Valid Email";
                                        emailIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 3;});
                                      }else{
                                        emailHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value){
                                    if(value == null || value.trim().isEmpty){
                                      return "Field is Empty";
                                    }
                                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                                      return "Invalid Email";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< Email Field End Here =========================


                              /// >>> Phone Number Field Start Here ================
                              if (currentStep >= 3)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Phone Number",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.phone),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [phoneIcon, SizedBox(width: 5.w,), Text(phoneHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 11,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: phnNumberController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (value.length == 11 && RegExp(r'^(01[3-9])[0-9]{8}$').hasMatch(value)){
                                        phoneHelperText = "Valid Phone Number";
                                        phoneIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 4;});
                                      }else{
                                        phoneHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value){
                                    if(value == null || value.trim().isEmpty){
                                      return "Field is Empty";
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)){
                                      return "Invalid Number";
                                    }
                                    value = value.trim().replaceAll('+', '');
                                    if (value.length != 11) {
                                      return "11 Digit Phone Number";
                                    }
                                    final pattern = RegExp(r'^(01[3-9])[0-9]{8}$');
                                    if (!pattern.hasMatch(value)) {
                                      return "Invalid Number";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< Phone Number Field End Here ==================


                              /// >>> Delivery Range Field Start Here ================
                              if (currentStep >= 4)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Delivery Range",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Delivery Range",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.delivery_dining),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [deliveryRangeIcon, SizedBox(width: 5.w,), Text(deliveryRangeHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: deliveryRangeController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (RegExp(r'^[1-9]\d*$').hasMatch(value)){
                                        deliveryRangeHelperText = "Valid Delivery Range";
                                        deliveryRangeIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 5;});
                                      }else{
                                        deliveryRangeHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value){
                                    if(value == null || value.trim().isEmpty){
                                      return "Field is Empty";
                                    }
                                    if (!RegExp(r'^\d+$').hasMatch(value)){
                                      return "Invalid Number";
                                    }if (!RegExp(r'^[1-9]\d*$').hasMatch(value)){
                                      return "First Digit 0 Not Allow";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< Delivery Range Field End Here ==================


                              /// >>> Trade License No Field Start Here ================
                              if (currentStep >= 5)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Trade License Number",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Trade License Number",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.document_scanner),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [tradeLicenseIcon, SizedBox(width: 5.w,), Text(tradeLicenseHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 20,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: tradeLicenseController,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (RegExp(r'^[1-9]\d*$').hasMatch(value)){
                                        tradeLicenseHelperText = "Valid Trade License";
                                        tradeLicenseIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 6;});
                                      }else{
                                        tradeLicenseHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value){
                                    if(value == null || value.trim().isEmpty){
                                      return "Field is Empty";
                                    }
                                    // Check if the value contains only digits
                                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                                      return "Invalid number";
                                    }
                                    // Check if the first digit is 0
                                    if (value.startsWith('0')) {
                                      return "First digit cannot be 0";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),

                                /// >>> Trade License Image Field Start Here ===
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      File? pickedFile = await ImageProcessor.pickImage(context, 300, false, false,"tradeLicense");
                                      if (pickedFile != null) {
                                        setState(() {tradeLicenseImage = pickedFile;});
                                      }
                                    },
                                    icon: Icon(Icons.upload_file, size: 24.sp, color: tradeLicenseImage != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor),
                                    label:  Text(tradeLicenseImage != null ? path.basename(tradeLicenseImage!.path) : "Upload Trade License", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: tradeLicenseImage != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor,), overflow: TextOverflow.ellipsis,),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0, side: BorderSide(color: tradeLicenseImage != null ? AppColors.appInputFieldActiveColor : AppColors.appInputFieldUnActiveColor, width: 1.5), padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r),),),
                                  ),
                                ),
                                SizedBox(height: 30.h,),
                                /// <<< Trade License Image Field End Here =====
                              ],
                              /// <<< Trade License No Field End Here ==================



                              /// >>> DropDown Field Start Here ==============
                              if (currentStep >= 6)...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownMenu<String>(
                                      controller: dropdownController,
                                      hintText: "Items Type",
                                      label: Text("Items Type"),
                                      leadingIcon: Icon(Icons.local_convenience_store),
                                      width: double.infinity,
                                      enableFilter: true,
                                      requestFocusOnTap: true,
                                      enableSearch: true,
                                      inputDecorationTheme: InputDecorationTheme(
                                        border: OutlineInputBorder(borderSide: BorderSide(color: dropdownController.text.isEmpty && dropDownBorderColor ? Colors.red : AppColors.appInputFieldUnActiveColor),),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor),),
                                        labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                        hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                        fillColor: Colors.white.withValues(alpha: 0.3),
                                        filled: true,
                                        prefixIconColor: AppColors.appInputFieldActiveColor,
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: dropdownController.text.isEmpty && dropDownBorderColor ? Colors.red : AppColors.appInputFieldUnActiveColor),),
                                      ),
                                      onSelected: (value) {
                                        if(value != null){
                                          setState(() {
                                            dropdownController.text = value;
                                            dropdownHelperText = "Valid Store Type";
                                            dropDownIcon = Icon(Icons.verified, color: Colors.green, size: 15.sp);
                                            dropDownBorderColor = false;
                                            setState(() {currentStep = 7;});
                                          });
                                        }
                                      },
                                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
                                      dropdownMenuEntries: const [
                                        DropdownMenuEntry(value: "Grocery", label: "Grocery"),
                                        DropdownMenuEntry(value: "Restaurant", label: "Restaurant"),
                                        DropdownMenuEntry(value: "Pharmacy", label: "Pharmacy"),
                                        DropdownMenuEntry(value: "Clothing", label: "Clothing"),
                                        DropdownMenuEntry(value: "Electronics", label: "Electronics"),
                                        DropdownMenuEntry(value: "Furniture", label: "Furniture"),
                                        DropdownMenuEntry(value: "Cosmetics", label: "Cosmetics"),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.0.w),
                                      child: Row(
                                        children: [
                                          dropDownIcon,
                                          SizedBox(width: 5.w),
                                          Text(dropdownHelperText, style: TextStyle(color: AppColors.appInputFieldUnActiveColor),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< DropDown Field End Here ================



                              /// >>> Password Field Start Here ====================
                              if (currentStep >= 7)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Password",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.password_outlined),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [passIcon, SizedBox(width: 5.w,), Text(passHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.appInputFieldActiveColor,),
                                      onPressed: () {
                                        setState(() {_obscurePassword = !_obscurePassword;});
                                      },
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  maxLength: 22,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: passwordController,
                                  obscureText: _obscurePassword,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (value.length >= 8 && RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*{}()\\.+=?/_-]).{8,}$').hasMatch(value)){
                                        passHelperText = "Valid Password";
                                        passIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                        setState(() {currentStep = 8;});
                                      }else{
                                        passHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Field is Empty";
                                    }
                                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                      return "Must contain at least one uppercase letter (A-Z)";
                                    }
                                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                                      return "Must contain at least one lowercase letter (a-z)";
                                    }
                                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                                      return "Must contain at least one number (0-9)";
                                    }
                                    if (!RegExp(r'[!@#$%^&*{}()\\.+=?/_-]').hasMatch(value)) {
                                      return "Must contain at least one Symbol";
                                    }
                                    if (value.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< Password Field End Here ======================


                              /// >>> Confirm Password Field Start Here ============
                              if (currentStep >= 8)...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelText: "Confirm Password",
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.password_outlined),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    helper: Row(children: [conPassIcon, SizedBox(width: 5.w,), Text(conPassHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: AppColors.appInputFieldActiveColor,),
                                      onPressed: () {
                                        setState(() {_obscureConfirm = !_obscureConfirm;});
                                      },
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  maxLength: 50,
                                  cursorColor: AppColors.appInputFieldActiveColor,
                                  controller: confirmPasswordController,
                                  obscureText: _obscureConfirm,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onChanged: (value){
                                    setState(() {
                                      if (value == passwordController.text){
                                        conPassHelperText = "Successfully Password Matched";
                                        conPassIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                      }else{
                                        conPassHelperText = "";
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Field is Empty";
                                    }
                                    if (value != passwordController.text) {
                                      return "Password and Confirm Password do not match";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.h,),
                              ],
                              /// <<< Confirm Password Field End Here ==============


                              /// >>> Registration Button Start Here ===============
                              ElevatedButton(
                                  onPressed: isLoading || currentStep != 8 ? null :() async{

                                    FocusScope.of(context).unfocus();
                                    if(currentStep == 8 && _formKey.currentState!.validate()){
                                      String name = nameController.text.trim();
                                      String email = emailController.text.trim();
                                      String phnNumber = phnNumberController.text.trim();
                                      String deliveryRange = deliveryRangeController.text.trim();
                                      String password = confirmPasswordController.text.trim();

                                      if(dropdownController.text.isEmpty){
                                        setState(() {
                                          dropdownHelperText = "Please select a valid store type";
                                          dropDownIcon = Icon(Icons.error, color: Colors.red, size: 15.sp);
                                          dropDownBorderColor = true;
                                        });
                                        return;
                                      }

                                      try{
                                        setState(() {isLoading = true; dropDownBorderColor = false;});





                                        setState(() {isLoading = false;});
                                      }catch(err){
                                        debugPrint("Firebase Error $err");
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(disabledBackgroundColor: Colors.grey,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                                  child: isLoading?Padding(padding: EdgeInsets.all(10.0.w), child: Text("Wait..",style: TextStyle(fontSize: 20.sp),),):Padding(padding: EdgeInsets.all(10.0.w), child: Text("Registration",style: TextStyle(fontSize: 20.sp),),)
                              ),
                              /// <<< Registration Button End Here =================


                              /// >>> =============== IF Already His / Her Account Exists so Login Here =================
                              SizedBox(height: 25.h,),
                              InkWell(
                                onTap:()=>_navigateLoginPage(),
                                child: Text("Already have an account ? Login",style: TextStyle(color: AppColors.primaryColor),),
                              ),
                              /// <<< =============== IF Already His / Her Account Exists so Login Here =================

                              SizedBox(height: 100.h,),
                            ],
                          )
                      ),
                    ),
                  ),



                  if (isLoading)
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(12.r),),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 15.h),
                              Text("Loading...", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold,),),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
