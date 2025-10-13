import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:prothesvendordashboard/pages/authentication/login_page.dart';
import '../../utils/constant/app_colors.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {


  bool isLoading = false;
  bool isOtpSent = false;
  bool isPasswordStage = false;
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon otpIcon = Icon(Icons.pin,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon passIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  Icon conPassIcon = Icon(Icons.password,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String emailHelperText = "Example : prothes19@gmail.com";
  String otpHelperText = "Example : 123456";
  String passHelperText = "At least 8 chars, Example : Prothes@123";
  String conPassHelperText = "Re-type Password";

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _showPopUpAndNavigateLoginPage(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Successful"),
        content: Text("Successfully Reset Your Password"),
        actions: [
          ElevatedButton(
              onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,),
              child: Text("OK")
          )
        ],
      ),
    );
  }



  /// >>> Show Email & Phone Error Dialogue ==============================
  void _showDialogue(String message){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Wrong Email"),
        content: Text(message.isNotEmpty ? message : "Unknown validation error occurred."),
        actions: [ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),child: Text("OK",style: TextStyle(color: Colors.white),),),],
      ),
    );
  }
  /// <<< Show Email & Phone Error Dialogue ==============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0.h,left: 10.0.w,right: 10.0.w,bottom: 10.0.h),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              SizedBox(height: (MediaQuery.of(context).size.height - kToolbarHeight) * 0.3,),

                              /// >>> Email Field Start Here ===================
                              if (!isOtpSent)
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
                              /// <<< Email Field End Here =====================


                              /// >>> OTP Field Start Here =====================
                              if (isOtpSent && !isPasswordStage)
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
                              /// <<< OTP Field End Here =======================


                              /// >>> Pass & Confirm Pass Field Start Here =====
                              if (isPasswordStage)...[
                                /// >>> Form Title Start Here ====================
                                Text("Set New Password",style:TextStyle(color: AppColors.primaryColor,fontSize: 30.sp,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                SizedBox(height: 30.h,),
                                /// <<< Form Title End Here ======================
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    labelText: "Password",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.password_outlined),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    labelText: "Confirm Password",
                                    hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    labelStyle: TextStyle(color: AppColors.appInputFieldUnActiveColor),
                                    floatingLabelStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                    border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldUnActiveColor)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.appInputFieldActiveColor)),
                                    fillColor: Colors.white.withValues(alpha: 0.3),
                                    filled: true,
                                    prefixIcon: Icon(Icons.password_outlined),
                                    prefixIconColor: AppColors.appInputFieldActiveColor,
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
                              ],
                              /// <<< Pass & Confirm Pass Field End Here =======


                              /// >>> Registration Button Start Here ===============
                              SizedBox(height: 20.h,),
                              ElevatedButton(
                                onPressed: isLoading? null :() async{
                                  FocusScope.of(context).unfocus();
                                  if(_formKey.currentState!.validate()){

                                    try{

                                      /// >>> Here Start API Service Forgot Email Send Code Based On Response ===============================
                                      if(!isOtpSent){
                                        // >>> Email stage
                                        setState(() {isLoading = true;});
                                        String email = emailController.text.trim();
                                        final url = Uri.parse("Url");
                                        final response = await http.post(
                                          url,
                                          headers: {"Content-Type": "application/json", "Authorization": "Bearer token",},
                                          body: jsonEncode({'email': email}),
                                        );
                                        if (kDebugMode) {print("Response : ${response.body}");}
                                        setState(() => isLoading = false);

                                        final data = jsonDecode(response.body);
                                        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
                                          if (kDebugMode) print("successful: ${data['message']}");

                                          setState(() => isOtpSent = true); // Move to OTP stage
                                        }else if(data['success'] == false){
                                          _showDialogue("${data['message']}");
                                        }
                                        else {
                                          if (kDebugMode) print('Other response: ${response.statusCode}, body: ${response.body}');
                                        }
                                      }else if (isOtpSent && !isPasswordStage){
                                        // >>> Verify OTP stage
                                        final url = Uri.parse("url");
                                        final response = await http.post(
                                          url,
                                          headers: {"Content-Type": "application/json", "Authorization": "Bearer token",},
                                          body: jsonEncode({'email': emailController.text.trim(), 'otp': otpController.text.trim(),}),
                                        );

                                        final data = jsonDecode(response.body);
                                        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
                                          setState(() => isPasswordStage = true); // Move to Password stage
                                        }else if(data['success'] == false){
                                          _showDialogue("${data['message']}");
                                        }
                                        else {
                                          if (kDebugMode) print('Other response: ${response.statusCode}, body: ${response.body}');
                                        }
                                      }else if (isPasswordStage) {
                                        // >>> Change Password stage
                                        final url = Uri.parse("url");
                                        final response = await http.post(
                                          url,
                                          headers: {"Content-Type": "application/json", "Authorization": "Bearer token",},
                                          body: jsonEncode({'email': emailController.text.trim(), 'password': confirmPasswordController.text.trim(),}),
                                        );

                                        final data = jsonDecode(response.body);
                                        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
                                          _showPopUpAndNavigateLoginPage();
                                        } else {
                                          _showDialogue(data['message'] ?? "Password Change Failed");
                                        }
                                      }
                                      /// <<< Here End API Service Forgot Email Send Code Based On Response =================================


                                    }catch(err){
                                      debugPrint("Error $err");
                                    }
                                  }
                                },
                                child: isLoading ? Text("Wait..") : Text(!isOtpSent ? "Reset Password" : isOtpSent && !isPasswordStage ? "Verify OTP" : "Change Password",),
                              ),
                              /// <<< Registration Button End Here =================

                            ],
                          )
                      ),
                    ),
                  ),
                ),

                if (isLoading)
                  Positioned(
                    top: 200,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
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
