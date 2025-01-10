import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add headers or other request modifications
    options.headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN';
    print('Sending request to: ${options.baseUrl}${options.path}');
    return handler.next(options); // Continue the request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log or handle the response
    print('Response received: ${response.statusCode}');
    return handler.next(response); // Continue the response
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Handle errors like token expiration
    print('Error occurred: ${err.message}');
    if (err.response?.statusCode == 401) {
      // Handle token refresh logic if needed
    }
    return handler.next(err); // Continue the error handling
  }
}
