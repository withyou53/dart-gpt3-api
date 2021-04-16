import 'package:json_annotation/json_annotation.dart';

part 'completion.g.dart';

@JsonSerializable()
class CompletionApiParameters {
  CompletionApiParameters(this.prompt,
      {this.maxTokens = 16,
      this.temperature = 1,
      this.topP = 1,
      this.n = 1,
      this.stream = false,
      this.logprobs,
      this.echo = false,
      this.stop,
      this.presencePenalty = 0,
      this.frequencyPenalty = 0,
      this.bestOf = 1,
      this.logitBias});

  final String prompt;
  final int maxTokens;
  final num temperature;
  final num topP;
  final int n;
  final bool stream;
  final int? logprobs;
  final bool echo;
  final String? stop;
  final num presencePenalty;
  final num frequencyPenalty;
  final int bestOf;
  final Map<String, num>? logitBias;

  Map<String, dynamic> toJson() => _$CompletionApiParametersToJson(this);
}

/// The API result of a completion task.
@JsonSerializable()
class CompletionApiResult {
  /// The unique id of this result.
  final String id;

  /// What kind of prompt this was, e.g. "text_completion".
  final String object;

  /// A timestamp when the result was generated.
  final int created;

  /// The id of the engine or model used on the OpenAI backend.
  final String model;

  /// The list of n choices generated by GPT-3.
  final List<Choice> choices;

  CompletionApiResult(
      this.id, this.object, this.created, this.model, this.choices);

  factory CompletionApiResult.fromJson(Map<String, dynamic> json) =>
      _$CompletionApiResultFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionApiResultToJson(this);
}

/// A choice in the completion prompt.
@JsonSerializable(includeIfNull: true)
class Choice {
  /// The completion text generated by GPT-3.
  final String text;

  /// The index of the choice in the list.
  final int index;

  /// The logprobs object with further information about the probabilities of tokens.
  /// Only available if the parameter "log_probs" is given in the call.
  final Logprobs? logprobs;

  /// The reason why the text stops, e.g. "length".
  final String finishReason;

  Choice(this.text, this.index, this.finishReason, {this.logprobs});

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable()
class Logprobs {
  /// Offsets of the tokens.
  final List<int> textOffset;

  /// The log probabilities of each token.
  final List<num> tokenLogprobs;

  /// The string representation of each token.
  final List<String> tokens;

  /// The top choices for each token with log probabilities.
  final List<Map<String, num>> topLogprobs;

  Logprobs(this.textOffset, this.tokenLogprobs, this.tokens, this.topLogprobs);

  factory Logprobs.fromJson(Map<String, dynamic> json) =>
      _$LogprobsFromJson(json);

  Map<String, dynamic> toJson() => _$LogprobsToJson(this);
}