import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:attendance/core/controller/sales/quote_controller.dart';
import 'package:attendance/core/model/quote_response.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/dotted_seprator.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';

class QuoteItemList extends StatelessWidget {
  QuoteData? quoteData;
  final GestureTapCallback? onTap;

  QuoteItemList({super.key,this.quoteData,this.onTap});
  @override
  Widget build(BuildContext context) {
    QuoteController quoteController=Get.find();

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: AppColor.cWhite,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 5,vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.primaryColor
                ),
                child: Text(quoteData!.quoteId.toString(),style: pRegular12.copyWith(color: AppColor.cWhite),),
              ),
              horizontalSpace(10),
              Expanded(child: Text(quoteData!.dateQuoted.toString(),style: pRegular10.copyWith(color: AppColor.gray),)),

              Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 2,horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: getStatusColor(quoteData!.status.toString()).withOpacity(0.10),
                  border: Border.all(color:getStatusColor(quoteData!.status.toString()),width: 0.5 )
                ),
                child: Text(quoteData!.status.toString(),style: pRegular10.copyWith(color: getStatusColor(quoteData!.status.toString())),),
              )
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Expanded(child: itemColumn("Name:", quoteData!.name.toString())),
              horizontalDivider(),
              Expanded(child: itemColumn("Account:", quoteData!.account.toString())),
              horizontalDivider(),
              Expanded(child: itemColumn("Assigned User:",quoteData!.user.toString())),
            ],
          ),
          verticalSpace(15),
          DottedSeparator(color: Colors.grey),

          verticalSpace(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(quoteData!.amount.toString(),
                  style: pMedium16.copyWith(color: AppColor.cBlack))),

              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF3EC9D6),
                  radius: 16,
                  child: Icon(Icons.edit, size: 14.0, color: AppColor.cWhite,),
                ),
              ),
              horizontalSpace(10),
              GestureDetector(
                onTap: (){
                  quoteController.deleteQuote(quoteData!.id.toString());

                },
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFF594A),
                  radius: 16,
                  child: Icon(Icons.delete, size: 14.0, color: AppColor.cWhite,),
                ),
              )

            ],
          )


        ],
      ),
    );

  }

  Widget itemColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: pRegular14,),
        verticalSpace(5),
        Text(value, style: pRegular12.copyWith(color: AppColor.gray),)

      ],
    );
  }



}