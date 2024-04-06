abstract class BaseApiService {
  final String baseUrl = "newsapi.org";
  final String apiKey = "b2c417a4e881420e9bca47ef090b8734";

  Future<dynamic> getHeadlinesNewsResponse(String url);
  Future<dynamic> getEverythingNewsResponse(String url);

   
}
