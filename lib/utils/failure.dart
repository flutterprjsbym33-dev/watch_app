abstract class Failure{
 final  String errMsg;
  const Failure({required this.errMsg});
}

class NetworkFailure extends Failure{
   const NetworkFailure({required super.errMsg});

}

class ServerFailure extends Failure{
  const ServerFailure({required super.errMsg});

}

class CatchedFailure extends Failure{
  CatchedFailure({required super.errMsg});

}

