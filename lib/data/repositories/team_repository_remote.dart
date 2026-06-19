import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:group_flutter_pages_demo/data/repositories/team_repository.dart';
import 'package:group_flutter_pages_demo/data/repositories/team_repository_local.dart';
import 'package:group_flutter_pages_demo/models/team_member.dart';
import 'package:group_flutter_pages_demo/models/project_feature.dart';
import 'package:group_flutter_pages_demo/models/release_note.dart';

/// 通过 dio 从 GitHub Raw 远程加载团队数据，网络异常时回退到本地数据源。
class RemoteTeamRepository implements ITeamRepository {
  RemoteTeamRepository({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// GitHub Raw 数据地址，push 到 main 分支后即可访问
  static const String _remoteUrl =
      'https://raw.githubusercontent.com/umm0v0/flutter-android-group-demo/main/assets/data/team_data.json';

  /// IconData 字符串到 IconData 的映射表
  static const Map<String, IconData> _iconMap = {
    'phone_android': Icons.phone_android,
    'account_tree': Icons.account_tree,
    'merge_type': Icons.merge_type,
    'developer_mode': Icons.developer_mode,
    'camera_alt': Icons.camera_alt,
  };

  @override
  Future<TeamPageData> getTeamData() async {
    try {
      final resp = await _dio.get<String>(
        _remoteUrl,
        options: Options(responseType: ResponseType.plain),
      );
      final json = jsonDecode(resp.data ?? '{}') as Map<String, dynamic>;
      return _parse(json);
    } catch (_) {
      // 网络异常时回退到本地数据，保证离线可用
      return LocalTeamRepository().getTeamData();
    }
  }

  @override
  TeamMember? getMemberById(String id) =>
      LocalTeamRepository().getMemberById(id);

  TeamPageData _parse(Map<String, dynamic> json) {
    return TeamPageData(
      projectTitle: json['projectTitle'] as String? ?? '',
      projectSlogan: json['projectSlogan'] as String? ?? '',
      members: (json['members'] as List<dynamic>? ?? [])
          .map((e) => _parseMember(e as Map<String, dynamic>))
          .toList(),
      features: (json['features'] as List<dynamic>? ?? [])
          .map((e) => _parseFeature(e as Map<String, dynamic>))
          .toList(),
      releaseNotes: (json['releaseNotes'] as List<dynamic>? ?? [])
          .map((e) => _parseReleaseNote(e as Map<String, dynamic>))
          .toList(),
    );
  }

  TeamMember _parseMember(Map<String, dynamic> e) => TeamMember(
        id: e['id'] as String? ?? '',
        name: e['name'] as String? ?? '',
        role: e['role'] as String? ?? '',
        task: e['task'] as String? ?? '',
        bio: e['bio'] as String? ?? '',
        skills: (e['skills'] as List<dynamic>? ?? [])
            .map((s) => s.toString())
            .toList(),
        avatarUrl: e['avatarUrl'] as String? ?? '',
        githubUrl: e['githubUrl'] as String? ?? '',
      );

  ProjectFeature _parseFeature(Map<String, dynamic> e) => ProjectFeature(
        icon: _iconMap[e['icon'] as String?] ?? Icons.star,
        title: e['title'] as String? ?? '',
        description: e['description'] as String? ?? '',
        color: _parseColor(e['color'] as String?),
      );

  ReleaseNote _parseReleaseNote(Map<String, dynamic> e) => ReleaseNote(
        version: e['version'] as String? ?? '',
        date: e['date'] as String? ?? '',
        title: e['title'] as String? ?? '',
        description: e['description'] as String? ?? '',
        type: _parseReleaseType(e['type'] as String?),
      );

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.indigo;
    final value = int.tryParse(hex);
    return value != null ? Color(value) : Colors.indigo;
  }

  ReleaseNoteType _parseReleaseType(String? s) {
    switch (s) {
      case 'feature':
        return ReleaseNoteType.feature;
      case 'bugfix':
        return ReleaseNoteType.bugfix;
      case 'deploy':
        return ReleaseNoteType.deploy;
      default:
        return ReleaseNoteType.release;
    }
  }
}
