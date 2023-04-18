import 'package:fpdart/fpdart.dart';

import 'package:flutter_grocery/domain/core/core.dart';

typedef RepoResult<T> = Future<Either<Failure, T>>;
