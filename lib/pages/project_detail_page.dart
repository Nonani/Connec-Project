import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/project_modify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/titlestyle.dart';

class ProjectDetailPage extends StatefulWidget {
  ProjectDetailPage(this.dID, this.my_name, {Key? key}) : super(key: key);
  final dID;
  final my_name;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: EdgeInsets.only(right: 230),
                width: 100,
                height: 100,
                child: DrawerHeader(
                  child: Image.asset(
                    "assets/images/connec_logo2.png",
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0),
                )),
            ListTile(
              title: Text('수정하기'),
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProjectModifyPage(widget.dID)))
                    .then((value) => setState(() {}));
              },
            ),
            ListTile(
              title: Text('공유하기'),
              onTap: () {
                Navigator.pop(context);
                String link =
                    "https://connec-project.web.app/#/share/${base64Encode(utf8.encode(widget.dID))}";

                Clipboard.setData(ClipboardData(text: link));
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop(true);
                      });
                      return Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Icon(Icons.check_circle,
                                      size: 100, color: Color(0xff5f66f2))),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '  프로젝트의 상세내용\n링크가 복사되었습니다',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          "프로젝트의 경험을 공유해보세요",
                                          style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ))
                                  ]),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '프로젝트 상세',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logger.w(snapshot.data);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("프로젝트 이름"),
                        Text(snapshot.data["name"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("한 줄 소개"),
                        Text(snapshot.data["introduction"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("내용"),
                        Text(snapshot.data["context"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("본인의 역할"),
                        Text(snapshot.data["role"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("본인의 성과"),
                        Text(snapshot.data["accomplishment"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("참여 기간"),
                        Text(snapshot.data["period"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("참여자 명단"),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data["participants"].length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item =
                                snapshot.data['participants'][index];

                            return Container(
                              child: Row(children: [
                                Text(item['name']),
                                item["phone_number"] != ''
                                    ? Text(item["phone_number"])
                                    : TextButton(
                                        onPressed: () {
                                          String combinedString =
                                              "${widget.dID},${item['name']},${widget.my_name}";
                                          String encodedString = base64Encode(
                                              utf8.encode(combinedString));
                                          print(combinedString);
                                          print(encodedString);
                                          String url =
                                              "https://connec-project.web.app/#/confirm/" +
                                                  encodedString;
                                          Clipboard.setData(
                                              ClipboardData(text: url));
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                // Future.delayed(Duration(seconds: 3), () {
                                                //   Navigator.of(context).pop(true);
                                                // });
                                                return Dialog(
                                                  // The background color
                                                  backgroundColor: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 20),
                                                            child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 100,
                                                                color: Color(
                                                                    0xff5f66f2))),
                                                        Text(
                                                          '프로젝트 참여자에게 전화번호 등록을 요청해보세요. \n공유코드가 클립보드에\n  복사되었습니다.',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff333333),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Text("미등록")),
                              ]),
                            );
                          },
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CustomLoadingDialog();
          }
        },
      ),
    );
  }

  Future _future() async {
    final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/project/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'docId': widget.dID,
        },
      );
      logger.w(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      logger.w(e);
    }

    return null;
  }
}
