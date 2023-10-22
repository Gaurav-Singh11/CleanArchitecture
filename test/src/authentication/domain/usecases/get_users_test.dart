import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_flutter/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository_mock.dart';

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test("should call the [AuthRepo.getUsers] and ret [List<Users>]", () async {
    /// Arrange

    when(() {
      return repository.getUsers();
    }).thenAnswer((_) async {
      return const Right(tResponse);
    });

    /// Act
    final result = await usecase();

    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
