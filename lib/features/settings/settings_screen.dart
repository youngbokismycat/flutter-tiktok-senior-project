import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/authentication/vm/auth_vm.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomAnimateGradient(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.pencil_outline,
                      iconStyle: IconStyle(),
                      title: '휘리릭',
                      subtitle: '있어보이는 설정',
                      titleMaxLine: 1,
                      subtitleMaxLine: 1,
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.fingerprint,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: '개인정보 보호',
                      subtitle: '당신의 개인정보가 유츌되기 전에 막으세요',
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: '다크 모드',
                      subtitle: '시스템',
                      trailing: Switch.adaptive(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: '정보',
                      subtitle: '물들다에 대해 더 알아보기',
                    ),
                  ],
                ),
                // 설정 제목을 추가할 수 있습니다
                SettingsGroup(
                  settingsGroupTitle: "계정",
                  items: [
                    SettingsItem(
                      onTap: () =>
                          ref.read(authViewModelProvider.notifier).signOut(),
                      icons: Icons.exit_to_app_rounded,
                      title: "로그아웃",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.repeat,
                      title: "이메일 변경",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.delete_solid,
                      title: "계정 삭제",
                      titleStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
