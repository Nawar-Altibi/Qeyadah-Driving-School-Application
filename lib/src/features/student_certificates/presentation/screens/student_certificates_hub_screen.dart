import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/coordinators/student_certificates_hub_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/widgets/student_certificates_hub_body.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/widgets/student_certificates_hub_skeleton_body.dart';

class StudentCertificatesHubScreen extends StatelessWidget {
  const StudentCertificatesHubScreen({super.key});

  static const String routePath = '/student/certificates';
  static const String routeName = 'student-certificates';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isBlocked =
        context.watch<AuthSessionCubit>().currentSession?.user.isBlocked ??
        false;

    return StudentCertificatesHubScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.studentCertificatesTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<
                StudentCertificatesHubCubit,
                StudentCertificatesHubState
              >(
                builder: (context, state) {
                  return state.apiState.when(
                    initial: () => const StudentCertificatesHubSkeletonBody(),
                    loading: () => const StudentCertificatesHubSkeletonBody(),
                    succeeded: (eligibility) {
                      return RefreshIndicator(
                        onRefresh: () => context
                            .read<StudentCertificatesHubCubit>()
                            .refresh(),
                        child: Column(
                          children: [
                            if (isBlocked)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  AppDesignTokens.spacingMd,
                                  AppDesignTokens.spacingMd,
                                  AppDesignTokens.spacingMd,
                                  0,
                                ),
                                child: AppAlertBanner(
                                  title: l10n.studentHomeBlockedTitle,
                                  message: l10n.studentHomeBlockedMessage,
                                ),
                              ),
                            Expanded(
                              child: StudentCertificatesHubBody(
                                eligibility: eligibility,
                                state: state,
                                isBlocked: isBlocked,
                                onNewRequestTap: () =>
                                    StudentCertificatesNavigation.pushNewRequest(
                                      context: context,
                                    ),
                                onReexamTap: () {
                                  final id = eligibility.activeCertificateId;
                                  if (id == null) return;
                                  StudentCertificatesNavigation.pushReexam(
                                    context: context,
                                    certificateId: id,
                                  );
                                },
                                onHistoryTap: () =>
                                    StudentCertificatesNavigation.pushHistory(
                                      context: context,
                                    ),
                                onViewDetailsTap: () {
                                  final id = eligibility.activeCertificateId;
                                  if (id == null) return;
                                  StudentCertificatesNavigation.pushDetail(
                                    context: context,
                                    certificateId: id,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    failed: (failure, retry) {
                      return Center(
                        child: Padding(
                          padding: PaddingManager.paddingAll16,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                CoreFailureMessageMapper.messageFor(
                                  failure,
                                  l10n,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppDesignTokens.spacingMd),
                              AppButton.primary(
                                label: l10n.retry,
                                onPressed: retry,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}
