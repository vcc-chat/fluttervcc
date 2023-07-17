import 'package:flutter/material.dart';
import '../vcc.dart';
import '../widgets/movewindow.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = "";
  var password = "";
  setUsername(username) {
    setState(() {
      this.username = username;
    });
  }

  setPassword(password) {
    setState(() {
      this.password = password;
    });
  }

  doLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSizedMoveWindow(AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login"),
        actions: generateWindowButtons(),
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 300,
                child: TextField(
                    onChanged: setUsername,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ))),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                    onChanged: setPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ))),
            SizedBox(
              height: 10,
            ),
            FilledButton(
              child: const Text("Login"),
              onPressed: () async {
                await vccClient.connect("ws://vcc.siliconbio.org.cn/ws");
                if ((await vccClient.login(username, password))) {
                  print("ok");
                  Navigator.pushNamedAndRemoveUntil(context, "/chat", (_) {
                    return false;
                  });
                } else {
                  print("no ok");
                }
                print(2);
                print(this.username + "," + this.password);
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
