import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/authentication/registration_page.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';

import '../home_page/home_page.dart';
import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon passIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String emailHelperText = "Example : prothes19@gmail.com";
  String passHelperText = "At least 8 chars, Example : Prothes@123";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _navigateHomePage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false,);
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
                    padding: EdgeInsets.only(top: 60.0.h,left: 10.0.w,right: 10.0.w,bottom: 10.0.h),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            /// >>> Form Title Start Here ======================
                            Text("Login Form",style:TextStyle(color: AppColors.primaryColor,fontSize: 30.sp,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                            SizedBox(height: 50.h,),
                            /// <<< Form Title End Here ========================


                            /// >>> Email Field Start Here =====================
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
                            /// <<< Email Field End Here =========================



                            /// >>> Password Field Start Here ====================
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
                            /// <<< Password Field End Here ======================





                            /// >>> Registration Button Start Here ===============
                            ElevatedButton(
                                onPressed: isLoading? null :() async{
                                  FocusScope.of(context).unfocus();
                                  if(_formKey.currentState!.validate()){
                                    String email = emailController.text.trim();
                                    String password = passwordController.text.trim();
                                    try{
                                      setState(() {isLoading = true;});




                                      setState(() {isLoading = false;});
                                    }catch(err){
                                      debugPrint("Firebase Error $err");
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                                child: isLoading?Padding(padding: EdgeInsets.all(10.0.w), child: Text("Wait..",style: TextStyle(fontSize: 20.sp),),):Padding(padding: EdgeInsets.all(10.0.w), child: Text("Login",style: TextStyle(fontSize: 20.sp),),)
                            ),
                            /// <<< Registration Button End Here =================


                            /// >>> =============== IF You New User So Registration Here =================
                            SizedBox(height: 25.h,),
                            InkWell(
                              onTap:()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationPage()), (Route<dynamic> route) => false,),
                              child: Text("New User? Registration",style: TextStyle(color: AppColors.primaryColor),),
                            ),
                            /// <<< =============== IF You New User So Registration Here =================

                            /// >>> =============== IF You New User So Registration Here =================
                            SizedBox(height: 15.h,),
                            InkWell(
                              onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordPage(),)),
                              child: Text("Forget Password",style: TextStyle(color: AppColors.primaryColor),),
                            )
                            /// <<< =============== IF You New User So Registration Here =================
                          ],
                        )
                    ),
                  ),
                ),

                if (isLoading)
                  Positioned(
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
      ),
    );
  }
}
