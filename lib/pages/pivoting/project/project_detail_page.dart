
import 'dart:ui';

import 'package:connec/components/custom_detail_element.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/pivoting/project/project_modify_page.dart';
import 'package:connec/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../style/padding_style.dart';
import '../../../style/title_style.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage(this.idx, this.dID, this.myName, {Key? key})
      : super(key: key);
  final int idx;
  final String dID;
  final String myName;

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
                    color: Color(0xff5f66f2),
                  ),
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
                      Future.delayed(const Duration(seconds: 3),
                          () => Navigator.of(context).pop(true));
                      return completeDialog(
                          '  프로젝트${widget.idx + 1}의 상세내용\n링크가 복사되었습니다',
                          "프로젝트 경험을 공유해보세요.");
                    });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff5f66f2)),
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
          '프로젝트 ${widget.idx + 1}',
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
                  projectDetailElement("프로젝트 이름", snapshot.data["name"]),
                  projectDetailElement("한 줄 소개", snapshot.data["introduction"]),
                  projectDetailElement("내용", snapshot.data["context"]),
                  projectDetailElement("본인의 역할", snapshot.data["role"]),
                  projectDetailElement(
                      "본인의 성과", snapshot.data["accomplishment"]),
                  projectDetailElement("참여 기간",
                      "${snapshot.data["period"][0].substring(0, 10)} ~ ${snapshot.data["period"][1].substring(0, 10)}"),
                  Container(
                    margin: padding10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("첨부파일"),
                        TextButton(
                            onPressed: () async {
                              final String url = snapshot.data['downloadLinks'][0];
                              Clipboard.setData(ClipboardData(text: url));
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return completeDialog(
                                        "첨부파일 링크가 복사되었습니다.", "브라우저에서 확인해 보세요");
                                  });
                            },
                            child: Text("${snapshot.data['files'].isEmpty ? "" : snapshot.data['files'][0]}",
                                style: linkStyle)),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: padding10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("참여자 명단"),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data["participants"].length,
                          itemBuilder: (context, index) {
                            return listItemBuilder(
                                snapshot.data['participants'][index]);
                          },
                        ),
                        const Divider(
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
            return customLoadingDialog();
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

  String encodeLink(String name) {
    String combinedString = "${widget.dID},$name,${widget.myName}";
    String encodedString = base64Encode(utf8.encode(combinedString));
    String url = "https://connec-project.web.app/#/confirm/$encodedString";
    return url;
  }

  Widget listItemBuilder(Map<String, dynamic> item) {
    Widget content;
    if (item['phone_number'].isNotEmpty) {
      content = Text(item["phone_number"]);
    } else {
      content = TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: encodeLink(item['name'])));
            showDialog(
                context: context,
                builder: (context) {
                  return completeDialog(
                      '동의서 링크가 복사되었습니다.', '프로젝트를 함께한 동료에게 공유해보세요.');
                });
          },
          child: Text(
            "미등록",
            style: linkStyle,
          ));
    }
    return Row(children: [
      Text("   ${item['name']} :"),
      content,
    ]);
  }
}