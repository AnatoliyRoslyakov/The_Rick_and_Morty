import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_rick_and_morty/common/app_colors.dart';
import 'package:the_rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:the_rick_and_morty/feature/presentation/bloc/search_bloc.dart/search.bloc.dart';
import 'package:the_rick_and_morty/locator_service.dart' as di;
import 'package:go_router/go_router.dart';

import 'feature/presentation/pages/home_page.dart';
import 'feature/presentation/pages/person_detail_page.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              colorScheme:
                  ColorScheme.dark(background: AppColors.mainBackground),
              scaffoldBackgroundColor: AppColors.mainBackground),
          home: HomePage(),
        ));
  }
}
