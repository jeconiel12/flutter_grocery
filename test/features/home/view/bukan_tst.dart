import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_grocery/features/home/home.dart';

import '../../../helpers/helpers.dart';

class MockHomeCubit extends Mock implements HomeProductsCubit {}

void main() {
  group('HomePage', () {
    late HomeProductsCubit homeCubit;

    setUp(() {
      homeCubit = MockHomeCubit();
      when(() => homeCubit.close()).thenAnswer((_) => Future.value());
    });

    testWidgets('renders [HomeView]', (tester) async {
      whenListen(homeCubit, const Stream<HomeProductsState>.empty());

      GetIt.instance.registerFactory<HomeProductsCubit>(() => homeCubit);

      await tester.pumpApp(const HomePage());
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
