import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String paymentToken;
  final String iframeId;
  final Function(String transactionId) onSuccess;
  final VoidCallback onFailure;

  const PaymobWebView({
    super.key,
    required this.paymentToken,
    required this.iframeId,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<PaymobWebView> createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _checkUrl(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebResourceError: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_checkUrl(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/${widget.iframeId}?payment_token=${widget.paymentToken}'));
  }

  bool _checkUrl(String url) {
    debugPrint('Navigating to: $url');
    // Paymob success redirect usually contains 'success=true' and 'id=' (transaction id)
    if (url.contains('success=true') && url.contains('id=')) {
      final uri = Uri.parse(url);
      final transactionId = uri.queryParameters['id'];
      if (transactionId != null) {
        widget.onSuccess(transactionId);
        return true;
      }
    } else if (url.contains('success=false')) {
      widget.onFailure();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Payment'),
        backgroundColor: const Color(0xFFE30613),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE30613),
              ),
            ),
        ],
      ),
    );
  }
}
