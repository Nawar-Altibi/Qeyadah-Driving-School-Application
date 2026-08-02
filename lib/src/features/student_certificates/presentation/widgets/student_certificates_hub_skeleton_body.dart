import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';

class StudentCertificatesHubSkeletonBody extends StatelessWidget {
  const StudentCertificatesHubSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: ListView(
        padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
        children: const [
          AppCard(
            child: SizedBox(
              height: 96,
              width: double.infinity,
              child: Text('Loading certificate summary'),
            ),
          ),
          SizedBox(height: AppDesignTokens.spacingMd),
          AppCard(
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Text('Loading certificate actions'),
            ),
          ),
        ],
      ),
    );
  }
}
