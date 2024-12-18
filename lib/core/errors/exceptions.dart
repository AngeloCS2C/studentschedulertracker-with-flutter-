class APIException implements Exception{
 final String message;
final int statuscode;

const APIException({ required this.message, required this.statuscode});  
}

class CacheException implements Exception{
 final String message;

const CacheException({ required this.message});
}
class GeneralException implements Exception{
 final String message;

  
  const GeneralException({ required this.message});
}
