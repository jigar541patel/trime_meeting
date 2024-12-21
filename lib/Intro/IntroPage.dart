// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({ Key? key }) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text("trime")),
//     );
//   }
// }
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/scrollbar_behavior_enum.dart';
// import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        // pathImage: "Assets/Image/Remote team.png",
        centerWidget: Container(
            margin: EdgeInsets.only(top: 200, left: 15, right: 15),
            child: Image.asset("Assets/Image/IntoIMages.jpeg")),
        title: "MEETINGS,NOTES TASKS,DOCS-All",

        maxLineTitle: 2,
        marginTitle: EdgeInsets.only(top: 35),
        // marginTitle: EdgeInsets.only(top: 20),
        styleTitle: TextStyles.titleTextStyles,
        description: "Connected ,All Managed from one place",
        styleDescription: TextStyles.destitleTextStyles,
        backgroundColor: Colors.white,
        marginDescription: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 10.0, bottom: 70.0),
        // centerWidget: const Text("Replace this with a custom widget",
        //     style: TextStyle(color: Colors.white)),
        // backgroundNetworkImage: "https://picsum.photos/200/300",
        // directionColorBegin: Alignment.topLeft,
        // directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    // slides.add(
    //   Slide(
    //       // pathImage: "Assets/Image/Working remotely.png",
    //       centerWidget: Container(
    //           margin: EdgeInsets.only(top: 70),
    //           child: Image.asset("Assets/Image/Working remotely.png")),
    //       title: "Lorem ipsum dolor sit amet",
    //       marginTitle: EdgeInsets.only(top: 50),
    //       maxLineTitle: 2,
    //       styleTitle: TextStyles.titleTextStyle,
    //       description:
    //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
    //       styleDescription: TextStyles.decriptionTextStyle,
    //       backgroundColor: Colors.white
    //       // backgroundImage: "images/city.jpeg",
    //       // directionColorBegin: Alignment.topRight,
    //       // directionColorEnd: Alignment.bottomLeft,
    //       ),
    // );
    // slides.add(
    //   Slide(
    //     // pathImage: "Assets/Image/Events.png",
    //     centerWidget: Container(
    //         margin: EdgeInsets.only(top: 70),
    //         child: Image.asset("Assets/Image/Events.png")),
    //     title: "Lorem ipsum dolor sit amet",
    //     marginTitle: EdgeInsets.only(top: 50),
    //     maxLineTitle: 2,
    //     styleTitle: TextStyles.titleTextStyle,
    //     description:
    //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
    //     styleDescription: TextStyles.decriptionTextStyle,
    //     backgroundColor: Colors.white,
    //     // backgroundImage: "images/beach.jpeg",
    //     // directionColorBegin: Alignment.topCenter,
    //     // directionColorEnd: Alignment.bottomCenter,
    //     maxLineTextDescription: 3,
    //   ),
    //);
  }

  // void onDonePress() {
  //   // Do what you want
  //   Get.toNamed(PageRoutes.loginPage);
  // }

  void onNextPress() {
    Get.toNamed(PageRoutes.loginPage);
  }

  Widget renderNextBtn() {
    return Wrap(
      spacing: 25,
      children: const [
        Text(
          "Start Now",
          style: TextStyles.blueButtonTextStyle,
        ),
        Icon(Icons.arrow_right_alt, color: HexColors.blueColor),
      ],
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: HexColors.blueColor,
    );
  }

  Widget renderSkipBtn() {
    return TextButton(
      onPressed: () {
        Get.toNamed(PageRoutes.loginPage);
      },
      child: const Text(
        "Version 1.0",
        style: TextStyles.greyButtonTextStyle,
      ),
    );
  }

  Widget renderLogo() {
    return Container(
        margin: EdgeInsets.only(top: 200, left: 15, right: 15),
        child: Image.asset("Assets/Image/logo.png"));
  }

  // ButtonStyle myButtonStyle() {
  //   return ButtonStyle(
  //     // shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
  //     backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
  //     overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      IntroSlider(
        // List slides
       
        slides: slides,

        // Skip button
        renderSkipBtn: renderSkipBtn(),

        // Next button
        // renderNextBtn: renderNextBtn(),
        // onNextPress: onNextPress,
        // nextButtonStyle: myButtonStyle(),

        // Done button
        renderDoneBtn: renderNextBtn(),
        onNextPress: onNextPress,
        //onDonePress: this.onDonePress,
        // doneButtonStyle: myButtonStyle(),

        // Dot indicator
        // colorDot: HexColors.greyColor,
        // colorActiveDot: HexColors.blueColor,
        // sizeDot: 13.0,

        // Show or hide status bar
        hideStatusBar: true,
        backgroundColorAllSlides: Colors.white,

        // Scrollbar
        //verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
      ),
    );
  }
}
