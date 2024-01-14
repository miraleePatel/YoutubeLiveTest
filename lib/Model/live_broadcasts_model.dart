class LiveBroadcastsModel {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  Status? status;
  ContentDetails? contentDetails;

  LiveBroadcastsModel(
      {this.kind,
      this.etag,
      this.id,
      this.snippet,
      this.status,
      this.contentDetails});

  LiveBroadcastsModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
        json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    contentDetails = json['contentDetails'] != null
        ? new ContentDetails.fromJson(json['contentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    if (this.snippet != null) {
      data['snippet'] = this.snippet!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.contentDetails != null) {
      data['contentDetails'] = this.contentDetails!.toJson();
    }
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;

  String? scheduledStartTime;
  bool? isDefaultBroadcast;
  String? liveChatId;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.scheduledStartTime,
      this.isDefaultBroadcast,
      this.liveChatId});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    scheduledStartTime = json['scheduledStartTime'];
    isDefaultBroadcast = json['isDefaultBroadcast'];
    liveChatId = json['liveChatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['scheduledStartTime'] = this.scheduledStartTime;
    data['isDefaultBroadcast'] = this.isDefaultBroadcast;
    data['liveChatId'] = this.liveChatId;
    return data;
  }
}

class Default {
  String? url;
  int? width;
  int? height;

  Default({this.url, this.width, this.height});

  Default.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Status {
  String? lifeCycleStatus;
  String? privacyStatus;
  String? recordingStatus;
  bool? selfDeclaredMadeForKids;

  Status(
      {this.lifeCycleStatus,
      this.privacyStatus,
      this.recordingStatus,
      this.selfDeclaredMadeForKids});

  Status.fromJson(Map<String, dynamic> json) {
    lifeCycleStatus = json['lifeCycleStatus'];
    privacyStatus = json['privacyStatus'];
    recordingStatus = json['recordingStatus'];
    selfDeclaredMadeForKids = json['selfDeclaredMadeForKids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lifeCycleStatus'] = this.lifeCycleStatus;
    data['privacyStatus'] = this.privacyStatus;
    data['recordingStatus'] = this.recordingStatus;
    data['selfDeclaredMadeForKids'] = this.selfDeclaredMadeForKids;
    return data;
  }
}

class ContentDetails {
  MonitorStream? monitorStream;
  bool? enableEmbed;
  bool? enableDvr;
  bool? enableContentEncryption;
  bool? startWithSlate;
  bool? recordFromStart;
  bool? enableClosedCaptions;
  String? closedCaptionsType;
  bool? enableLowLatency;
  String? latencyPreference;
  String? projection;
  bool? enableAutoStart;
  bool? enableAutoStop;

  ContentDetails(
      {this.monitorStream,
      this.enableEmbed,
      this.enableDvr,
      this.enableContentEncryption,
      this.startWithSlate,
      this.recordFromStart,
      this.enableClosedCaptions,
      this.closedCaptionsType,
      this.enableLowLatency,
      this.latencyPreference,
      this.projection,
      this.enableAutoStart,
      this.enableAutoStop});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    monitorStream = json['monitorStream'] != null
        ? new MonitorStream.fromJson(json['monitorStream'])
        : null;
    enableEmbed = json['enableEmbed'];
    enableDvr = json['enableDvr'];
    enableContentEncryption = json['enableContentEncryption'];
    startWithSlate = json['startWithSlate'];
    recordFromStart = json['recordFromStart'];
    enableClosedCaptions = json['enableClosedCaptions'];
    closedCaptionsType = json['closedCaptionsType'];
    enableLowLatency = json['enableLowLatency'];
    latencyPreference = json['latencyPreference'];
    projection = json['projection'];
    enableAutoStart = json['enableAutoStart'];
    enableAutoStop = json['enableAutoStop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monitorStream != null) {
      data['monitorStream'] = this.monitorStream!.toJson();
    }
    data['enableEmbed'] = this.enableEmbed;
    data['enableDvr'] = this.enableDvr;
    data['enableContentEncryption'] = this.enableContentEncryption;
    data['startWithSlate'] = this.startWithSlate;
    data['recordFromStart'] = this.recordFromStart;
    data['enableClosedCaptions'] = this.enableClosedCaptions;
    data['closedCaptionsType'] = this.closedCaptionsType;
    data['enableLowLatency'] = this.enableLowLatency;
    data['latencyPreference'] = this.latencyPreference;
    data['projection'] = this.projection;
    data['enableAutoStart'] = this.enableAutoStart;
    data['enableAutoStop'] = this.enableAutoStop;
    return data;
  }
}

class MonitorStream {
  bool? enableMonitorStream;
  int? broadcastStreamDelayMs;
  String? embedHtml;

  MonitorStream(
      {this.enableMonitorStream, this.broadcastStreamDelayMs, this.embedHtml});

  MonitorStream.fromJson(Map<String, dynamic> json) {
    enableMonitorStream = json['enableMonitorStream'];
    broadcastStreamDelayMs = json['broadcastStreamDelayMs'];
    embedHtml = json['embedHtml'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enableMonitorStream'] = this.enableMonitorStream;
    data['broadcastStreamDelayMs'] = this.broadcastStreamDelayMs;
    data['embedHtml'] = this.embedHtml;
    return data;
  }
}
