import 'package:group_flutter_pages_demo/core/theme/app_theme.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:group_flutter_pages_demo/features/home/home_page.dart";
import "package:group_flutter_pages_demo/features/members/members_page.dart";
import "package:group_flutter_pages_demo/features/tasks/tasks_page.dart";
import "package:group_flutter_pages_demo/features/evidence/evidence_page.dart";
import "package:group_flutter_pages_demo/features/members/member_detail_page.dart";
import "package:group_flutter_pages_demo/features/roadmap/roadmap_page.dart";

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      ShellRoute(
        builder: (context, state, child) => _AppShell(child: child),
        routes: [
          GoRoute(
            path: "/",
            name: "home",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: "/members",
            name: "members",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MembersPage(),
            ),
          ),
          GoRoute(
            path: "/tasks",
            name: "tasks",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TasksPage(),
            ),
          ),
          GoRoute(
            path: "/evidence",
            name: "evidence",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EvidencePage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: "/members/:id",
        name: "memberDetail",
        builder: (context, state) {
          final id = state.pathParameters["id"]!;
          return MemberDetailPage(memberId: id);
        },
      ),
      GoRoute(
        path: "/roadmap",
        name: "roadmap",
        builder: (context, state) => const RoadmapPage(),
      ),
    ],
  );
});

class _AppShell extends ConsumerWidget {
  final Widget child;
  const _AppShell({required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith("/members")) return 1;
    if (location.startsWith("/tasks")) return 2;
    if (location.startsWith("/evidence")) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go("/"); break;
      case 1: context.go("/members"); break;
      case 2: context.go("/tasks"); break;
      case 3: context.go("/evidence"); break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          final current = ref.read(themeModeProvider);
          ref.read(themeModeProvider.notifier).state =
              current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
        },
        child: Icon(
          Theme.of(context).brightness == Brightness.light
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        animationDuration: const Duration(milliseconds: 300),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "首页",
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: "小组成员",
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: "实验任务",
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_camera_outlined),
            selectedIcon: Icon(Icons.photo_camera),
            label: "运行证据",
          ),
        ],
      ),
    );
  }
}
