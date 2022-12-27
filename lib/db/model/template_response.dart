import 'package:auditdat/db/model/template_response_group.dart';
import 'package:auditdat/db/repo/template_response_group_repo.dart';

class TemplateResponseTableKeys {
  static const String tableName = 'template_responses';

  static const List<String> values = [
    id,
    groupId,
    response,
    colour,
    fail,
    score,
    index
  ];

  static const String id = 'id';
  static const String groupId = 'group_id';
  static const String response = 'response';
  static const String colour = 'colour';
  static const String fail = 'fail';
  static const String score = 'score';
  static const String index = 'position';
}

class TemplateResponse {
  final int id;
  final int groupId;
  final String response;
  final String colour;
  final bool fail;
  final int score;
  final int index;

  const TemplateResponse({
    required this.id,
    required this.groupId,
    required this.response,
    required this.colour,
    required this.fail,
    required this.score,
    required this.index,
  });

  TemplateResponse copy(
          {int? id,
          int? groupId,
          String? response,
          String? colour,
          bool? fail,
          int? score,
          int? index}) =>
      TemplateResponse(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        response: response ?? this.response,
        colour: colour ?? this.colour,
        fail: fail ?? this.fail,
        score: score ?? this.score,
        index: index ?? this.index,
      );

  Future<TemplateResponseGroup?> group() async =>
      await TemplateResponseGroupRepo.instance.get(groupId);

  static TemplateResponse fromJson(Map<String, Object?> json) =>
      TemplateResponse(
        id: json[TemplateResponseTableKeys.id] as int,
        groupId: json[TemplateResponseTableKeys.groupId] as int,
        response: json[TemplateResponseTableKeys.response] as String,
        colour: json[TemplateResponseTableKeys.colour] as String,
        fail: json[TemplateResponseTableKeys.fail] == 1 ,
        score: json[TemplateResponseTableKeys.score] as int,
        index: json[TemplateResponseTableKeys.index] as int,
      );

  Map<String, Object?> toJson() => {
        TemplateResponseTableKeys.id: id,
        TemplateResponseTableKeys.groupId: groupId,
        TemplateResponseTableKeys.response: response,
        TemplateResponseTableKeys.colour: colour,
        TemplateResponseTableKeys.fail: fail ? 1 : 0,
        TemplateResponseTableKeys.score: score,
        TemplateResponseTableKeys.index: index,
      };
}
