import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api/link.dart';

class WebLinkScreen extends StatefulWidget {
  const WebLinkScreen({super.key});

  @override
  State<WebLinkScreen> createState() => _WebLinkScreenState();
}

class _WebLinkScreenState extends State<WebLinkScreen> {
  late final WebViewController _controller;
  int _progress = 0;
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _progress = 0),
          onUrlChange: (_) async {
            await _updateNavAvailability();
          },
          onPageFinished: (_) async {
            setState(() => _progress = 100);
            await _updateNavAvailability();
          },
          onProgress: (p) => setState(() => _progress = p),
        ),
      )
      ..loadRequest(Uri.parse(login));
  }

  Future<void> _updateNavAvailability() async {
    final canBack = await _controller.canGoBack();
    final canForward = await _controller.canGoForward();
    if (mounted) {
      setState(() {
        _canGoBack = canBack;
        _canGoForward = canForward;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Link'),
        actions: [
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            tooltip: 'Open home URL',
            icon: const Icon(Icons.home_outlined),
            onPressed: () => _controller.loadRequest(Uri.parse(login)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: _progress < 100
              ? LinearProgressIndicator(
                  value: _progress / 100,
                  minHeight: 3,
                )
              : const SizedBox(height: 3),
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: _canGoBack ? () => _controller.goBack() : null,
            ),
            IconButton(
              tooltip: 'Forward',
              icon: const Icon(Icons.arrow_forward),
              onPressed: _canGoForward ? () => _controller.goForward() : null,
            ),
          ],
        ),
      ),
    );
  }
}
