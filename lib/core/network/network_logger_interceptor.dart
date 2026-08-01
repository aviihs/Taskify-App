import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'scaffold_messenger_key.dart';

/// Interceptor that shows floating yellow notifications at the bottom of the screen
/// whenever an API request is initiated, completed, or failed.
class NetworkLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _showYellowToast(
      icon: Icons.send_rounded,
      title: 'API Requesting...',
      message: '${options.method.toUpperCase()} ${options.path}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode ?? 200;
    _showYellowToast(
      icon: Icons.bolt_rounded,
      title: 'API Response [$status]',
      message: '${response.requestOptions.method.toUpperCase()} ${response.requestOptions.path}',
      isSuccess: true,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode ?? 500;
    final message = err.response?.data?['message']?.toString() ??
        err.message ??
        'Network error occurred';

    _showYellowToast(
      icon: Icons.warning_amber_rounded,
      title: 'API Error [$status]',
      message: message,
      isError: true,
    );
    super.onError(err, handler);
  }

  void _showYellowToast({
    required IconData icon,
    required String title,
    required String message,
    bool isSuccess = false,
    bool isError = false,
  }) {
    final state = rootScaffoldMessengerKey.currentState;
    if (state == null) return;

    // Styling constants
    final backgroundColor = isError
        ? const Color(0xFFD97706) // Deep Yellow / Amber
        : isSuccess
            ? const Color(0xFFEAB308) // Bright Yellow
            : const Color(0xFFFACC15); // Light Accent Yellow

    final textColor = const Color(0xFF1E1B4B); // Deep Dark Text for high contrast

    state.hideCurrentSnackBar();
    state.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: isError ? 3000 : 2000),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: backgroundColor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.yellow.shade700,
            width: 1.5,
          ),
        ),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: textColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
