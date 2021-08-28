
import 'package:ezhyper/Base/shared_preference_manger.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/material.dart';
class CustomRangeSlider extends StatefulWidget{
  var start;
  var end;
  var divisions;
  var min;
  var max;
  var header;
  CachingKey cachingKeyStart;
  CachingKey cachingKeyEnd;
  CustomRangeSlider({this.start,this.end,this.max,this.min,this.divisions,this.cachingKeyStart,this.cachingKeyEnd,this.header});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomRangeSlider_State();
  }

}
class CustomRangeSlider_State extends State<CustomRangeSlider>{
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only( top: 0),
      child: Column(
        crossAxisAlignment: translator.currentLanguage == 'ar' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          MyText(
            text: '${widget.header}',
            size: 14,
            weight: FontWeight.normal,
          ) ,

          RangeSlider(
            min: widget.min,
            max: widget.max,
            values: RangeValues(widget.start,widget.end),
            labels: RangeLabels('${widget.start}','${widget.end}'),
            divisions: widget.divisions,
            activeColor: greenColor,
            onChanged: (values){
              setState(() {
                widget.start = values.start.roundToDouble();
                sharedPreferenceManager.writeData(widget.cachingKeyStart, widget.start);
                widget.end = values.end.roundToDouble();
                sharedPreferenceManager.writeData(widget.cachingKeyEnd, widget.end);
              });
            },
          )
        ],
      ),
    );
  }

}