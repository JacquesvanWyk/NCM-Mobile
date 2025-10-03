import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/user_model.dart';
import '../../data/models/visit_model.dart';
import '../../data/models/complaint_model.dart';
import '../../data/models/poll_model.dart';
import '../../data/models/vote_submission_request.dart';
import '../../data/models/vote_submission_response.dart';
import '../../data/models/poll_statistics_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Authentication endpoints (Constitutional requirement: FR-022, FR-023)
  @POST('/api/v1/auth/mobile-login')
  Future<AuthResponse> login(@Body() MobileLoginRequest request);

  @POST('/api/v1/auth/logout')
  Future<void> logout();

  @GET('/api/v1/auth/user')
  Future<UserModel> getCurrentUser();

  // Members endpoints
  @GET('/members')
  Future<PaginatedResponse<MemberModel>> getMembers(
    @Query('page') int page,
    @Query('municipality_id') int? municipalityId,
  );

  @GET('/members/{id}')
  Future<MemberModel> getMember(@Path('id') int id);

  @POST('/members')
  Future<MemberModel> createMember(@Body() CreateMemberRequest request);

  @PUT('/members/{id}')
  Future<MemberModel> updateMember(
    @Path('id') int id,
    @Body() UpdateMemberRequest request,
  );

  @GET('/members/search')
  Future<MemberModel> searchMember(@Query('id_number') String idNumber);

  // Leaders endpoints
  @GET('/leaders')
  Future<PaginatedResponse<LeaderModel>> getLeaders(
    @Query('page') int page,
    @Query('municipality_id') int? municipalityId,
  );

  @GET('/leaders/{id}')
  Future<LeaderModel> getLeader(@Path('id') int id);

  // Visits endpoints
  @GET('/visits')
  Future<PaginatedResponse<VisitModel>> getVisits(
    @Query('page') int page,
    @Query('leader_id') int? leaderId,
    @Query('member_id') int? memberId,
    @Query('municipality_id') int? municipalityId,
    @Query('visit_type') String? visitType,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
  );

  @POST('/visits')
  Future<VisitModel> createVisit(@Body() CreateVisitRequest request);

  @GET('/visits/{id}')
  Future<VisitModel> getVisit(@Path('id') int id);

  @PUT('/visits/{id}')
  Future<VisitModel> updateVisit(
    @Path('id') int id,
    @Body() UpdateVisitRequest request,
  );

  @PUT('/visits/{id}/assign')
  Future<VisitModel> assignVisit(
    @Path('id') int id,
    @Body() AssignVisitRequest request,
  );

  @POST('/visits/{id}/check-in')
  Future<VisitModel> checkInToVisit(
    @Path('id') int id,
    @Body() CheckInRequest request,
  );

  @POST('/visits/{id}/check-out')
  Future<VisitModel> checkOutFromVisit(
    @Path('id') int id,
    @Body() CheckOutRequest request,
  );

  @DELETE('/visits/{id}')
  Future<void> deleteVisit(@Path('id') int id);

  @GET('/leaders/{leaderId}/visits')
  Future<PaginatedResponse<VisitModel>> getVisitsByLeader(
    @Path('leaderId') int leaderId,
    @Query('page') int page,
  );

  @GET('/visits/sentiment/stats')
  Future<VisitStatsModel> getSentimentStats(
    @Query('municipality_id') int? municipalityId,
    @Query('leader_id') int? leaderId,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
  );

  // Visit Notes endpoints
  @GET('/visit-notes')
  Future<PaginatedResponse<VisitNoteModel>> getVisitNotes(
    @Query('page') int page,
    @Query('visit_id') int? visitId,
  );

  @POST('/visit-notes')
  Future<VisitNoteModel> createVisitNote(@Body() CreateVisitNoteRequest request);

  // Complaints endpoints
  @GET('/complaints')
  Future<PaginatedResponse<ComplaintModel>> getComplaints(
    @Query('page') int page,
    @Query('member_id') int? memberId,
    @Query('municipality_id') int? municipalityId,
    @Query('status') String? status,
    @Query('priority') String? priority,
  );

  @POST('/complaints')
  Future<ComplaintModel> createComplaint(@Body() CreateComplaintRequest request);

  @GET('/complaints/{id}')
  Future<ComplaintModel> getComplaint(@Path('id') int id);

  @PUT('/complaints/{id}')
  Future<ComplaintModel> updateComplaint(
    @Path('id') int id,
    @Body() UpdateComplaintRequest request,
  );

  // Complaint Categories endpoints
  @GET('/complaint-categories')
  Future<List<ComplaintCategoryModel>> getComplaintCategories();

  @GET('/complaint-categories/{id}')
  Future<ComplaintCategoryModel> getComplaintCategory(@Path('id') int id);

  // Municipalities endpoints
  @GET('/municipalities')
  Future<List<MunicipalityModel>> getMunicipalities();

  @GET('/municipalities/{id}')
  Future<MunicipalityModel> getMunicipality(@Path('id') int id);

  // QR Code endpoints
  @POST('/members/{id}/qr-code')
  Future<QrCodeResponse> generateMemberQrCode(@Path('id') int id);

  @POST('/qr-code/verify')
  Future<QrVerifyResponse> verifyQrCode(@Body() QrVerifyRequest request);

  @POST('/qr-code/create-visit')
  Future<VisitModel> createVisitFromQr(@Body() QrCreateVisitRequest request);

  // Constitutional requirement: Mobile app features (FR-001 to FR-024)

  // Polls endpoints (ApiPlatform generated)
  @GET('/api/polls')
  Future<List<PollModel>> getPolls(
    @Query('page') int page,
    @Query('status') String? status,
  );

  @GET('/api/polls/{pollId}')
  Future<PollModel> getPollDetails(@Path('pollId') int pollId);

  @POST('/api/v1/polls/{pollId}/vote')
  Future<VoteSubmissionResponse> submitVote(
    @Path('pollId') int pollId,
    @Body() VoteSubmissionRequest request,
  );

  @GET('/api/polls/{pollId}/statistics')
  Future<PollStatisticsWrapper> getPollStatistics(@Path('pollId') int pollId);

  // Announcements endpoints (ApiPlatform generated)
  @GET('/api/announcements')
  Future<PaginatedResponse<AnnouncementModel>> getAnnouncements(
    @Query('page') int page,
    @Query('priority') String? priority,
  );

  @POST('/api/announcements/{announcementId}/mark-read')
  Future<void> markAnnouncementAsRead(@Path('announcementId') int announcementId);

  // Events endpoints (ApiPlatform generated)
  @GET('/api/events')
  Future<PaginatedResponse<EventModel>> getEvents(
    @Query('page') int page,
    @Query('filter') String filter,
    @Query('type') String? type,
  );

  @POST('/api/events/{eventId}/register')
  Future<EventRegistrationResponse> registerForEvent(@Path('eventId') int eventId);

  @DELETE('/api/events/{eventId}/register')
  Future<void> cancelEventRegistration(@Path('eventId') int eventId);

  // Feedback endpoints (ApiPlatform generated)
  @POST('/api/feedback')
  @MultiPart()
  Future<FeedbackResponse> submitFeedback(@Body() FeedbackRequest request);

  // Payment endpoints (Constitutional requirement: FR-015)
  @POST('/api/payments')
  Future<PaymentResponse> createPayment(@Body() PaymentRequest request);

  @POST('/api/payments/{paymentId}/retry')
  Future<PaymentResponse> retryPayment(@Path('paymentId') int paymentId);

  @GET('/api/payments/history')
  Future<PaginatedResponse<PaymentModel>> getPaymentHistory(
    @Query('page') int page,
  );

  @GET('/api/payments/membership-status')
  Future<MembershipStatusResponse> getMembershipStatus();
}

// Request/Response models
class AuthResponse {
  final UserModel user;
  final MunicipalityModel municipality;
  final String token;

  AuthResponse({
    required this.user,
    required this.municipality,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: UserModel.fromJson(json['user']),
        municipality: MunicipalityModel.fromJson(json['municipality']),
        token: json['token'],
      );
}

class MobileLoginRequest {
  final String email;
  final String password;
  final DeviceInfo deviceInfo;

  MobileLoginRequest({
    required this.email,
    required this.password,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'device_info': deviceInfo.toJson(),
      };
}

class DeviceInfo {
  final String deviceName;
  final String deviceType;
  final String osVersion;
  final String appVersion;
  final String? fcmToken;

  DeviceInfo({
    required this.deviceName,
    required this.deviceType,
    required this.osVersion,
    required this.appVersion,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
        'device_name': deviceName,
        'device_type': deviceType,
        'os_version': osVersion,
        'app_version': appVersion,
        'fcm_token': fcmToken,
      };
}

class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;

  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      PaginatedResponse(
        data: (json['data'] as List).map((e) => fromJson(e)).toList(),
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        total: json['total'],
        perPage: json['per_page'],
      );
}

// Request models for creating/updating resources
class CreateVisitRequest {
  final int memberId;
  final int leaderId;
  final int municipalityId;
  final String visitType;
  final DateTime visitDate;
  final int? durationMinutes;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? locationAddress;
  final int? sentimentScore;
  final String? memberSatisfaction;
  final List<String>? issuesIdentified;
  final bool followUpRequired;
  final DateTime? followUpDate;
  final String? summary;
  final String status;

  CreateVisitRequest({
    required this.memberId,
    required this.leaderId,
    required this.municipalityId,
    required this.visitType,
    required this.visitDate,
    this.durationMinutes,
    this.locationLatitude,
    this.locationLongitude,
    this.locationAddress,
    this.sentimentScore,
    this.memberSatisfaction,
    this.issuesIdentified,
    this.followUpRequired = false,
    this.followUpDate,
    this.summary,
    this.status = 'scheduled',
  });

  Map<String, dynamic> toJson() => {
        'member_id': memberId,
        'leader_id': leaderId,
        'municipality_id': municipalityId,
        'visit_type': visitType,
        'visit_date': visitDate.toIso8601String(),
        'duration_minutes': durationMinutes,
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'location_address': locationAddress,
        'sentiment_score': sentimentScore,
        'member_satisfaction': memberSatisfaction,
        'issues_identified': issuesIdentified,
        'follow_up_required': followUpRequired,
        'follow_up_date': followUpDate?.toIso8601String(),
        'summary': summary,
        'status': status,
      };
}

class UpdateVisitRequest {
  final String? visitType;
  final DateTime? visitDate;
  final int? durationMinutes;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? locationAddress;
  final int? sentimentScore;
  final String? memberSatisfaction;
  final List<String>? issuesIdentified;
  final bool? followUpRequired;
  final DateTime? followUpDate;
  final String? summary;
  final String? status;

  UpdateVisitRequest({
    this.visitType,
    this.visitDate,
    this.durationMinutes,
    this.locationLatitude,
    this.locationLongitude,
    this.locationAddress,
    this.sentimentScore,
    this.memberSatisfaction,
    this.issuesIdentified,
    this.followUpRequired,
    this.followUpDate,
    this.summary,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (visitType != null) 'visit_type': visitType,
        if (visitDate != null) 'visit_date': visitDate!.toIso8601String(),
        if (durationMinutes != null) 'duration_minutes': durationMinutes,
        if (locationLatitude != null) 'location_latitude': locationLatitude,
        if (locationLongitude != null) 'location_longitude': locationLongitude,
        if (locationAddress != null) 'location_address': locationAddress,
        if (sentimentScore != null) 'sentiment_score': sentimentScore,
        if (memberSatisfaction != null) 'member_satisfaction': memberSatisfaction,
        if (issuesIdentified != null) 'issues_identified': issuesIdentified,
        if (followUpRequired != null) 'follow_up_required': followUpRequired,
        if (followUpDate != null) 'follow_up_date': followUpDate!.toIso8601String(),
        if (summary != null) 'summary': summary,
        if (status != null) 'status': status,
      };
}

class CreateVisitNoteRequest {
  final int visitId;
  final int leaderId;
  final String noteType;
  final String content;
  final bool isPrivate;
  final List<String>? attachments;

  CreateVisitNoteRequest({
    required this.visitId,
    required this.leaderId,
    this.noteType = 'general',
    required this.content,
    this.isPrivate = false,
    this.attachments,
  });

  Map<String, dynamic> toJson() => {
        'visit_id': visitId,
        'leader_id': leaderId,
        'note_type': noteType,
        'content': content,
        'is_private': isPrivate,
        'attachments': attachments,
      };
}

class CreateComplaintRequest {
  final int memberId;
  final int? complaintCategoryId;
  final int municipalityId;
  final String title;
  final String description;
  final String priority;
  final String? locationAddress;
  final double? locationLatitude;
  final double? locationLongitude;
  final List<String>? photos;
  final List<String>? documents;
  final String contactMethodPreference;
  final bool isAnonymous;

  CreateComplaintRequest({
    required this.memberId,
    this.complaintCategoryId,
    required this.municipalityId,
    required this.title,
    required this.description,
    this.priority = 'medium',
    this.locationAddress,
    this.locationLatitude,
    this.locationLongitude,
    this.photos,
    this.documents,
    this.contactMethodPreference = 'phone',
    this.isAnonymous = false,
  });

  Map<String, dynamic> toJson() => {
        'member_id': memberId,
        'complaint_category_id': complaintCategoryId,
        'municipality_id': municipalityId,
        'title': title,
        'description': description,
        'priority': priority,
        'location_address': locationAddress,
        'location_latitude': locationLatitude,
        'location_longitude': locationLongitude,
        'photos': photos,
        'documents': documents,
        'contact_method_preference': contactMethodPreference,
        'is_anonymous': isAnonymous,
      };
}

class UpdateComplaintRequest {
  final String? title;
  final String? description;
  final String? priority;
  final String? status;
  final String? locationAddress;
  final double? locationLatitude;
  final double? locationLongitude;
  final List<String>? photos;
  final List<String>? documents;
  final String? contactMethodPreference;
  final String? resolutionNotes;

  UpdateComplaintRequest({
    this.title,
    this.description,
    this.priority,
    this.status,
    this.locationAddress,
    this.locationLatitude,
    this.locationLongitude,
    this.photos,
    this.documents,
    this.contactMethodPreference,
    this.resolutionNotes,
  });

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (priority != null) 'priority': priority,
        if (status != null) 'status': status,
        if (locationAddress != null) 'location_address': locationAddress,
        if (locationLatitude != null) 'location_latitude': locationLatitude,
        if (locationLongitude != null) 'location_longitude': locationLongitude,
        if (photos != null) 'photos': photos,
        if (documents != null) 'documents': documents,
        if (contactMethodPreference != null) 'contact_method_preference': contactMethodPreference,
        if (resolutionNotes != null) 'resolution_notes': resolutionNotes,
      };
}

class CreateMemberRequest {
  final String idNumber;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String? alternativePhone;
  final String address;
  final String suburb;
  final String city;
  final String postalCode;
  final String ward;
  final String? votingDistrict;
  final int municipalityId;

  CreateMemberRequest({
    required this.idNumber,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    this.alternativePhone,
    required this.address,
    required this.suburb,
    required this.city,
    required this.postalCode,
    required this.ward,
    this.votingDistrict,
    required this.municipalityId,
  });

  Map<String, dynamic> toJson() => {
        'id_number': idNumber,
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth.toIso8601String().split('T')[0],
        'gender': gender,
        'phone_number': phoneNumber,
        'alternative_phone': alternativePhone,
        'address': address,
        'suburb': suburb,
        'city': city,
        'postal_code': postalCode,
        'ward': ward,
        'voting_district': votingDistrict,
        'municipality_id': municipalityId,
      };
}

class AssignVisitRequest {
  final int leaderId;

  AssignVisitRequest({required this.leaderId});

  Map<String, dynamic> toJson() => {
        'leader_id': leaderId,
      };
}

class CheckInRequest {
  final double? latitude;
  final double? longitude;
  final String? notes;

  CheckInRequest({
    this.latitude,
    this.longitude,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        if (latitude != null) 'check_in_latitude': latitude,
        if (longitude != null) 'check_in_longitude': longitude,
        if (notes != null) 'check_in_notes': notes,
        'check_in_time': DateTime.now().toIso8601String(),
      };
}

class CheckOutRequest {
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? outcome;
  final int? sentimentScore;
  final String? memberSatisfaction;
  final List<String>? issuesIdentified;
  final bool followUpRequired;

  CheckOutRequest({
    this.latitude,
    this.longitude,
    this.notes,
    this.outcome,
    this.sentimentScore,
    this.memberSatisfaction,
    this.issuesIdentified,
    this.followUpRequired = false,
  });

  Map<String, dynamic> toJson() => {
        if (latitude != null) 'check_out_latitude': latitude,
        if (longitude != null) 'check_out_longitude': longitude,
        if (notes != null) 'summary': notes,
        if (outcome != null) 'outcome': outcome,
        if (sentimentScore != null) 'sentiment_score': sentimentScore,
        if (memberSatisfaction != null) 'member_satisfaction': memberSatisfaction,
        if (issuesIdentified != null) 'issues_identified': issuesIdentified,
        'follow_up_required': followUpRequired,
        'check_out_time': DateTime.now().toIso8601String(),
        'status': 'completed',
      };
}

class UpdateMemberRequest {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? alternativePhone;
  final String? address;
  final String? suburb;
  final String? city;
  final String? postalCode;
  final String? ward;
  final String? votingDistrict;
  final bool? isActive;

  UpdateMemberRequest({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.alternativePhone,
    this.address,
    this.suburb,
    this.city,
    this.postalCode,
    this.ward,
    this.votingDistrict,
    this.isActive,
  });

  Map<String, dynamic> toJson() => {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (alternativePhone != null) 'alternative_phone': alternativePhone,
        if (address != null) 'address': address,
        if (suburb != null) 'suburb': suburb,
        if (city != null) 'city': city,
        if (postalCode != null) 'postal_code': postalCode,
        if (ward != null) 'ward': ward,
        if (votingDistrict != null) 'voting_district': votingDistrict,
        if (isActive != null) 'is_active': isActive,
      };
}

// QR Code models
class QrCodeResponse {
  final String qrData;
  final String qrImage;
  final String expiresAt;

  QrCodeResponse({
    required this.qrData,
    required this.qrImage,
    required this.expiresAt,
  });

  factory QrCodeResponse.fromJson(Map<String, dynamic> json) => QrCodeResponse(
        qrData: json['data']['qr_data'],
        qrImage: json['data']['qr_image'],
        expiresAt: json['data']['expires_at'],
      );
}

class QrVerifyRequest {
  final String qrData;

  QrVerifyRequest({required this.qrData});

  Map<String, dynamic> toJson() => {
        'qr_data': qrData,
      };
}

class QrVerifyResponse {
  final Map<String, dynamic> member;

  QrVerifyResponse({required this.member});

  factory QrVerifyResponse.fromJson(Map<String, dynamic> json) => QrVerifyResponse(
        member: json['member'],
      );
}

class QrCreateVisitRequest {
  final String qrData;
  final String visitType;
  final String purpose;

  QrCreateVisitRequest({
    required this.qrData,
    required this.visitType,
    required this.purpose,
  });

  Map<String, dynamic> toJson() => {
        'qr_data': qrData,
        'visit_type': visitType,
        'purpose': purpose,
      };
}

// New mobile app feature models

// Poll models
class PollModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final List<PollOptionModel> options;
  final bool hasVoted;

  PollModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.options,
    required this.hasVoted,
  });

  factory PollModel.fromJson(Map<String, dynamic> json) => PollModel(
        id: json['id'],
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        status: json['status'] ?? 'active',
        startDate: DateTime.parse(json['startsAt']),
        endDate: DateTime.parse(json['endsAt']),
        options: _parseOptionsFromString(json['options']),
        hasVoted: json['hasVoted'] ?? false,
      );

  static List<PollOptionModel> _parseOptionsFromString(dynamic optionsData) {
    try {
      if (optionsData == null) return [];

      String optionsJson;
      if (optionsData is String) {
        optionsJson = optionsData;
      } else {
        optionsJson = optionsData.toString();
      }

      final List<dynamic> optionsList = jsonDecode(optionsJson);
      return optionsList.asMap().entries.map((entry) {
        final option = entry.value;
        return PollOptionModel(
          id: entry.key + 1, // Simple ID based on index
          text: option['text'] ?? '',
          voteCount: 0, // Will be filled from poll results if available
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}

class PollOptionModel {
  final int id;
  final String text;
  final int voteCount;

  PollOptionModel({
    required this.id,
    required this.text,
    required this.voteCount,
  });

  factory PollOptionModel.fromJson(Map<String, dynamic> json) =>
      PollOptionModel(
        id: json['id'],
        text: json['text'],
        voteCount: json['vote_count'] ?? 0,
      );
}



// Announcement models
class AnnouncementModel {
  final int id;
  final String title;
  final String content;
  final String priority;
  final DateTime publishedAt;
  final bool isRead;
  final String? imageUrl;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.publishedAt,
    required this.isRead,
    this.imageUrl,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        priority: json['priority'],
        publishedAt: DateTime.parse(json['published_at']),
        isRead: json['is_read'] ?? false,
        imageUrl: json['image_url'],
      );
}

// Event models
class EventModel {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String type;
  final int maxAttendees;
  final int currentAttendees;
  final bool isRegistered;
  final String? imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.type,
    required this.maxAttendees,
    required this.currentAttendees,
    required this.isRegistered,
    this.imageUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        location: json['location'],
        type: json['type'],
        maxAttendees: json['max_attendees'] ?? 0,
        currentAttendees: json['current_attendees'] ?? 0,
        isRegistered: json['is_registered'] ?? false,
        imageUrl: json['image_url'],
      );
}

class EventRegistrationResponse {
  final bool success;
  final String message;

  EventRegistrationResponse({
    required this.success,
    required this.message,
  });

  factory EventRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      EventRegistrationResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
      );
}

// Feedback models
class FeedbackRequest {
  final String category;
  final String subject;
  final String message;
  final String priority;
  final List<String>? attachments;

  FeedbackRequest({
    required this.category,
    required this.subject,
    required this.message,
    this.priority = 'medium',
    this.attachments,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'subject': subject,
        'message': message,
        'priority': priority,
        'attachments': attachments,
      };
}

class FeedbackResponse {
  final int id;
  final String referenceNumber;
  final String status;

  FeedbackResponse({
    required this.id,
    required this.referenceNumber,
    required this.status,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      FeedbackResponse(
        id: json['id'],
        referenceNumber: json['reference_number'],
        status: json['status'],
      );
}

// Payment models (Constitutional requirement: FR-015)
class PaymentRequest {
  final String amount;
  final String currency;
  final String description;
  final String paymentMethod;

  PaymentRequest({
    required this.amount,
    this.currency = 'ZAR',
    required this.description,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'currency': currency,
        'description': description,
        'payment_method': paymentMethod,
      };
}

class PaymentResponse {
  final int id;
  final String status;
  final String paymentUrl;
  final String reference;

  PaymentResponse({
    required this.id,
    required this.status,
    required this.paymentUrl,
    required this.reference,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        id: json['id'],
        status: json['status'],
        paymentUrl: json['payment_url'],
        reference: json['reference'],
      );
}

class PaymentModel {
  final int id;
  final String amount;
  final String currency;
  final String description;
  final String status;
  final DateTime createdAt;
  final String reference;

  PaymentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.reference,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        amount: json['amount'],
        currency: json['currency'],
        description: json['description'],
        status: json['status'],
        createdAt: DateTime.parse(json['created_at']),
        reference: json['reference'],
      );
}

class MembershipStatusResponse {
  final bool isActive;
  final DateTime? expiresAt;
  final String status;
  final bool paymentDue;
  final String? nextPaymentAmount;
  final DateTime? nextPaymentDate;

  MembershipStatusResponse({
    required this.isActive,
    this.expiresAt,
    required this.status,
    required this.paymentDue,
    this.nextPaymentAmount,
    this.nextPaymentDate,
  });

  factory MembershipStatusResponse.fromJson(Map<String, dynamic> json) =>
      MembershipStatusResponse(
        isActive: json['is_active'] ?? false,
        expiresAt: json['expires_at'] != null
            ? DateTime.parse(json['expires_at'])
            : null,
        status: json['status'],
        paymentDue: json['payment_due'] ?? false,
        nextPaymentAmount: json['next_payment_amount'],
        nextPaymentDate: json['next_payment_date'] != null
            ? DateTime.parse(json['next_payment_date'])
            : null,
      );
}