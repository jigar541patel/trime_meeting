import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  String dropdownvalue = '5 Min';
  var items = [
    '5 Min',
    '10 Min',
    '30 Min',
    '1 Hour',
    '2 Hour',
  ];
  String dropdownvalue1 = 'Paragraph';
  var items1 = [
    'Heading 1',
    'Heading 2',
    'Heading 3',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: TrimeAppBarWithTitle(context, true)
          .getAppBarWithBackArrowTitle("Add Agenda", onBack: () {
        Get.back();
      }),
      body: ListView(children: [
        SizedBox(height: 50),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColors.lightWhiteOpacityColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none,
                      hintText: "Title Here"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.28,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColors.lightWhiteOpacityColor,
                ),
                child: DropdownButton(
                  isExpanded: true,
                  underline: const SizedBox(),
                  alignment: Alignment.center,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items
                      .map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                          ),
                        );
                      })
                      .toSet()
                      .toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black45,
            ),
          ),
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                //  margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: HexColors.lightWhiteOpacityColor,
                ),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_drop_down)),
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none,
                      hintText: "Paragraph",
                      hintStyle:
                          TextStyle(color: Colors.black87, fontSize: 14)),
                ),
              ),
              Container(
                height: 35,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.5,
                  indent: 5,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                height: 30,
                child:IconButton(icon: Image.asset("Assets/Image/bold.png"),onPressed: (){},)
              ),
              // SizedBox(width: 2),
               Container(
                   margin: EdgeInsets.only(top: 5),
                 height: 30,
                child:IconButton(icon: Image.asset("Assets/Image/italic.png"),onPressed: (){},)
              ),
               Container(
                height: 35,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.5,
                  indent: 5,
                ),
              ),
               Container(
                  //  margin: EdgeInsets.only(top: 5),
                 height: 35,
                child:IconButton(icon: Image.asset("Assets/Image/link.png"),onPressed: (){},)
              ),
               Container(
                height: 35,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.5,
                  indent: 5,
                ),
              ),
              SizedBox(width: 5,),
               Container(
                //   margin: EdgeInsets.only(top: 5),
                // height: 45,
                child:IconButton(icon: Image.asset("Assets/Image/indent.png",color: Colors.black87,),onPressed: (){},)
              ),
              // SizedBox(width: 2),
               Container(
                //    margin: EdgeInsets.only(top: 5),
                //  height: 45,
                child:IconButton(icon: Image.asset("Assets/Image/indent (1).png",color: Colors.black87,),onPressed: (){},)
              ),
              Container(
                height: 35,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.5,
                  indent: 5,
                ),
              ),
               Container(
                //    margin: EdgeInsets.only(top: 5),
                //  height: 45,
                child:IconButton(icon: Image.asset("Assets/Image/list.png"),onPressed: (){},)
              ),
                Container(
                height: 35,
                child: VerticalDivider(
                  color: Colors.black54,
                  thickness: 0.5,
                  indent: 5,
                ),
              ),
               Container(
                child:IconButton(icon: Image.asset("Assets/Image/undo.png"),onPressed: (){},)
              ),
               Container(
                child:IconButton(icon: Image.asset("Assets/Image/redo.png"),onPressed: (){},)
              ),
              SizedBox(height: 20,),
              Divider(
                thickness: 0.5,
                color: Colors.black54,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: TextFormField( 
                  decoration:InputDecoration(
                    border: InputBorder.none
                  )
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
         Container(
          alignment: Alignment.bottomRight,
                         decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 1)),
                  margin: const EdgeInsets.only(left: 250,right: 20),
                  height: 40,
                 
                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        
                         Image.asset("Assets/Image/add.png",height: 20,width: 20,),
                        Text(
                        "  Agenda",
                          style: TextStyle(fontSize: 16,color: Colors.blue,fontFamily: "inter,SemiBold"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,)
      ]),
    ));
  }
}
