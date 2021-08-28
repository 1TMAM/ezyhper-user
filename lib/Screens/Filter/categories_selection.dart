import 'package:ezhyper/Bloc/Category_Bloc/category_bloc.dart';
import 'package:ezhyper/Model/CategoryModel/category_model.dart';
import 'package:ezhyper/fileExport.dart';

class CategoriesSelection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoriesSelectionState();
  }

}
class CategoriesSelectionState extends State<CategoriesSelection>{
  List<Item> generateItems(int numberOfItems) {
    print('generateItems---');
    return List.generate(numberOfItems, (int index) {
      print('header index : ${index}');
      return Item(
        headerValue: header_item[index],
      );
    });
  }

  List header_item ;
  List<Item> _data;
  String _categoryvalue;
  @override
  void initState() {
    categoryBloc.add(getAllCategories());
    super.initState();
  }
@override
  void didChangeDependencies() {
  _categoryvalue = "Daairy & Eggs";
  header_item = ['service_chosse'];
  _data = generateItems(1);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.all(10),
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title:  Text(item.headerValue),
                );
              },
              body: Container(
                height: MediaQuery.of(context).size.width / 3,
                child: StreamBuilder<CategoryModel>(
                  stream: categoryBloc.categories_subject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.isEmpty) {
                        return Container();
                      } else {
                        return Container(
                          height: snapshot.data.data.length > 3 ? width * .6 : null,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(height * .02))),
                          child: ListView.builder(
                              itemCount: snapshot.data.data.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data.data.length == 1) {
                                  sharedPreferenceManager.writeData(
                                      CachingKey.CATEGORY_ID,
                                      snapshot.data.data[0].id);
                                }
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff7f7f7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  child: Container(
                                    child: ListTile(
                                      title:
                                      Text('${snapshot.data.data[index].name}'),
                                      leading: Radio(
                                        value: snapshot.data.data[index].name,
                                        groupValue: _categoryvalue,
                                        onChanged: (value) {
                                          setState(() {
                                            _categoryvalue = value;
                                            sharedPreferenceManager.writeData(CachingKey.CATEGORY_ID, snapshot.data.data[index].id);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(color: greenColor),
                      );
                      ;
                    }
                  },
                ),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ));
  }

}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}