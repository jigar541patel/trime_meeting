import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentPage extends StatefulWidget {
  const AttachmentPage({Key? key}) : super(key: key);

  @override
  State<AttachmentPage> createState() => _AttachmentPageState();
}

class _AttachmentPageState extends State<AttachmentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Add Attachments", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Add Documents",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                decoration: DottedDecoration(
                  // color: Colors.white,
                  color: Colors.black,
                  shape: Shape.box,
                  // borderRadius: BorderRadius.circular(15)
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextButton(
                  onPressed: () async {
                    var picked = await FilePicker.platform.pickFiles();

                    if (picked != null) {
                      print(picked.files.first.name);
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Text("DRAG AND DROP A FILE OR SELECT A FILE",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 16)),
                      SizedBox(height: 20),
                      Text("Document Should Be Less Than 100 MB",
                          style: TextStyle(
                              color: Color.fromARGB(221, 165, 82, 82),
                              fontSize: 14))
                    ],
                  ),
                )),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border(),
                color: Colors.blue,
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 35,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Uploaded File",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "inter,SemiBold"),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Add Links",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 12),
                    border: InputBorder.none,
                    hintText: "Links paste Here"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
