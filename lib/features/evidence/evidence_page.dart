import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:group_flutter_pages_demo/shared/widgets/section_header.dart";
import "package:group_flutter_pages_demo/core/theme/app_colors.dart";

class EvidencePage extends ConsumerWidget {
  const EvidencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("运行证据"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.phone_android,
              title: "测试设备信息",
              subtitle: "本应用运行的真实 Android 设备参数",
            ),
            const SizedBox(height: 16),
            _DeviceInfoCard(isDark: isDark),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.camera_alt,
              title: "真机运行照片",
              subtitle: "使用第二部手机手持拍摄的真实运行画面",
            ),
            const SizedBox(height: 16),
            _PhotoGrid(),
            const SizedBox(height: 32),
            const SectionHeader(
              icon: Icons.verified,
              title: "证据标准",
              subtitle: "本实验的证据提交要求",
            ),
            const SizedBox(height: 16),
            _EvidenceStandards(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DeviceInfoCard extends StatelessWidget {
  final bool isDark;
  const _DeviceInfoCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(80),
        ),
      ),
      child: const Column(
        children: [
          _DeviceRow(icon: Icons.phone_android, label: "设备名称", value: "OPPO K12x 5G"),
          _Divider(),
          _DeviceRow(icon: Icons.android, label: "操作系统", value: "ColorOS 15.0 (Android 15)"),
          _Divider(),
          _DeviceRow(icon: Icons.memory, label: "处理器", value: "高通骁龙 695 5G 八核"),
          _Divider(),
          _DeviceRow(icon: Icons.storage, label: "运行内存", value: "12.0 GB + 12.0 GB"),
          _Divider(),
          _DeviceRow(icon: Icons.sd_card, label: "存储空间", value: "256 GB"),
          _Divider(),
          _DeviceRow(icon: Icons.screenshot, label: "屏幕", value: "6.72英寸 2400x1080 FHD+"),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) => const SizedBox(height: 24);
}

class _DeviceRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DeviceRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
        )),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        )),
      ],
    );
  }
}

class _PhotoGrid extends StatelessWidget {
  const _PhotoGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.75,
      children: const [
        _PhotoPlaceholder(label: "照片1", desc: "应用启动页面"),
        _PhotoPlaceholder(label: "照片2", desc: "实验概述页面"),
        _PhotoPlaceholder(label: "照片3", desc: "小组成员列表"),
        _PhotoPlaceholder(label: "照片4", desc: "运行任务列表"),
      ],
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  final String label;
  final String desc;
  const _PhotoPlaceholder({required this.label, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(80),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 40, color: Theme.of(context).colorScheme.onSurface.withAlpha(80)),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
          )),
          Text(desc, style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
          )),
        ],
      ),
    );
  }
}

class _EvidenceStandards extends StatelessWidget {
  const _EvidenceStandards();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withAlpha(15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withAlpha(50)),
      ),
      child: const Column(
        children: [
          _StandardItem(icon: Icons.web_asset_off, title: "禁止 Web 截图", desc: "不能提交浏览器或网页截图"),
          _StandardGap(),
          _StandardItem(icon: Icons.phone_android, title: "禁止模拟器截图", desc: "必须使用真实物理设备"),
          _StandardGap(),
          _StandardItem(icon: Icons.screenshot_monitor_outlined, title: "禁止手机截图", desc: "不能使用手机自带截图功能"),
          _StandardGap(),
          _StandardItem(icon: Icons.camera_alt, title: "必须手持拍摄", desc: "使用第二部手机拍摄手持真机的照片"),
          _StandardGap(),
          _StandardItem(icon: Icons.visibility, title: "清晰展示界面", desc: "照片需清晰显示应用运行界面"),
        ],
      ),
    );
  }
}

class _StandardGap extends StatelessWidget {
  const _StandardGap();
  @override
  Widget build(BuildContext context) => const SizedBox(height: 10);
}

class _StandardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _StandardItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 18, color: Color(0xFF10B981)),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title  ",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
                  ),
                ),
                TextSpan(
                  text: desc,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
