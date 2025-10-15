import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constant/app_colors.dart';
import '../utils/constant/app_string.dart';



class BasicAlertDialogue extends StatelessWidget {
  const BasicAlertDialogue({super.key});

  static Future<bool> willPopScope(BuildContext context) async{
    final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => const BasicAlertDialogue(),
    );
    return shouldExit??false;
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded,color: AppColors.dangerColor,size: 40.sp,),
              SizedBox(height: 10.h,),
              Text(AppString.exitTitle,style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold,color: AppColors.dangerColor),),
              SizedBox(height: 10.h,),
              Text(AppString.exitDescriptionEn,style: TextStyle(color: Colors.grey,fontSize: 16.sp),textAlign: TextAlign.center,),
              SizedBox(height: 5.h,),
              Text(AppString.exitDescriptionBn,style: TextStyle(color: Colors.grey,fontSize: 14.sp),textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      onPressed: (){
                        Navigator.of(context).pop(true);
                        SystemNavigator.pop();
                      },
                      label: Text(AppString.positiveButton,style: TextStyle(color: Colors.white),),
                      icon: Icon(Icons.exit_to_app,color: Colors.white,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dangerColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r))
                      ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    label: Text(
                      AppString.negativeButton,
                      style: TextStyle(color: AppColors.success),
                    ),
                    icon: Icon(Icons.cancel, color: AppColors.success),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.success, width: 2.w), // This sets the outline
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r), // Only border radius here
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
      ),
    );
  }

}





