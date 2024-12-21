import 'package:flutter/material.dart';


class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int pageIndex = 0;
  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        // margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        // elevation: 3,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        // child:
        Container(
      color: Color(0xff000000),
      height: 65,
      // width: MediaQuery.of(context).size.width,

      // margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: FittedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TextButton.icon(
                //   onPressed: (){},
                //   label:  const   Text(
                //           "Mute",
                //           style: TextStyles.blueButtonTextStyle,
                //         ),
                //   icon:
                //          const  Icon(Icons.volume_mute, color: HexColors.blueColor),

                // ),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Image/mute.png"),
                        const Text(
                          "Mute",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Image/stop.png"),
                        const Text(
                          "Stop Video",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                       IconButton(onPressed: (){}, icon: Image.asset("Assets/Image/upload.png",color: Color.fromARGB(255, 17, 223, 24),)),
                         Text(
                          "Share",
                          style: TextStyle(color: Color(0xff23D858)),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Image/participant.png"),
                        const Text(
                          "Participant",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Image/more.png"),
                        const SizedBox(height: 10,),
                         const Text(
                          "More",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        ),
                      ],
                    )), 
              ],
            ),
           const SizedBox(height: 20,)
           
          ],
        ),
      ),
    );
  }
}
