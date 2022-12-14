import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pangolin/utils/data/dap_index.dart';
import 'package:pangolin/utils/data/app_list.dart';
import 'package:pangolin/utils/data/models/application.dart';

void wapInstall(String url) {
  Process.run('wget', [
    "-N",
    "https://packages.dahliaos.io/" + url,
    "-P" "/root/Applications/data/"
  ]).then((result) {
    print(result.stderr.toString());
    print(result.stdout.toString());

    indexApplications();
  });
}

ListTile webApp(String name, String description, String url) {
  return ListTile(
    title: Text(name),
    subtitle: Text(description),
    trailing: ElevatedButton(
      child: Text('INSTALL'),
      onPressed: () {
        applications.removeWhere((app) => app.systemExecutable == true);
        wapInstall(url);
      },
    ),
  );
}

Widget WebAppManager() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Web App Manager',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: WebAppManagerHomePage(),
  );
}

Widget WebAppManagerHomePage() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Web App Manager'),
    ),
    body: Center(
      child: ListView(children: [
        webApp(
            "Discord", "Chat, Talk & Hangout", "com.discordapp.discord.json"),
        webApp("Visual Studio Code", "Code editing. Redefined.",
            "dev.vscode.app.json"),
      ]),
    ),
  );
}
