import 'dart:async';
import 'dart:io';
import 'package:ezhyper/Bloc/Search_Bloc/search_bloc.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:ezhyper/Model/SearchModel/search_model.dart' as search_model;
import 'package:search_widget/search_widget.dart';



class AdvancedSearchClass extends StatefulWidget {
  final String token;
  AdvancedSearchClass({this.token});

  @override
  State<StatefulWidget> createState() {
    ('AdvancedSearchClass token : ${token}');
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<AdvancedSearchClass> {
  search_model.Products _selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<SearchModel>(
    stream: search_bloc.search_products_subject,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data.data == null) {
          return NoData(
            message: "there is No Data",
          );
        } else {
          return SearchWidget<search_model.Products>(
            dataList: snapshot.data.data.products,
            hideSearchBoxWhenItemSelected: true,
            listContainerHeight: MediaQuery.of(context).size.height / 4,
            queryBuilder: (query, list) {
              return list
                  .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            },
            popupListItemBuilder: (item) {
              return PopupListItemWidget(item, widget.token);

            },
            selectedItemBuilder: (selectedItem, deleteSelectedItem) {},
            // widget customization
            noItemsFoundWidget: NoItemsFound(),
            textFieldBuilder: (controller, focusNode) {
              return MyTextField(controller , widget.token , focusNode);

            },
            onItemSelected: (item) {
              setState(() {
                _selectedItem = item;
              });
            },
          );
        }
      }
      else if (snapshot.hasError) {
        return Container(
          child: Text('${snapshot.error}'),
        );
      } else {
        return Center(
          child: SpinKitFadingCircle(color: greenColor),
        );;
      }
    },

    )
/*      child: StreamBuilder<SearchModel>(
        stream: search_bloc.search_products_subject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SearchWidget<search_model.Products>(
                dataList: snapshot.data.data.products,
                hideSearchBoxWhenItemSelected: true,
                listContainerHeight: MediaQuery.of(context).size.height / 4,
                queryBuilder: (query, list) {
                  return list
                      .where((item) =>
                      item.name.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                    return PopupListItemWidget(item, widget.token);

                },
                selectedItemBuilder: (selectedItem, deleteSelectedItem) {},
                // widget customization
                noItemsFoundWidget: NoItemsFound(),
                textFieldBuilder: (controller, focusNode) {
                    return MyTextField(controller , widget.token , focusNode);

                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              );
            } else {}
          }
          return CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(greenColor),
          );
        },
      ),*/
    );
  }
}

class MyTextField extends StatelessWidget {
  final String token;
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextField(this.controller, this.token,this.focusNode);



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Container(
        width: width * .53,
        height: height * .07,
        child: Container(
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: greyColor, fontSize:EzhyperFont.primary_font_size),
            cursorColor: greyColor,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: (){
                  search_bloc.add(SearchProductsEvent(
                      columns: ['name_ar'],
                      operand: ['like'],
                      columns_values: [controller.text]

                  ));
                },
                icon: Icon(
                  Icons.search,
                  color: greyColor,
                  size: height * .035,
                ),
              ),
              hintText: translator.translate("What Are You Loking For ? "),
              hintStyle:
              TextStyle(color: Colors.grey, fontSize:EzhyperFont.secondary_font_size),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: greenColor)),
            ),
          ),
        ));
    return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black)),
            child: Directionality(
              textDirection: translator=='en'? TextDirection.ltr : TextDirection.rtl,          child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: translator.translate("What Are You Loking For ? "),
                      hintStyle: TextStyle(
                        color: Color(0xFFBBBBBB),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          search_bloc.add(SearchProductsEvent(
                              columns: ['name_ar'],
                              operand: ['like'],
                              columns_values: [ controller.text]

                          ));
                        },
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            ));
  }

}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.shop,
          size: 24,
          color: greyColor,
        ),
        const SizedBox(width: 10),
        Text(
          translator.translate("There is no products"),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  final search_model.Products item;
  final String token;
  const PopupListItemWidget(this.item, this.token);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: translator.currentLanguage=='en'? TextDirection.ltr : TextDirection.rtl,        child: InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Text(
          item.name,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      onTap: () {
        search_bloc.add(SearchProductsEvent(
            columns: ['name_ar'],
            operand: ['like'],
            columns_values: [ item.name]

        ));
      },
    ));
  }
}
