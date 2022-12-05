import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'custom_log_interceptor.dart';
import 'data.dart';
import 'rest_client.dart';

class RetrofitDioJson extends StatelessWidget {
  RetrofitDioJson({Key? key}) : super(key: key);

  final dio = Dio()
    ..interceptors.add(
      CustomLogInterceptor(),
    );

  @override
  Widget build(BuildContext context) {
    final _client = RestClient(dio);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dio'),
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: _client.getUser(id: 1),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User? userInfo = snapshot.data;
              if (userInfo != null) {
                Data userData = userInfo.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(userData.avatar),
                    SizedBox(height: 16.0),
                    Text(
                      '${userInfo.data.firstName} ${userInfo.data.lastName}',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}