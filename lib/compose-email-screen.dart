import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'home-page.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({Key? key, required void onSendMessage})
      : super(key: key);

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  bool expandMore = false;

  bool showCcField = false;

  bool showBccField = false;

  final List<String> menuTabItems = [
    'Schedule send',
    "Confidential Mode",
    "Discard",
    "Settings",
    "help and feedback"
  ];

  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    Controller controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Compose',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.attachment_outlined),
              iconSize: 24,
              color: Colors.black54,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.send),
              iconSize: 24,
              color: Colors.black54,
              onPressed: () {
                try {
                  final data = FirebaseFirestore.instance
                      .collection('${controller.toPhoneNumber.text}');
                  data.add({
                    'fromName':
                        '${controller.countryCode.text + controller.phoneNumber.text}',
                    'subject': '${controller.subject.text}',
                    'content': '${controller.content.text}',
                    'time': '1:04 pm',
                    'isRead': false
                  });
                  FirebaseFirestore.instance
                      .collection(
                          '${controller.countryCode.text + controller.phoneNumber.text}')
                      .doc('sent')
                      .collection('sent')
                      .add({
                    'fromName': '${controller.toPhoneNumber.text}',
                    'subject': '${controller.subject.text}',
                    'content': '${controller.content.text}',
                    'time': '1:04 pm',
                    'isRead': false
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text('Mail has been sent.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
            InkWell(
              child: PopupMenuButton(
                iconSize: 24,
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.black54,
                ),
                itemBuilder: (context) => menuTabItems
                    .map(
                      (itemName) => PopupMenuItem(
                        child: Text(itemName),
                        value: itemName,
                      ),
                    )
                    .toList(),
                onSelected: (value) {
                  setState(() {
                    if (value == 'Cc') {
                      showCcField = true;
                    } else if (value == 'Bcc') {
                      showBccField = true;
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(fontSize: 18),
                  initialValue:
                      controller.countryCode.text + controller.phoneNumber.text,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 3, left: 2, right: 2),
                      child: Text(
                        'From',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black54))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'To',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: controller.toPhoneNumber,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.expand_more),
                              color: Colors.black54,
                              onPressed: () {
                                setState(() {
                                  expandMore = !expandMore;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (expandMore)
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black54))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Cc',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black54))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Bcc',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black54, width: 1))),
                  child: TextField(
                    maxLines: null,
                    style: TextStyle(fontSize: 18),
                    controller: controller.subject,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 2, left: 2, right: 2),
                      hintText: 'Subject',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    maxLines: null,
                    controller: controller.content,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 2, left: 2, right: 2),
                      hintText: 'Compose',
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
