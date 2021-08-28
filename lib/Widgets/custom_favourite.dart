import 'package:ezhyper/Bloc/Favourite_Bloc/favourite_bloc.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFauvourite extends StatefulWidget{
   bool favourite_status;
  final Color color;
  final int product_id;
  CustomFauvourite({this.favourite_status=false,this.color,this.product_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomFauvourite_State();
  }

}
class CustomFauvourite_State extends State<CustomFauvourite>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(
            bottom: StaticData.get_height(context)  * .14, left: StaticData.get_width(context) * .29,
            top: StaticData.get_height(context)  * 0.01),
        child: Container(
          alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            height: StaticData.get_height(context)  * .04,
            width: StaticData.get_width(context) * .7,
            child:(widget.favourite_status)?  IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 15,
                  color: widget.color,

                ),
                onPressed: (StaticData.vistor_value == 'visitor')? null:() async{
                  await  favourite_bloc.add(removeFavourite_click(
                    product_id: widget.product_id,
                  ));
                  setState(() {
                    widget.favourite_status= !widget.favourite_status;
                    favourite_bloc.add(getAllFavoutites_click());

                  });
                },
              )
            :  IconButton(
              icon: Icon(
                Icons.favorite_border,
                size: StaticData.get_width(context)  * .04,
                color: widget.color,
              ),
              onPressed: (StaticData.vistor_value == 'visitor')? null: () {
                favourite_bloc.add(addFavourite_click(
                  product_id: widget.product_id,
                ));
                setState(() {
                  widget.favourite_status = !widget.favourite_status;
                });
              },
            )
        ));
  }

}