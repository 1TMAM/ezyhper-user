import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/Screens/Category/category_shape.dart';
import 'package:ezhyper/Screens/Category/subcategory_products_result.dart';
import 'package:ezhyper/Widgets/no_data/no_data.dart';
import 'package:ezhyper/Widgets/visitor_message.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart' as category_model;

class CategoryView extends StatefulWidget{
  final String view_type;
  CategoryView({this.view_type,});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryViewState();
  }

}
class CategoryViewState extends State<CategoryView>{

  @override
  void initState() {
    categoryBloc.add(getAllCategories());

    super.initState();
  }


    @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.ltr,
        child:  BlocBuilder(
          bloc: categoryBloc,
          builder: (context,state){
            if(state is Loading){
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }else if(state is Done){
              return widget.view_type =='horizontal_ListView'?StreamBuilder<CategoryModel>(
                stream: categoryBloc.categories_subject,
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    if(snapshot.data.data.isEmpty){
                      return Container();
                    }else{
                      return  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return    CategoryShape(
                              categoryModel: snapshot.data.data[index],
                            );
                          });
                    }
                  }
                  else if (snapshot.hasError) {
                    return Container(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return  Center(
                      child: SpinKitFadingCircle(color: greenColor),
                    );;
                  }
                },

              )

                  : StreamBuilder<CategoryModel>(
                stream: categoryBloc.categories_subject,
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    if(snapshot.data.data.isEmpty){
                      return Container();
                    }else{
                      return GridView.builder(
                          itemCount: snapshot.data.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // childAspectRatio: 1,
                          ),
                          physics: NeverScrollableScrollPhysics(),

                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: snapshot.data.data[index].subCategory==null? Container(): CategoryShape(
                                categoryModel: snapshot.data.data[index],
                              ),
                            );
                          });
                    }

                  }
                  else if (snapshot.hasError) {
                    return Container(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return  Center(
                      child: SpinKitFadingCircle(color: greenColor),
                    );;
                  }
                },

              );
            }else if(state is ErrorLoading){
              return NoData(
                message: translator.translate("There is Error"),
              );
            }else{
              return Center(
                child: SpinKitFadingCircle(color: greenColor),
              );
            }

          },
        )
    );
  }

}