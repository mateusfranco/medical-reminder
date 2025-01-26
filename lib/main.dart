import 'package:flutter/material.dart';
import 'package:medical_reminder/external/local_notification_framework.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';
import 'package:medical_reminder/screens/add_tratment_screen.dart';
import 'package:medical_reminder/widgets/bottom_bar_navigation.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeTimeZones();

  initiateLocalNotifications();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TratmentProvider({})),
  ], child: const MyApp()));
}

Future<void> initializeTimeZones() async {
  tz.initializeTimeZones();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of yo ur application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
      home: const BottomNav(key: Key('bottom_nav')),
      routes: {
        '/add_tratment': (context) => AddTratmentScreen(),
      },
    );
  }
}
