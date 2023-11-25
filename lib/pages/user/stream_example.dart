import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LichenCareNotifications extends StatefulWidget {
  @override
  _LichenCareNotificationsState createState() =>
      _LichenCareNotificationsState();
}

class _LichenCareNotificationsState extends State<LichenCareNotifications> {
  final Stream<QuerySnapshot> _notificationsStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LichenCare Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _notificationsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text(data['first_name']),
                    subtitle: Text(data['email']),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
