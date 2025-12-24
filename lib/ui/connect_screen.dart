import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/session_controller.dart'; // adjust import to your actual path

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key, this.isAddingSite = false});

  final bool isAddingSite;

  @override
  ConsumerState<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends ConsumerState<ConnectScreen> {
  final _formKey = GlobalKey<FormState>();

  final _siteUrlCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _appPassCtrl = TextEditingController();
  final _labelCtrl = TextEditingController();

  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _siteUrlCtrl.dispose();
    _usernameCtrl.dispose();
    _appPassCtrl.dispose();
    _labelCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _error = null;
    });

    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref.read(sessionControllerProvider.notifier).addSite(
            siteUrl: _siteUrlCtrl.text,
            username: _usernameCtrl.text,
            appPassword: _appPassCtrl.text,
            label: _labelCtrl.text.trim().isEmpty ? null : _labelCtrl.text.trim(),
          );

      if (!mounted) return;

      if (widget.isAddingSite) {
        Navigator.of(context).pop(); // ✅ pop ONLY after success
      }
      // else: AppGate will notice session exists and route forward
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAddingSite ? 'Add site' : 'Connect to WordPress'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_error != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _siteUrlCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Site URL',
                    hintText: 'https://example.com',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _appPassCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Application Password',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  enabled: !_isSubmitting,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _labelCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Label (optional)',
                    hintText: 'Work, Personal, Client A…',
                  ),
                  enabled: !_isSubmitting,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(widget.isAddingSite ? 'Add site' : 'Connect'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
