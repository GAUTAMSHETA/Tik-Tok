import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_app/pages/home_page.dart';
import 'package:tiktok_app/theme/colors.dart';
import 'package:tiktok_app/widgets/tik_tok_icons.dart';
import 'package:tiktok_app/widgets/upload_icon.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  File _image;

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        HomePage(),
        Center(
          child: Text(
            "Discover",
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "Upload",
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "All Activity",
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget getFooter() {
    List bottomItems = [
      {"icon" : TikTokIcons.home, "lable" : "Home", "isIcon" : true},
      {"icon" : TikTokIcons.search, "lable" : "Discover", "isIcon" : true},
      {"icon" : "", "label" : "", "isIcon" : false},
      {"icon" : TikTokIcons.messages, "lable" : "Inbox", "isIcon" : true},
      {"icon" : TikTokIcons.profile, "lable" : "Me", "isIcon" : true},
    ];
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: appBgColor),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index){
            return bottomItems[index]["isIcon"] ?
                InkWell(
                  onTap: (){
                    selectedTeb(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        bottomItems[index]["icon"],
                        color: white,
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          bottomItems[index]["lable"],
                          style: TextStyle(color: white,fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ) : InkWell(
              onTap: () async{
                selectedTeb(index);
                var _image2 = await ImagePicker().getVideo(source: ImageSource.gallery);
                _image = File(_image2.path);

                FirebaseStorage fs = FirebaseStorage.instance;

                var  rootReference = fs.ref();

                var video = rootReference.child("videos2").child("first.mp4");

                video.putFile(_image).then((_){
                  print("uploded");
                  setState(() {
                    selectedTeb(0);
                  });
                });
              },
              child: UploadIcon(),
            );
          }),
        ),
      ),
    );
  }

  selectedTeb(index){
    setState(() {
      pageIndex = index;
    });
  }
}
