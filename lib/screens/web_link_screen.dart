import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/link.dart';
import 'offline_screen.dart';

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
  bool _isOffline = false;
  late final Stream<List<ConnectivityResult>> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivityStream.listen((results) {
      final offline = results.contains(ConnectivityResult.none);
      if (mounted && offline != _isOffline) {
        setState(() {
          _isOffline = offline;
        });
        if (!offline) {
          _controller.reload();
        }
      }
    });

    _checkInitialConnectivity();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _progress = 0),
          onUrlChange: (_) async {
            await _updateNavAvailability();
          },
          onNavigationRequest: (request) async {
            final uri = Uri.parse(request.url);
            if (uri.scheme != 'http' && uri.scheme != 'https') {
              // Open non-web schemes externally (tel:, mailto:, etc.)
              await _openExternal(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) async {
            setState(() => _progress = 100);
            await _updateNavAvailability();
          },
          onProgress: (p) => setState(() => _progress = p),
          onWebResourceError: (error) {
            if (mounted) {
              setState(() {
                _isOffline = true;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(login));
  }

  Future<void> _checkInitialConnectivity() async {
    final current = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _isOffline = current == ConnectivityResult.none;
      });
    }
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

  Future<void> _openExternal(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700);
        final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54);
        final valueStyle = Theme.of(context).textTheme.bodyMedium;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('About', style: titleStyle),
          contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Clementine's Cafe", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text('Created by EAF microservice', style: valueStyle),
              const SizedBox(height: 14),
              Text('Website', style: labelStyle),
              const SizedBox(height: 4),
              InkWell(
                onTap: () => _openExternal('https://fouadeaf.github.io/EAF-microservice/'),
                child: const Text(
                  'https://fouadeaf.github.io/EAF-microservice/',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 14),
              Text('Phone', style: labelStyle),
              const SizedBox(height: 4),
              Text('+212 645 994 904\n+212 727 593 647', style: valueStyle),
              const SizedBox(height: 8),
              Text('Email', style: labelStyle),
              const SizedBox(height: 4),
              Text('EAF.microservice@gmail.com', style: valueStyle),
            ],
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isOffline) {
      return OfflineScreen(onRetry: () async {
        final current = await Connectivity().checkConnectivity();
        if (current != ConnectivityResult.none) {
          setState(() => _isOffline = false);
          _controller.loadRequest(Uri.parse(login));
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        title: GestureDetector(
          onTap: _showAboutDialog,
          child: const Text('Clementine\'s Cafe', style: TextStyle(color: Colors.white)),
        ),
        actions: [
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh, color:  Color.fromRGBO(195, 28, 36, 1)),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            tooltip: 'Open home URL',
            icon: const Icon(Icons.home_outlined, color:  Color.fromRGBO(195, 28, 36, 1)),
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
        color: const Color.fromARGB(255, 22, 22, 22),
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
