import 'package:social/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser profileUser);
  Future<void> toogleFollow(String currentUid, String targetUid);
}
