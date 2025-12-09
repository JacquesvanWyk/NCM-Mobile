import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/api_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import 'visits_provider.dart';
import 'api_provider.dart';

// Members provider
final membersProvider = StateNotifierProvider<MembersNotifier, AsyncValue<List<MemberModel>>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return MembersNotifier(apiService);
});

class MembersNotifier extends StateNotifier<AsyncValue<List<MemberModel>>> {
  final ApiService _apiService;

  MembersNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadMembers();
  }

  Future<void> loadMembers() async {
    try {
      state = const AsyncValue.loading();

      final municipalityId = await AuthService.getCurrentMunicipalityId();

      final response = await _apiService.getMembers(1, municipalityId);

      state = AsyncValue.data(response.data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<MemberModel> createMember({
    required String idNumber,
    required String name,
    required String surname,
    required DateTime dateOfBirth,
    required String gender,
    required String phoneNumber,
    String? email,
    String? alternativePhone,
    required String address,
    required String suburb,
    required String city,
    required String postalCode,
    required String ward,
    String? votingDistrict,
    int? municipalityId,
  }) async {
    try {
      final finalMunicipalityId = municipalityId ?? await AuthService.getCurrentMunicipalityId();
      if (finalMunicipalityId == null) throw Exception('No municipality found');

      final request = CreateMemberRequest(
        idNumber: idNumber,
        name: name,
        surname: surname,
        dateOfBirth: dateOfBirth,
        gender: gender,
        phoneNumber: phoneNumber,
        email: email,
        alternativePhone: alternativePhone,
        address: address,
        suburb: suburb,
        city: city,
        postalCode: postalCode,
        ward: ward,
        votingDistrict: votingDistrict,
        municipalityId: finalMunicipalityId,
      );

      // DEBUG: Log the request data
      print('DEBUG: Creating member with municipality_id: $finalMunicipalityId');
      print('DEBUG: Request JSON: ${request.toJson()}');

      final newMember = await _apiService.createMember(request);

      // Add to state
      state.whenData((members) {
        state = AsyncValue.data([...members, newMember]);
      });

      return newMember;
    } catch (e) {
      rethrow;
    }
  }

  Future<MemberModel> getMember(int id) async {
    try {
      return await _apiService.getMember(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<MemberModel> updateMember(int id, MemberModel member) async {
    try {
      // TODO: Fix this to use proper UpdateMemberRequest
      // final updatedMember = await _apiService.updateMember(id, member);
      final updatedMember = member; // Temporary fix

      // Update in state
      state.whenData((members) {
        final updatedMembers = members.map((m) {
          return m.id == id ? updatedMember : m;
        }).toList();
        state = AsyncValue.data(updatedMembers);
      });

      return updatedMember;
    } catch (e) {
      rethrow;
    }
  }

  List<MemberModel> searchMembers(String query) {
    return state.whenData((members) {
      if (query.isEmpty) return members;

      final lowerQuery = query.toLowerCase();
      return members.where((member) {
        return member.displayFirstName.toLowerCase().contains(lowerQuery) ||
               member.displayLastName.toLowerCase().contains(lowerQuery) ||
               member.displayPhone.contains(query) ||
               member.displayIdNumber.contains(query) ||
               member.displayMembershipNumber.toLowerCase().contains(lowerQuery);
      }).toList();
    }).valueOrNull ?? [];
  }
}

// Provider for current user member profile
final currentMemberProvider = FutureProvider<MemberModel?>((ref) async {
  return await AuthService.getMemberProfile();
});

// Provider for municipalities
final municipalitiesProvider = FutureProvider<List<MunicipalityModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getMunicipalities();
});