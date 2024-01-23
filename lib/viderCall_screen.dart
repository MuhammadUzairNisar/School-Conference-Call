import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideoCall extends StatefulWidget {
  String channelName = "test";

  VideoCall({required this.channelName});
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late final AgoraClient _client;
  bool _loading = true;
  String tempToken = "";

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String link =
        "https://agora-node-tokenserver-1.davidcaleb.repl.co/access_token?channelName=${widget.channelName}";

    Response _response = await get(Uri.parse(link));
    print(_response);

    // Map data = jsonDecode(_response.body);
    // setState(() {
    //   tempToken = data["token"];
    // });
    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: "8d818b11175a4b07b66b9a005aa24678",
          tempToken: "007eJxTYLhqqzyT+fu742/fB4YuEn4jc7JOpG/j3rTVknKdrW+MF6UrMFikWBhaJBkaGpqbJpokGZgnmZklWSYaGJgmJhqZmJlbPM5en9oQyMiQpPacgREKQXwuhuLkjPz8nPjEggIGBgBjWCKl",
          channelName: 'school_app',  
        ),
        enabledPermission: [Permission.camera, Permission.microphone]);
    Future.delayed(Duration(seconds: 1)).then(
      (value) => setState(() => _loading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AgoraVideoViewer(
                    client: _client,
                  ),
                  AgoraVideoButtons(client: _client)
                ],
              ),
      ),
    );
    ;
  }
}