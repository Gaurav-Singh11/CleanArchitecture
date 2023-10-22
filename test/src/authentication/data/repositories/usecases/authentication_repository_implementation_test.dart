import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter/core/errors/exceptions.dart';
import 'package:tdd_flutter/core/errors/failure.dart';
import 'package:tdd_flutter/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_flutter/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_flutter/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(
    message: "Unknown Error Occurred",
    statusCode: 500,
  );

  group("creteUser", () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';

    test(
      "should call the [RemoteDataSource.createUser] and complete "
          "successfully when the call to remote source is successful",
          () async {
        /// Arrange
        when(
              () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          ),
        ).thenAnswer((_) => Future.value());

        /// Act

        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        /// Assert

        expect(result, equals(const Right(null)));
        verify(
              () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      "should return a [ServerFailure] when the call to the remote source is unsuccessful",
          () async {
        /// Arrange
        when(
              () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          ),
        ).thenThrow(tException);

        /// Act

        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        /// Assert

        expect(
          result,
          equals(
            Left(
              APIFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(
              () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group("getUsers", () {
    test(
        "should call the [RemoteDataSource.getUsers] and return [List<User>] "
            "when call to remote source successful", () async {
      when(() => remoteDataSource.getUsers()).thenAnswer(
            (_) async => [],
      );
      final result = await repoImpl.getUsers();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        "should return a [ServerFailure] when the call to the"
            " remote source is unsuccessful", () async {
      when(() => remoteDataSource.getUsers()).thenThrow(
        tException,
      );
      final result = await repoImpl.getUsers();

      expect(result, equals(Left(APIFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
