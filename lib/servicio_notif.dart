import 'package:flutter_local_notifications/flutter_local_notifications.dart';


  final FlutterLocalNotificationsPlugin notificacion = FlutterLocalNotificationsPlugin();

  Future<void> initNotificaciones() async {
    
  const AndroidInitializationSettings androidinitializationSettings = AndroidInitializationSettings('launch_background');
  
  const InitializationSettings initializationSettings = InitializationSettings(
      android: androidinitializationSettings
    );

    await notificacion.initialize(initializationSettings);

  }

  Future<void> showNotificacion() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('channelId', 'channelName');

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await notificacion.show(
      1, 
      'Holi', 
      'Si jaloooo!!', 
      notificationDetails
    );

  }