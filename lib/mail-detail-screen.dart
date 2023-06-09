import 'dart:math';

import 'package:flutter/material.dart';
import 'controller.dart';

class MailDetailScreen extends StatelessWidget {
  MailDetailScreen(
      {required this.subject,
      required this.fromName,
      required this.time,
      required this.content});
  final String subject, fromName, time, content;
  final List<String> menuTabItems = [
    "Move to",
    "Snooze",
    "Mark as important",
    "Mute",
    "Print",
    "Report spam",
    "Help and feedback"
  ];

  final List<String> menuMailItems = [
    "Reply all",
    "Forward",
    "Add star",
    "Print",
    "Mark unread from here",
    "Block GitHub",
  ];
  @override
  Widget build(BuildContext context) {
    final mysize = MediaQuery.of(context).size;
    // double kPadding = mysize.width * 0.025 > 0 ? mysize.width * 0.025 : 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.black54,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.archive_outlined),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.email),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          InkWell(
            child: PopupMenuButton(
              iconSize: 24,
              icon: Icon(
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
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: [
            //-------------Title Widget
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: mysize.width - 10,
                    child: Text(
                      subject,
                      style: TextStyle(
                          color: Colors.black87.withOpacity(0.8), fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {},
                ),
              ],
            ),

            //-----------Mail subject Widget
            Row(
              children: [
                CircleAvatar(
                  child: Text(subject.substring(0, 1).toUpperCase()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            fromName,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            time,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'to me',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Icon(
                            Icons.expand_more,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.keyboard_return), onPressed: () {}),
                InkWell(
                  child: PopupMenuButton(
                    iconSize: 24,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.black54,
                    ),
                    itemBuilder: (context) => menuMailItems
                        .map(
                          (itemName) => PopupMenuItem(
                            child: Text(itemName),
                            value: itemName,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            //-----------------------Mail Info/Content
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
            ),
            //-----------------------Last Three Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.reply),
                    label: Text('Reply'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.reply_all),
                    label: Text('Reply all'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.send),
                    label: Text('Forward'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
