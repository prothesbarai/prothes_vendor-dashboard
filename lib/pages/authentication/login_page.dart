import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:prothesvendordashboard/pages/authentication/registration_page.dart';
import 'package:prothesvendordashboard/pages/dashboard/pro_dashboard.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  bool isLoading = false;
  bool isFirstTimeLogin = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon passIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon otpIcon = Icon(Icons.pin,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);

  String emailHelperText = "Example : prothes19@gmail.com";
  String passHelperText = "At least 8 chars, Example : Prothes@123";
  String otpHelperText = "Example : 123456";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _navigateDashboard(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProDashboard()), (Route<dynamic> route) => false,);
  }


  /// >>> Show Email & Phone Error Dialogue ==============================
  void _showDialogue(String message){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Login Failed"),
        content: Text(message.isNotEmpty ? message : "Unknown validation error occurred."),
        actions: [ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),child: Text("OK",style: TextStyle(color: Colors.white),),),],
      ),
    );
  }
  /// <<< Show Email & Phone Error Dialogue ==============================


  /// >>> Show First Time Login Send OTP Dialogue ==============================
  void _showOTPDialogue(String message, String otp, String firstLoginRes){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Send OTP"),
        content: Text(message.isNotEmpty ? message : "Unknown validation error occurred."),
        actions: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                isFirstTimeLogin = true;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),child: Text("OK",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
  /// <<< Show First Time Login Send OTP Dialogue ==============================


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

                            SizedBox(height: kToolbarHeight),

                            /// >>> If User First Time Login ===================
                            if(isFirstTimeLogin)...[

                              SizedBox(height: 90.h,),

                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Your OTP",
                                  labelText: "Your OTP",
                                  hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                  fillColor: Colors.white.withValues(alpha: 0.3),
                                  filled: true,
                                  prefixIcon: Icon(Icons.pin),
                                  prefixIconColor: AppColors.appInputFieldActiveColor,
                                  labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                  floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                  helper: Row(children: [otpIcon, SizedBox(width: 5.w,), Text(otpHelperText,style: TextStyle(color : AppColors.appInputFieldUnActiveColor),)],),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                maxLength: 50,
                                cursorColor: AppColors.appInputFieldActiveColor,
                                controller: otpController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value){
                                  setState(() {
                                    if (RegExp(r'^\d+$').hasMatch(value)){
                                      otpHelperText = "Valid OTP";
                                      otpIcon = Icon(Icons.verified,color: Colors.green, size: 15.sp,);
                                    }else{
                                      otpHelperText = "";
                                    }
                                  });
                                },
                                validator: (value){
                                  if(value == null || value.trim().isEmpty){
                                    return "Field is Empty";
                                  }
                                  if (!RegExp(r'^\d+$').hasMatch(value)){
                                    return "Invalid OTP";
                                  }
                                  return null;
                                },
                              ),

                              ElevatedButton(
                                  onPressed: isLoading? null :() async{
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      try {
                                        setState(() {isLoading = true;});

                                        final url = Uri.parse("url");
                                        final response = await http.post(
                                          url,
                                          headers: {"Content-Type": "application/json", "Authorization": "Bearer token",},
                                          body: jsonEncode({'body':'data'}),
                                        );



                                        setState(() => isLoading = false);

                                        final data = jsonDecode(response.body);
                                        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true){
                                           // Hare Save To Hive Data
                                          _navigateDashboard();
                                        }else if(data['success'] == false){
                                          _showDialogue("${data['message']}");
                                        }
                                        else {
                                          if (kDebugMode) print('Other response: ${response.statusCode}, body: ${response.body}');
                                        }
                                      }catch(err){
                                        debugPrint("Error $err");
                                      }
                                    }
                                  },
                                  child: Text("Verify OTP")
                              )
                            ],
                            /// <<< If User First Time Login ===================



                            /// >>> If User Second Time Login ==================
                            if(!isFirstTimeLogin)...[
                              /// >>> Form Title Start Here ====================
                              Text("Login Form",style:TextStyle(color: AppColors.primaryColor,fontSize: 30.sp,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                              SizedBox(height: 50.h,),
                              /// <<< Form Title End Here ======================


                              /// >>> Email Field Start Here ===================
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  labelText: "Email",
                                  hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
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
                              /// <<< Email Field End Here =====================


                              /// >>> Password Field Start Here ================
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  labelText: "Password",
                                  hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
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
                              /// <<< Password Field End Here ==================


                              /// >>> Registration Button Start Here ===========
                              ElevatedButton(
                                  onPressed: isLoading? null :() async{
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      String email = emailController.text.trim();
                                      String password = passwordController.text.trim();
                                      try{
                                        setState(() {isLoading = true;});

                                        /// >>> Here Start API Service  And Login Basen On Response ===============================
                                        final url = Uri.parse("Url");
                                        final response = await http.post(
                                          url,
                                          headers: {"Content-Type": "application/json", "Authorization": "Bearer token",},
                                          body: jsonEncode({'email': email, 'password': password}),
                                        );

                                        if (kDebugMode) {print("Response : ${response.body}");}

                                        setState(() => isLoading = false);

                                        final data = jsonDecode(response.body);
                                        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true && data['firstLogin'] == 'Yes') {
                                          _showOTPDialogue("${data['message']}","${data['data']}", "${data['firstLogin']}");
                                        }else if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
                                          if (kDebugMode) print("Login successful: ${data['message']}");
                                          // Update Your Hive
                                          _navigateDashboard();
                                        }else if(data['success'] == false){
                                          _showDialogue("${data['message']}");
                                        }
                                        else {
                                          if (kDebugMode) print('Other response: ${response.statusCode}, body: ${response.body}');
                                        }
                                        /// <<< Here End API Service  And Login Basen On Response =================================


                                      }catch(err){
                                        debugPrint("Error $err");
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                                  child: isLoading?Padding(padding: EdgeInsets.all(10.0.w), child: Text("Wait..",style: TextStyle(fontSize: 20.sp),),):Padding(padding: EdgeInsets.all(10.0.w), child: Text("Login",style: TextStyle(fontSize: 20.sp),),)
                              ),
                              /// <<< Registration Button End Here =============


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
                                child: Text("Forgot Password",style: TextStyle(color: AppColors.primaryColor),),
                              ),
                              /// <<< =============== IF You New User So Registration Here =================
                            ],
                            /// <<< If User Second Time Login ==================
                          ],
                        )
                    ),
                  ),
                ),

                if (isLoading)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
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
      ),
    );
  }
}
