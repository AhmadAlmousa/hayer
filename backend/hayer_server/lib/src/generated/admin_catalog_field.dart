/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

enum AdminCatalogField implements _is.SerializableModel {
  photos,
  hours,
  phone,
  website,
  price,
  summary;

  static AdminCatalogField fromJson(String name) {
    switch (name) {
      case 'photos':
        return AdminCatalogField.photos;
      case 'hours':
        return AdminCatalogField.hours;
      case 'phone':
        return AdminCatalogField.phone;
      case 'website':
        return AdminCatalogField.website;
      case 'price':
        return AdminCatalogField.price;
      case 'summary':
        return AdminCatalogField.summary;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AdminCatalogField"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
