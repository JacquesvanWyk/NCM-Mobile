import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/user_model.dart';
import '../../data/models/visit_model.dart';
import '../../data/models/complaint_model.dart';
import '../../data/models/poll_model.dart';
import '../../data/models/supporter_model.dart';
import '../../data/models/vote_submission_request.dart';
import '../../data/models/vote_submission_response.dart';
import '../../data/models/poll_statistics_response.dart';
import '../../data/models/registration_models.dart';

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

  // Member Registration endpoints (ID-based with OTP verification)
  @POST('/api/check-id-number')
  Future<CheckIdNumberResponse> checkIdNumber(@Body() CheckIdNumberRequest request);

  @POST('/api/register-member')
  Future<RegisterMemberResponse> registerMember(@Body() RegisterMemberRequest request);

  @POST('/api/verify-registration')
  Future<VerifyRegistrationResponse> verifyRegistration(@Body() VerifyRegistrationRequest request);

  @POST('/api/resend-verification-code')
  Future<ResendCodeResponse> resendVerificationCode(@Body() ResendCodeRequest request);

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

  @GET('/api/members/search')
  Future<List<MemberModel>> searchMembers(@Query('query') String query);

  @GET('/api/members/membership/{membershipNumber}')
  Future<FindMemberByMembershipNumberResponse> findMemberByMembershipNumber(
    @Path('membershipNumber') String membershipNumber,
  );

  @POST('/api/members/{id}/activate')
  Future<MemberModel> activateMemberAccount(
    @Path('id') int id,
    @Body() ActivateMemberAccountRequest request,
  );

  @POST('/api/visits/create-from-membership')
  Future<VisitModel> createVisitFromMembership(
    @Body() CreateVisitFromMembershipRequest request,
  );

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
  @POST('/api/members/{id}/qr-code')
  Future<QrCodeResponse> generateMemberQrCode(@Path('id') int id);

  @POST('/api/qr-code/verify')
  Future<QrVerifyResponse> verifyQrCode(@Body() QrVerifyRequest request);

  @POST('/api/qr-code/create-visit')
  Future<VisitModel> createVisitFromQr(@Body() QrCreateVisitRequest request);

  // Constitutional requirement: Mobile app features (FR-001 to FR-024)

  // Polls endpoints
  @GET('/api/v1/polls')
  Future<List<PollModel>> getPolls(
    @Query('page') int page,
    @Query('status') String? status,
  );

  @GET('/api/v1/polls/{pollId}')
  Future<PollModel> getPollDetails(@Path('pollId') int pollId);

  @POST('/api/v1/polls/{pollId}/vote')
  Future<VoteSubmissionResponse> submitVote(
    @Path('pollId') int pollId,
    @Body() VoteSubmissionRequest request,
  );

  @GET('/api/v1/polls/{pollId}/statistics')
  Future<PollStatisticsWrapper> getPollStatistics(@Path('pollId') int pollId);

  // Announcements endpoints (ApiPlatform generated)
  @GET('/api/announcements')
  Future<PaginatedResponse<AnnouncementModel>> getAnnouncements(
    @Query('page') int page,
    @Query('priority') String? priority,
  );

  @POST('/api/announcements/{announcementId}/mark-read')
  Future<void> markAnnouncementAsRead(@Path('announcementId') int announcementId);

  // Supporters endpoints
  @GET('/api/supporters')
  Future<PaginatedResponse<SupporterModel>> getSupporters(
    @Query('page') int page,
    @Query('ward') String? ward,
    @Query('registeredVoter') String? registeredVoter,
    @Query('search') String? search,
  );

  @POST('/api/supporters')
  Future<CreateSupporterResponse> createSupporter(@Body() CreateSupporterRequest request);

  @GET('/api/supporters/{id}')
  Future<GetSupporterResponse> getSupporter(@Path('id') int id);

  @GET('/api/supporters/stats')
  Future<SupporterStatsResponse> getSupporterStats();

  // SMS endpoints
  @GET('/api/sms')
  Future<PaginatedResponse<SmsLogModel>> getSmsLogs(
    @Query('page') int page, {
    @Query('status') String? status,
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('search') String? search,
    @Query('per_page') int? perPage,
  });

  @POST('/api/sms')
  Future<SendSmsResponse> sendSms(@Body() SendSmsRequest request);

  @GET('/api/sms/stats')
  Future<SmsStatsResponse> getSmsStats({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
  });

  @GET('/api/sms/{id}')
  Future<SmsLogModel> getSmsLog(@Path('id') int id);

  @POST('/api/sms/{id}/check-status')
  Future<CheckSmsStatusResponse> checkSmsStatus(@Path('id') int id);

  // PayFast configuration
  @GET('/api/payfast/config')
  Future<PayFastConfigResponse> getPayFastConfig();

  // Push Notification endpoints
  @POST('/api/v1/push-notifications/send')
  Future<PushNotificationResponse> sendPushNotification(@Body() PushNotificationRequest request);

  @GET('/api/v1/push-notifications/history')
  Future<PushNotificationHistoryResponse> getPushNotificationHistory(@Query('page') int page);

  @GET('/api/v1/push-notifications/stats')
  Future<PushNotificationStatsResponse> getPushNotificationStats();

  // Events endpoints
  @GET('/api/v1/municipalities/{municipalityId}/events')
  Future<List<EventModel>> getEvents(
    @Path('municipalityId') int municipalityId, {
    @Query('upcoming_only') bool? upcomingOnly,
    @Query('date_from') DateTime? dateFrom,
    @Query('date_to') DateTime? dateTo,
  });

  @GET('/api/v1/municipalities/{municipalityId}/events/{eventId}')
  Future<EventModel> getEventDetail(
    @Path('municipalityId') int municipalityId,
    @Path('eventId') int eventId,
  );

  @POST('/api/v1/municipalities/{municipalityId}/events/{eventId}/rsvp')
  Future<EventRegistrationResponse> submitEventRsvp(
    @Path('municipalityId') int municipalityId,
    @Path('eventId') int eventId,
    @Body() Map<String, dynamic> request,
  );

  // Feedback endpoints (ApiPlatform generated)
  @POST('/api/feedback')
  @MultiPart()
  Future<FeedbackResponse> submitFeedback(@Body() FeedbackRequest request);

  // Payment endpoints (Constitutional requirement: FR-015)
  @POST('/api/v1/payments')
  Future<PaymentResponse> createPayment(@Body() PaymentRequest request);

  @POST('/api/v1/payments/{paymentId}/retry')
  Future<PaymentResponse> retryPayment(@Path('paymentId') int paymentId);

  @GET('/api/v1/payments/history')
  Future<PaginatedResponse<PaymentModel>> getPaymentHistory(
    @Query('page') int page,
  );

  @GET('/api/v1/payments/membership-status')
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

  // Getter for backward compatibility
  String? get userType => user.userType;
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
  final String deviceId;
  final String osVersion;
  final String appVersion;
  final String? fcmToken;

  DeviceInfo({
    required this.deviceName,
    required this.deviceType,
    required this.deviceId,
    required this.osVersion,
    required this.appVersion,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
        'device_name': deviceName,
        'device_type': deviceType,
        'device_id': deviceId,
        'os_version': osVersion,
        'app_version': appVersion,
        'fcm_token': fcmToken ?? 'unavailable',
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
  ) {
    // Check if pagination is in meta object (Laravel format) or at root level
    final meta = json['meta'] as Map<String, dynamic>?;
    final hasMeta = meta != null;

    return PaginatedResponse(
      data: (json['data'] as List).map((e) => fromJson(e)).toList(),
      currentPage: hasMeta ? meta['current_page'] : json['current_page'],
      lastPage: hasMeta ? meta['last_page'] : json['last_page'],
      total: hasMeta ? meta['total'] : json['total'],
      perPage: hasMeta ? meta['per_page'] : json['per_page'],
    );
  }
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
  final String name;
  final String surname;
  final DateTime dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String? email;
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
    required this.name,
    required this.surname,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    this.email,
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
        'name': name,
        'surname': surname,
        'date_of_birth': dateOfBirth.toIso8601String().split('T')[0],
        'gender': gender,
        'phone_number': phoneNumber,
        'email': email,
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
  final int municipalityId;
  final String title;
  final String description;
  final String? eventType;
  final DateTime eventDate;
  final String location;
  final int? capacity;
  final bool registrationRequired;
  final DateTime? registrationDeadline;
  final String status;
  final String? userRsvpStatus;
  final int userGuestsCount;
  final int totalAttending;

  EventModel({
    required this.id,
    required this.municipalityId,
    required this.title,
    required this.description,
    this.eventType,
    required this.eventDate,
    required this.location,
    this.capacity,
    required this.registrationRequired,
    this.registrationDeadline,
    required this.status,
    this.userRsvpStatus,
    this.userGuestsCount = 0,
    this.totalAttending = 0,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'],
        municipalityId: json['municipality_id'] ?? 0,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        eventType: json['event_type'],
        eventDate: json['event_date'] != null
            ? DateTime.parse(json['event_date'])
            : DateTime.now(),
        location: json['location'] ?? '',
        capacity: json['capacity'],
        registrationRequired: json['registration_required'] ?? false,
        registrationDeadline: json['registration_deadline'] != null
            ? DateTime.parse(json['registration_deadline'])
            : null,
        status: json['status'] ?? 'published',
        userRsvpStatus: json['user_rsvp_status'],
        userGuestsCount: json['user_guests_count'] ?? 0,
        totalAttending: json['total_attending'] ?? 0,
      );

  // Computed getters
  bool get isEventFull => capacity != null && totalAttending >= capacity!;
  int get availableSpots => capacity != null ? capacity! - totalAttending : 999;
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
  final int? daysUntilExpiry;
  final bool isExpired;
  final bool isPaid;

  MembershipStatusResponse({
    required this.isActive,
    this.expiresAt,
    required this.status,
    required this.paymentDue,
    this.nextPaymentAmount,
    this.nextPaymentDate,
    this.daysUntilExpiry,
    this.isExpired = false,
    this.isPaid = false,
  });

  factory MembershipStatusResponse.fromJson(Map<String, dynamic> json) {
    // Handle nested membership object from API
    final data = json['membership'] ?? json;

    final isExpired = data['is_expired'] ?? false;
    final isPaid = data['is_paid'] ?? false;

    return MembershipStatusResponse(
      isActive: !isExpired && isPaid,
      expiresAt: data['expires_at'] != null
          ? DateTime.parse(data['expires_at'])
          : null,
      status: data['status'] ?? 'inactive',
      paymentDue: isExpired || !isPaid,
      nextPaymentAmount: data['renewal_amount']?.toString(),
      nextPaymentDate: null,
      daysUntilExpiry: data['days_until_expiry'],
      isExpired: isExpired,
      isPaid: isPaid,
    );
  }
}

// FindMemberByMembershipNumberResponse
class FindMemberByMembershipNumberResponse {
  final MemberModel? member;

  FindMemberByMembershipNumberResponse({this.member});

  factory FindMemberByMembershipNumberResponse.fromJson(Map<String, dynamic> json) =>
      FindMemberByMembershipNumberResponse(
        member: json['member'] != null ? MemberModel.fromJson(json['member']) : null,
      );
}

// ActivateMemberAccountRequest
class ActivateMemberAccountRequest {
  final String password;

  ActivateMemberAccountRequest({required this.password});

  Map<String, dynamic> toJson() => {
        'password': password,
      };
}

// CreateVisitFromMembershipRequest
class CreateVisitFromMembershipRequest {
  final String membershipNumber;
  final int leaderId;

  CreateVisitFromMembershipRequest({
    required this.membershipNumber,
    required this.leaderId,
  });

  Map<String, dynamic> toJson() => {
        'membership_number': membershipNumber,
        'leader_id': leaderId,
      };
}

// CreateSupporterRequest
class CreateSupporterRequest {
  final String name;
  final String surname;
  final String? email;
  final String telephone;
  final String? address;
  final String ward;
  final bool registeredVoter;
  final String? voter;
  final String? specialVote;
  final String? picture;

  CreateSupporterRequest({
    required this.name,
    required this.surname,
    this.email,
    required this.telephone,
    this.address,
    required this.ward,
    required this.registeredVoter,
    this.voter,
    this.specialVote,
    this.picture,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'email': email,
        'telephone': telephone,
        'address': address,
        'ward': ward,
        'registered_voter': registeredVoter,
        'voter': voter,
        'special_vote': specialVote,
        'picture': picture,
      };
}

// CreateSupporterResponse
class CreateSupporterResponse {
  final SupporterModel supporter;

  CreateSupporterResponse({required this.supporter});

  factory CreateSupporterResponse.fromJson(Map<String, dynamic> json) =>
      CreateSupporterResponse(
        supporter: SupporterModel.fromJson(json['supporter']),
      );
}

// GetSupporterResponse
class GetSupporterResponse {
  final SupporterModel supporter;

  GetSupporterResponse({required this.supporter});

  factory GetSupporterResponse.fromJson(Map<String, dynamic> json) =>
      GetSupporterResponse(
        supporter: SupporterModel.fromJson(json['supporter']),
      );
}

// SupporterStatsResponse
class SupporterStatsResponse {
  final int total;
  final int registeredVoters;
  final int willVote;
  final int needsSpecialVote;
  final int approved;

  SupporterStatsResponse({
    required this.total,
    required this.registeredVoters,
    required this.willVote,
    required this.needsSpecialVote,
    required this.approved,
  });

  factory SupporterStatsResponse.fromJson(Map<String, dynamic> json) =>
      SupporterStatsResponse(
        total: json['total'] ?? 0,
        registeredVoters: json['registered_voters'] ?? 0,
        willVote: json['will_vote'] ?? 0,
        needsSpecialVote: json['needs_special_vote'] ?? 0,
        approved: json['approved'] ?? 0,
      );

  // Getter for backward compatibility
  int get specialVote => needsSpecialVote;
}

// SMS Models
class SmsLogModel {
  final int id;
  final String messageId;
  final String recipient;
  final String? recipientName;
  final String messageContent;
  final String status;
  final DateTime? sentAt;
  final DateTime? deliveredAt;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  SmsLogModel({
    required this.id,
    required this.messageId,
    required this.recipient,
    this.recipientName,
    required this.messageContent,
    required this.status,
    this.sentAt,
    this.deliveredAt,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SmsLogModel.fromJson(Map<String, dynamic> json) => SmsLogModel(
        id: json['id'],
        messageId: json['message_id'],
        recipient: json['recipient'],
        recipientName: json['recipient_name'],
        messageContent: json['message_content'] ?? '',
        status: json['status'] ?? 'pending',
        sentAt: json['sent_at'] != null ? DateTime.parse(json['sent_at']) : null,
        deliveredAt: json['delivered_at'] != null ? DateTime.parse(json['delivered_at']) : null,
        errorMessage: json['error_message'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  // Helper getters for status checking
  bool get isPending => status == 'pending';
  bool get isSent => status == 'sent';
  bool get isDelivered => status == 'delivered';
  bool get isFailed => status == 'failed' || status == 'rejected' || status == 'expired';
}

class SendSmsRequest {
  final String recipient;
  final String message;
  final String? recipientName;

  SendSmsRequest({
    required this.recipient,
    required this.message,
    this.recipientName,
  });

  Map<String, dynamic> toJson() => {
        'recipient': recipient,
        'message': message,
        if (recipientName != null) 'recipient_name': recipientName,
      };
}

class SendSmsResponse {
  final bool success;
  final String message;
  final SmsLogModel? smsLog;
  final bool? error;

  SendSmsResponse({
    required this.success,
    required this.message,
    this.smsLog,
    this.error,
  });

  factory SendSmsResponse.fromJson(Map<String, dynamic> json) => SendSmsResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        smsLog: json['sms_log'] != null ? SmsLogModel.fromJson(json['sms_log']) : null,
        error: json['error'],
      );
}

class SmsStatsResponse {
  final int total;
  final int pending;
  final int sent;
  final int delivered;
  final int failed;

  SmsStatsResponse({
    required this.total,
    required this.pending,
    required this.sent,
    required this.delivered,
    required this.failed,
  });

  factory SmsStatsResponse.fromJson(Map<String, dynamic> json) => SmsStatsResponse(
        total: json['total'] ?? 0,
        pending: json['pending'] ?? 0,
        sent: json['sent'] ?? 0,
        delivered: json['delivered'] ?? 0,
        failed: json['failed'] ?? 0,
      );
}

class CheckSmsStatusResponse {
  final bool success;
  final String message;
  final SmsLogModel smsLog;

  CheckSmsStatusResponse({
    required this.success,
    required this.message,
    required this.smsLog,
  });

  factory CheckSmsStatusResponse.fromJson(Map<String, dynamic> json) => CheckSmsStatusResponse(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        smsLog: SmsLogModel.fromJson(json['sms_log']),
      );
}

// PayFast Configuration Response
class PayFastConfigResponse {
  final String merchantId;
  final String merchantKey;
  final String returnUrl;
  final String cancelUrl;
  final String notifyUrl;
  final String passphrase;
  final bool testing;
  final String processUrl;

  PayFastConfigResponse({
    required this.merchantId,
    required this.merchantKey,
    required this.returnUrl,
    required this.cancelUrl,
    required this.notifyUrl,
    required this.passphrase,
    required this.testing,
    required this.processUrl,
  });

  factory PayFastConfigResponse.fromJson(Map<String, dynamic> json) => PayFastConfigResponse(
        merchantId: json['merchant_id'] ?? '',
        merchantKey: json['merchant_key'] ?? '',
        returnUrl: json['return_url'] ?? '',
        cancelUrl: json['cancel_url'] ?? '',
        notifyUrl: json['notify_url'] ?? '',
        passphrase: json['passphrase'] ?? '',
        testing: json['testing'] ?? true,
        processUrl: json['process_url'] ?? 'https://sandbox.payfast.co.za/eng/process',
      );
}

// Push Notification Models
class PushNotificationRequest {
  final String title;
  final String body;
  final String recipientType;
  final Map<String, dynamic>? data;
  final String? clickAction;

  PushNotificationRequest({
    required this.title,
    required this.body,
    required this.recipientType,
    this.data,
    this.clickAction,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
    'recipient_type': recipientType,
    if (data != null) 'data': data,
    if (clickAction != null) 'click_action': clickAction,
  };
}

class PushNotificationResponse {
  final String message;
  final PushNotificationData notification;

  PushNotificationResponse({
    required this.message,
    required this.notification,
  });

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) => PushNotificationResponse(
    message: json['message'] ?? '',
    notification: PushNotificationData.fromJson(json['notification']),
  );
}

class PushNotificationData {
  final int id;
  final String status;
  final int sentCount;
  final int failedCount;

  PushNotificationData({
    required this.id,
    required this.status,
    required this.sentCount,
    required this.failedCount,
  });

  factory PushNotificationData.fromJson(Map<String, dynamic> json) => PushNotificationData(
    id: json['id'],
    status: json['status'],
    sentCount: json['sent_count'] ?? 0,
    failedCount: json['failed_count'] ?? 0,
  );
}

class PushNotificationHistoryResponse {
  final List<PushNotificationHistoryItem> data;
  final int total;
  final int currentPage;
  final int lastPage;

  PushNotificationHistoryResponse({
    required this.data,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory PushNotificationHistoryResponse.fromJson(Map<String, dynamic> json) => PushNotificationHistoryResponse(
    data: (json['data'] as List).map((item) => PushNotificationHistoryItem.fromJson(item)).toList(),
    total: json['total'] ?? 0,
    currentPage: json['current_page'] ?? 1,
    lastPage: json['last_page'] ?? 1,
  );
}

class PushNotificationHistoryItem {
  final int id;
  final String title;
  final String body;
  final String status;
  final int sentCount;
  final int failedCount;
  final DateTime? sentAt;
  final DateTime createdAt;

  PushNotificationHistoryItem({
    required this.id,
    required this.title,
    required this.body,
    required this.status,
    required this.sentCount,
    required this.failedCount,
    this.sentAt,
    required this.createdAt,
  });

  factory PushNotificationHistoryItem.fromJson(Map<String, dynamic> json) => PushNotificationHistoryItem(
    id: json['id'],
    title: json['title'] ?? '',
    body: json['body'] ?? '',
    status: json['status'] ?? 'pending',
    sentCount: json['sent_count'] ?? 0,
    failedCount: json['failed_count'] ?? 0,
    sentAt: json['sent_at'] != null ? DateTime.parse(json['sent_at']) : null,
    createdAt: DateTime.parse(json['created_at']),
  );
}

class PushNotificationStatsResponse {
  final int total;
  final int sent;
  final int pending;
  final int failed;
  final int totalRecipients;
  final int successfulDeliveries;

  PushNotificationStatsResponse({
    required this.total,
    required this.sent,
    required this.pending,
    required this.failed,
    required this.totalRecipients,
    required this.successfulDeliveries,
  });

  factory PushNotificationStatsResponse.fromJson(Map<String, dynamic> json) => PushNotificationStatsResponse(
    total: json['total'] ?? 0,
    sent: json['sent'] ?? 0,
    pending: json['pending'] ?? 0,
    failed: json['failed'] ?? 0,
    totalRecipients: json['total_recipients'] ?? 0,
    successfulDeliveries: json['successful_deliveries'] ?? 0,
  );
}