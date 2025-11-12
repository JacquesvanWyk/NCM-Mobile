/// South African ID Number Parser
///
/// Parses and validates 13-digit SA ID numbers
/// Format: YYMMDDSSSSCAZ
/// - YYMMDD: Date of birth
/// - SSSS: Gender sequence (0000-4999 female, 5000-9999 male)
/// - C: Citizenship (0=SA citizen, 1=permanent resident)
/// - A: Race (deprecated, was used until 1980)
/// - Z: Checksum digit (Luhn algorithm)

class SaIdParser {
  final String idNumber;

  SaIdParser(this.idNumber);

  /// Validate if the ID number is valid
  bool isValid() {
    // Must be exactly 13 digits
    if (idNumber.length != 13) return false;
    if (!RegExp(r'^\d{13}$').hasMatch(idNumber)) return false;

    // Validate using Luhn algorithm
    return _validateLuhnChecksum();
  }

  /// Parse date of birth from ID number
  /// Returns null if invalid
  DateTime? getDateOfBirth() {
    if (idNumber.length < 6) return null;

    try {
      final year = int.parse(idNumber.substring(0, 2));
      final month = int.parse(idNumber.substring(2, 4));
      final day = int.parse(idNumber.substring(4, 6));

      // Determine century: years < 30 are 20xx, >= 30 are 19xx
      final fullYear = year < 30 ? 2000 + year : 1900 + year;

      // Validate month and day ranges
      if (month < 1 || month > 12) return null;
      if (day < 1 || day > 31) return null;

      return DateTime(fullYear, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Get gender from ID number
  /// Returns 'Male', 'Female', or null if invalid
  String? getGender() {
    if (idNumber.length < 10) return null;

    try {
      final genderSequence = int.parse(idNumber.substring(6, 10));

      // 0000-4999: Female
      // 5000-9999: Male
      return genderSequence < 5000 ? 'Female' : 'Male';
    } catch (e) {
      return null;
    }
  }

  /// Get citizenship status
  /// Returns 'SA Citizen', 'Permanent Resident', or null if invalid
  String? getCitizenshipStatus() {
    if (idNumber.length < 11) return null;

    try {
      final citizenshipDigit = int.parse(idNumber.substring(10, 11));

      // 0: South African citizen
      // 1: Permanent resident
      return citizenshipDigit == 0 ? 'SA Citizen' : 'Permanent Resident';
    } catch (e) {
      return null;
    }
  }

  /// Validate checksum using Luhn algorithm
  bool _validateLuhnChecksum() {
    try {
      int sum = 0;
      bool alternate = false;

      // Process digits from right to left
      for (int i = idNumber.length - 1; i >= 0; i--) {
        int digit = int.parse(idNumber[i]);

        if (alternate) {
          digit *= 2;
          if (digit > 9) {
            digit = (digit % 10) + 1;
          }
        }

        sum += digit;
        alternate = !alternate;
      }

      return (sum % 10) == 0;
    } catch (e) {
      return false;
    }
  }

  /// Get all parsed information as a map
  Map<String, dynamic> parseAll() {
    return {
      'idNumber': idNumber,
      'isValid': isValid(),
      'dateOfBirth': getDateOfBirth(),
      'gender': getGender(),
      'citizenshipStatus': getCitizenshipStatus(),
    };
  }

  /// Extract and format date of birth as string
  String? getFormattedDateOfBirth() {
    final dob = getDateOfBirth();
    if (dob == null) return null;

    return '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';
  }

  /// Get age from ID number
  int? getAge() {
    final dob = getDateOfBirth();
    if (dob == null) return null;

    final now = DateTime.now();
    int age = now.year - dob.year;

    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }
}

/// Utility class for finding ID numbers in text
class IdNumberExtractor {
  /// Find potential SA ID numbers in a string
  /// Returns list of 13-digit numbers found
  static List<String> findIdNumbers(String text) {
    final pattern = RegExp(r'\b\d{13}\b');
    final matches = pattern.allMatches(text);

    return matches.map((match) => match.group(0)!).toList();
  }

  /// Find and validate ID numbers in text
  /// Returns only valid ID numbers
  static List<String> findValidIdNumbers(String text) {
    final potentialIds = findIdNumbers(text);

    return potentialIds.where((id) {
      final parser = SaIdParser(id);
      return parser.isValid();
    }).toList();
  }

  /// Extract best ID number from OCR text
  /// Prioritizes valid IDs and returns the first one found
  static String? extractBestIdNumber(String text) {
    final validIds = findValidIdNumbers(text);

    if (validIds.isNotEmpty) {
      return validIds.first;
    }

    // If no valid IDs found, return first 13-digit sequence
    final potentialIds = findIdNumbers(text);
    return potentialIds.isNotEmpty ? potentialIds.first : null;
  }
}
