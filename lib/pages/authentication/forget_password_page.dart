import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prothesvendordashboard/pages/authentication/login_page.dart';

import '../../utils/constant/app_colors.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {


  bool isLoading = false;
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: AppColors.appInputFieldUnActiveColor, size: 15.sp,);
  String emailHelperText = "Example : prothes19@gmail.com";

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
        title: Text("Reset Password"),
        content: Text("Password reset email sent! Check your email inbox."),
        actions: [
          ElevatedButton(
              onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,),
              child: Text("OK")
          )
        ],
      ),
    );
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



                              /// >>> Email Field Start Here =======================
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: AppColors.appInputFieldActiveColor),
                                  labelText: "Email",
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


                              /// >>> Registration Button Start Here ===============
                              ElevatedButton(
                                  onPressed: isLoading? null :() async{
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      String email = emailController.text.trim();
                                      try{
                                        setState(() {isLoading = true;});


                                        setState(() {isLoading = false;});
                                        _showPopUpAndNavigateLoginPage();
                                      }catch(err){
                                        debugPrint("Firebase Error $err");
                                      }
                                    }
                                  },
                                  child: isLoading?Text("Wait.."):Text("Reset Password")
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
