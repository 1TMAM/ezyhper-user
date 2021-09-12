import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart' as category_model;
import 'package:ezhyper/Screens/Product/product_grid_list.dart';

import 'package:ezhyper/fileExport.dart';

class CategoryShape extends StatefulWidget {
  category_model.Data categoryModel;
CategoryShape({this.categoryModel });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryShapeState();
  }
}

class CategoryShapeState extends State<CategoryShape> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: height * .15,
        child:  InkWell(
          onTap: () {
            print("Cover : ${widget.categoryModel.cover}");
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {

                  return ProductsGridList(
                    page_name:'categoryProducts',
                    category_id: widget.categoryModel.id.toString(),
                    category_name: widget.categoryModel.name.toString(),
                    subCategory_list: widget.categoryModel.subCategory,
                  );
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 10),
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(
                width: width * .03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(height * .015)),
                ),
                height: height * .15,
                width: width * .4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(height * .015)),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(height * .015)),
                          child: Image.network(
                            widget.categoryModel.cover,
                            fit: BoxFit.fill,
                          )),
                      height: height * .15,
                      width: width * .4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                        borderRadius: BorderRadius.all(
                            Radius.circular(height * .015)),
                      ),
                      height: height * .15,
                      width: width * .4,
                      child: Container(
                          padding: EdgeInsets.only(
                              top: height * .1, right: width * .1),
                          child: MyText(
                            text:  widget.categoryModel.name??'',
                            color: whiteColor,
                            size: EzhyperFont.primary_font_size,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
