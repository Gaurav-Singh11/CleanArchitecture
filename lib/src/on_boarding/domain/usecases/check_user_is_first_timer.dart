import 'package:tdd_flutter/core/usecases/usercases.dart';
import 'package:tdd_flutter/core/utils/typedefs.dart';
import 'package:tdd_flutter/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() async => _repo.checkIfUserIsFirstTimer();
}
