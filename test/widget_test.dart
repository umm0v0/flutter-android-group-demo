import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:group_flutter_pages_demo/app.dart';

void main() {
  testWidgets('App renders home page with main sections', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: App()),
    );

    // 等待异步数据加载
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 验证 Hero 标题渲染
    expect(find.textContaining('温道庚'), findsWidgets);
    expect(find.text('小组成员'), findsOneWidget);
    expect(find.text('项目功能'), findsOneWidget);
    expect(find.text('发布说明'), findsOneWidget);
  });

  testWidgets('Theme toggle button exists', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: App()),
    );

    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    // 主题切换按钮
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });
}
