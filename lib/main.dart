import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled_flutter/data/data.dart';
import 'package:untitled_flutter/ui/home/home_bloc/home_bloc.dart';

// my imports
import './ui/ui.dart';

class SimpleBlocObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object event) {
  //   print('onEvent $event');
  //   super.onEvent(bloc, event);
  // }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

// @override
// void onError(Bloc bloc, Object error, StackTrace stackTrace) {
//   print('onError $error');
//   super.onError(bloc, error, stackTrace);
// }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ApiClient apiClient = ApiClient();
  final ApiService apiService = ApiService(apiClient);
  final RemoteRepo remoteRepo = RemoteRepo(apiService);
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(remoteRepo));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp(this.remoteRepo);

  final RemoteRepo remoteRepo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetAnswersBloc(remoteRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          AppSplashScreen.route: (context) => const AppSplashScreen(),
          HomeScreen.route: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
